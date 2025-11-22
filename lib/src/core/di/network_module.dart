// ================================
// 🌐 NETWORK MODULE - МОДУЛЬ СЕТЕВЫХ ЗАВИСИМОСТЕЙ
// ================================

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../network/interceptors/retry_interceptor.dart';
import '../network/interceptors/logging_interceptor.dart';
import '../utils/log_utils.dart';

/// Модуль для регистрации сетевых зависимостей
@module
abstract class NetworkModule {
  // Этот модуль используется для регистрации сетевых зависимостей
  // Интерцепторы регистрируются через фабрики ниже
}

/// Фабрика для создания AuthInterceptor
///
/// Примечание: AuthInterceptor требует Dio и callback функции.
/// В реальном приложении эти функции должны быть получены из сервисов аутентификации.
@injectable
class AuthInterceptorFactory {
  final Dio _dio;

  AuthInterceptorFactory({required Dio dio}) : _dio = dio;

  /// Создает AuthInterceptor с внедренным Dio
  ///
  /// TODO: Получить функции getToken, refreshToken, onTokenExpired из AuthService
  AuthInterceptor create({
    required Future<String?> Function() getToken,
    required Future<String?> Function() refreshToken,
    required Future<void> Function() onTokenExpired,
  }) {
    return AuthInterceptor(
      dio: _dio,
      getToken: getToken,
      refreshToken: refreshToken,
      onTokenExpired: onTokenExpired,
    );
  }
}

/// Фабрика для создания RetryInterceptor
@injectable
class RetryInterceptorFactory {
  final Dio _dio;

  RetryInterceptorFactory({required Dio dio}) : _dio = dio;

  /// Создает RetryInterceptor с внедренным Dio
  RetryInterceptor create() {
    return RetryInterceptor(dio: _dio);
  }
}

/// Утилита для настройки интерцепторов Dio
///
/// Вызывается после инициализации DI для добавления интерцепторов к Dio
class DioInterceptorConfigurator {
  /// Настраивает интерцепторы для Dio клиента
  ///
  /// Добавляет интерцепторы в правильном порядке:
  /// 1. LoggingInterceptor - логирование
  /// 2. RetryInterceptor - повтор запросов
  /// 3. AuthInterceptor - авторизация
  static void configureInterceptors(
    Dio dio, {
    RetryInterceptor? retryInterceptor,
    AuthInterceptor? authInterceptor,
  }) {
    Log.d('🔧 Настройка интерцепторов для Dio...');

    // Проверяем существующие интерцепторы
    final hasLoggingInterceptor = dio.interceptors.any(
      (interceptor) => interceptor is LoggingInterceptor,
    );
    final hasRetryInterceptor = dio.interceptors.any(
      (interceptor) => interceptor is RetryInterceptor,
    );
    final hasAuthInterceptor = dio.interceptors.any(
      (interceptor) => interceptor is AuthInterceptor,
    );

    // Добавляем интерцепторы в правильном порядке
    // 1. LoggingInterceptor - логирует все запросы/ответы (первым)
    if (!hasLoggingInterceptor) {
      dio.interceptors.insert(0, LoggingInterceptor());
      Log.d('✅ Добавлен LoggingInterceptor');
    }

    // 2. RetryInterceptor - повторяет запросы при ошибках
    if (retryInterceptor != null && !hasRetryInterceptor) {
      dio.interceptors.add(retryInterceptor);
      Log.d('✅ Добавлен RetryInterceptor');
    }

    // 3. AuthInterceptor - добавляет токены и обрабатывает 401 (последним)
    if (authInterceptor != null && !hasAuthInterceptor) {
      dio.interceptors.add(authInterceptor);
      Log.d('✅ Добавлен AuthInterceptor');
    }

    Log.i('✅ Интерцепторы настроены. Всего: ${dio.interceptors.length}');
  }
}

