// ================================
// 🔐 AUTH INTERCEPTOR - ИНТЕРЦЕПТОР АУТЕНТИФИКАЦИИ
// ================================

import 'package:dio/dio.dart';

import '../api_constants.dart';
import '../../utils/log_utils.dart';

/// 🎯 ПЕРЕХВАТЧИК ДЛЯ РАБОТЫ С АВТОРИЗАЦИЕЙ
///
/// Содержит:
/// - Добавление JWT токенов в заголовки
/// - Обновление access token при истечении
/// - Обработку 401 ошибок (unauthorized)
/// - Логику повторной аутентификации
///
/// Пример работы:
/// 1. Добавляет токен к каждому запросу
/// 2. При 401 ошибке пытается обновить токен
/// 3. Повторяет оригинальный запрос с новым токеном
/// 4. Если обновление не удалось - разлогинивает пользователя
class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final Future<String?> Function() _getToken;
  final Future<String?> Function() _refreshToken;
  final Future<void> Function() _onTokenExpired;

  /// Создание интерцептора аутентификации
  ///
  /// 📝 **Параметры:**
  /// - `dio`: Dio клиент для повторных запросов (должен быть из DI)
  /// - `getToken`: Функция получения текущего токена
  /// - `refreshToken`: Функция обновления токена
  /// - `onTokenExpired`: Функция обработки истечения токена
  AuthInterceptor({
    required Dio dio,
    required Future<String?> Function() getToken,
    required Future<String?> Function() refreshToken,
    required Future<void> Function() onTokenExpired,
  }) : _dio = dio,
       _getToken = getToken,
       _refreshToken = refreshToken,
       _onTokenExpired = onTokenExpired;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // Получаем токен и добавляем в заголовки
      final token = await _getToken();
      if (token != null && token.isNotEmpty) {
        options.headers[ApiConstants.authHeaderKey] =
            '${ApiConstants.bearerPrefix} $token';
        Log.d('🔐 Добавлен токен к запросу: ${options.method} ${options.path}');
      } else {
        Log.d(
          '🔐 Токен отсутствует для запроса: ${options.method} ${options.path}',
        );
      }
    } catch (e, stackTrace) {
      Log.e('❌ Ошибка получения токена', error: e, stackTrace: stackTrace);
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Обрабатываем только 401 ошибки (Unauthorized)
    if (_shouldRefreshToken(err)) {
      Log.w('🔐 Обнаружена 401 ошибка, пытаемся обновить токен...');

      try {
        // Пытаемся обновить токен
        final newToken = await _refreshToken();

        if (newToken != null && newToken.isNotEmpty) {
          Log.i('🔐 Токен успешно обновлен, повторяем запрос');

          // Создаем новый запрос с обновленным токеном
          final newRequest = await _retryRequest(err.requestOptions, newToken);
          handler.resolve(newRequest);
          return;
        } else {
          Log.e('🔐 Не удалось обновить токен, разлогиниваем пользователя');
          await _onTokenExpired();
        }
      } catch (e, stackTrace) {
        Log.e(
          '❌ Ошибка при обновлении токена',
          error: e,
          stackTrace: stackTrace,
        );
        await _onTokenExpired();
      }
    }

    handler.next(err);
  }

  /// Проверяет нужно ли обновлять токен
  bool _shouldRefreshToken(DioException err) {
    return err.response?.statusCode == 401 &&
        err.requestOptions.extra['_retried'] != true;
  }

  /// Повторяет запрос с новым токеном
  Future<Response<dynamic>> _retryRequest(
    RequestOptions options,
    String newToken,
  ) async {
    // Помечаем запрос как повторенный
    options.extra['_retried'] = true;

    // Обновляем заголовки с новым токеном
    options.headers[ApiConstants.authHeaderKey] =
        '${ApiConstants.bearerPrefix} $newToken';

    Log.d(
      '🔐 Повторяем запрос с новым токеном: ${options.method} ${options.path}',
    );

    // ✅ Используем существующий Dio клиент из DI
    return await _dio.fetch<dynamic>(options);
  }
}
