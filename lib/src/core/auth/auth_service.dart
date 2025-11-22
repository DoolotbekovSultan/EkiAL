// ================================
// 🔐 AUTH SERVICE - СЕРВИС АУТЕНТИФИКАЦИИ
// ================================

import 'package:injectable/injectable.dart';
import '../utils/log_utils.dart';
import 'token_service.dart';

/// Сервис аутентификации
///
/// Отвечает за:
/// - Обновление токенов
/// - Обработку истечения токенов
/// - Координацию с TokenService
@injectable
class AuthService {
  final TokenService _tokenService;

  AuthService({required TokenService tokenService}) : _tokenService = tokenService;

  /// Получает текущий access токен
  Future<String?> getToken() async {
    return await _tokenService.getAccessToken();
  }

  /// Обновляет access токен используя refresh токен
  ///
  /// TODO: Реализовать реальный API вызов для обновления токена
  Future<String?> refreshToken() async {
    try {
      Log.d('🔄 Попытка обновления токена...');
      
      final refreshToken = await _tokenService.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        Log.w('⚠️ Refresh токен отсутствует, невозможно обновить access токен');
        return null;
      }

      // TODO: Реализовать реальный API вызов
      // Пример:
      // final dio = getIt<Dio>();
      // final response = await dio.post('/auth/refresh', data: {
      //   'refresh_token': refreshToken,
      // });
      // final newAccessToken = response.data['access_token'];
      // await _tokenService.saveAccessToken(newAccessToken);
      // return newAccessToken;

      // Временная заглушка для демонстрации
      Log.w('⚠️ Обновление токена не реализовано, требуется API интеграция');
      return null;
    } catch (e, stackTrace) {
      Log.e('❌ Ошибка обновления токена', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Обрабатывает истечение токена
  ///
  /// Вызывается когда токен истек и не может быть обновлен
  Future<void> onTokenExpired() async {
    try {
      Log.w('🔐 Токен истек, очищаем данные аутентификации...');
      
      // Очищаем токены
      await _tokenService.clearTokens();
      
      // TODO: Добавить дополнительную логику:
      // - Очистка кэша пользователя
      // - Перенаправление на экран входа
      // - Уведомление пользователя
      
      Log.i('✅ Данные аутентификации очищены');
    } catch (e, stackTrace) {
      Log.e('❌ Ошибка обработки истечения токена', error: e, stackTrace: stackTrace);
    }
  }

  /// Проверяет, авторизован ли пользователь
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty && !_tokenService.isTokenExpired();
  }
}

