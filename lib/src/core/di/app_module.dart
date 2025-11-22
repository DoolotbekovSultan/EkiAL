// ================================
// 📱 APP MODULE - ГЛАВНЫЙ МОДУЛЬ ЗАВИСИМОСТЕЙ
// ================================

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../config/app_config.dart';
import '../utils/log_utils.dart';

/// Главный модуль зависимостей приложения
@module
abstract class AppModule {
  // ================================
  // 🌐 ВНЕШНИЕ ЗАВИСИМОСТИ
  // ================================

  /// HTTP клиент для сетевых запросов
  ///
  /// Создает и настраивает единый экземпляр Dio для всего приложения.
  /// Все интерцепторы добавляются здесь для обеспечения единообразия.
  @singleton
  Dio get dio {
    // ✅ Используем singleton AppConfig
    final config = AppConfig.current;
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: Duration(milliseconds: config.apiTimeout),
        receiveTimeout: Duration(milliseconds: config.apiTimeout),
        sendTimeout: Duration(milliseconds: config.apiTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Добавляем базовые интерцепторы
    // Примечание: AuthInterceptor и RetryInterceptor добавляются через
    // DioInterceptorConfigurator.configureInterceptors() после инициализации DI
    dio.interceptors.add(
      LogInterceptor(
        request: config.isDebug,
        requestBody: config.isDebug,
        responseBody: config.isDebug,
        error: true,
        logPrint: (object) {
          // Используем простой логирование вместо Log.network
          // так как Dio LogInterceptor уже форматирует логи
          Log.d('🌐 Dio: $object');
        },
      ),
    );

    return dio;
  }

  /// Локальное хранилище
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  /// Менеджер сетевого подключения
  @singleton
  Connectivity get connectivity => Connectivity();

  // ================================
  // 🛠️ СЕРВИСЫ ПРИЛОЖЕНИЯ
  // ================================

  // Примечание: Log - статический класс, не требует регистрации в DI
  // Используйте напрямую: Log.i('message'), Log.d('message'), etc.

  // ================================
  // ⚙️ КОНФИГУРАЦИИ
  // ================================

  /// Базовый URL API (зависит от окружения)
  // Поставляется AppConfig, поэтому дополнительные биндинги не требуются.

  /// Получает API ключ из environment variables
  @Named("apiKey")
  String get apiKey {
    return const String.fromEnvironment(
      'API_KEY',
      defaultValue: 'dev_key_12345',
    );
  }

  /// Конфигурация для аналитики
  @Named("analyticsEnabled")
  bool get analyticsEnabled {
    return const bool.fromEnvironment('ANALYTICS_ENABLED', defaultValue: true);
  }
}

/// Модуль для утилит и хелперов
@module
abstract class UtilsModule {
  // Утилиты будут добавлены позже, когда создадим конкретные классы
}

/// Модуль для хранения данных
@module
abstract class StorageModule {
  /// Ключи для SharedPreferences
  @Named("authTokenKey")
  String get authTokenKey => 'auth_token';

  @Named("userDataKey")
  String get userDataKey => 'user_data';

  @Named("settingsKey")
  String get settingsKey => 'app_settings';

  /// Настройки кэширования
  @Named("cacheDuration")
  Duration get cacheDuration => const Duration(hours: 1);

  @Named("maxCacheSize")
  int get maxCacheSize => 100;
}
