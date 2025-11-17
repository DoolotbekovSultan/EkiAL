// ================================
// 📱 APP MODULE - ГЛАВНЫЙ МОДУЛЬ ЗАВИСИМОСТЕЙ
// ================================

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../utils/log_utils.dart';

/// Главный модуль зависимостей приложения
@module
abstract class AppModule {
  // ================================
  // 🌐 ВНЕШНИЕ ЗАВИСИМОСТИ
  // ================================

  /// HTTP клиент для сетевых запросов
  @singleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: _getBaseUrl(),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Добавляем интерцепторы
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
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

  /// Логгер приложения
  @singleton
  Log get logger => Log();

  // ================================
  // ⚙️ КОНФИГУРАЦИИ
  // ================================

  /// Базовый URL API (зависит от окружения)
  @Named("baseUrl")
  @dev
  String get devBaseUrl => 'https://api.dev.eki-al.com';

  @Named("baseUrl")
  @prod
  String get prodBaseUrl => 'https://api.eki-al.com';

  /// Таймауты для разных окружений
  @Named("connectTimeout")
  @dev
  int get devConnectTimeout => 30000; // 30 секунд

  @Named("connectTimeout")
  @prod
  int get prodConnectTimeout => 15000; // 15 секунд

  /// Включение логирования
  @Named("enableLogging")
  @dev
  bool get devEnableLogging => true;

  @Named("enableLogging")
  @prod
  bool get prodEnableLogging => false;

  // ================================
  // 🔧 ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ
  // ================================

  /// Получает базовый URL в зависимости от окружения
  String _getBaseUrl() {
    return const String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'https://api.dev.eki-al.com',
    );
  }

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
