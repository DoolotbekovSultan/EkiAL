// ================================
// 🛠️ DEV CONFIG - DEVELOPMENT КОНФИГУРАЦИЯ
// ================================

import 'app_config.dart';
import '../utils/log_utils.dart';

/// 🎯 КОНФИГУРАЦИЯ ДЛЯ DEVELOPMENT ОКРУЖЕНИЯ
///
/// ## ОСОБЕННОСТИ DEVELOPMENT РЕЖИМА:
/// - ✅ Локальные серверы и мок-данные
/// - ✅ Расширенное логирование и отладка
/// - ✅ Быстрые таймауты для быстрой разработки
/// - ✅ Отключена аналитика для чистоты тестов
class DevConfig implements AppConfig {
  @override
  String get baseUrl => 'https://dev.api.example.com';

  @override
  String get apiKey => 'dev_api_key_123456';

  @override
  bool get isDebug => true;

  @override
  String get environmentName => 'Development';

  @override
  int get apiTimeout => 30000; // 30 секунд

  @override
  bool get enableAnalytics => false;

  @override
  bool get enableDebugTools => true;

  @override
  bool get useMockData => true;

  @override
  String get logLevel => 'verbose';

  @override
  bool get enablePerformanceMonitoring => false;

  @override
  bool get enableCrashReporting => false;

  @override
  String get analyticsKey => 'dev_analytics_key';

  @override
  String get crashlyticsKey => 'dev_crashlytics_key';

  @override
  bool get enableCaching => true;

  @override
  int get cacheDuration => 300; // 5 минут

  @override
  int get maxCacheSize => 100; // 100 MB

  // ================================
  // 🎯 РЕАЛИЗАЦИЯ АБСТРАКТНЫХ МЕТОДОВ
  // ================================

  @override
  void validate() {
    final errors = <String>[];

    // Development-специфичная валидация
    if (useMockData && baseUrl.contains('production')) {
      errors.add('Mock data should not be used with production URLs');
    }

    if (isDebug && enableAnalytics) {
      errors.add('Analytics should be disabled in debug mode');
    }

    if (enableHotReload && !isDebug) {
      errors.add('Hot reload should only be enabled in debug mode');
    }

    if (errors.isNotEmpty) {
      throw ConfigValidationException(
        'Development configuration validation failed:\n${errors.map((e) => '  • $e').join('\n')}',
      );
    }
  }

  @override
  void logConfig() {
    Log.i('🎯 DEVELOPMENT Configuration loaded');

    // Детальное логирование для development
    Log.d('🌍 Environment: $environmentName');
    Log.d('🔗 Base URL: $baseUrl');
    Log.d('🐛 Debug Mode: $isDebug');
    Log.d('📊 Analytics: $enableAnalytics');
    Log.d('⚡ API Timeout: ${apiTimeout}ms');
    Log.d('🛠️ Debug Tools: $enableDebugTools');
    Log.d('🤖 Mock Data: $useMockData');
    Log.d('📝 Log Level: $logLevel');
    Log.d('💾 Caching: $enableCaching');

    // Development-специфичные настройки
    Log.d('🔥 Hot Reload: $enableHotReload');
    Log.d('🚩 Debug Banner: $showDebugBanner');
    Log.d('🏠 Local Server: $useLocalServer');
    if (useLocalServer) {
      Log.d('📍 Local Server URL: $localServerUrl');
    }
  }

  // ================================
  // 🎯 DEVELOPMENT-СПЕЦИФИЧНЫЕ СВОЙСТВА
  // ================================

  /// Включить ли горячую перезагрузку состояний
  bool get enableHotReload => true;

  /// Показывать ли debug banner
  bool get showDebugBanner => true;

  /// URL для локального сервера разработки
  String get localServerUrl => 'http://localhost:8080';

  /// Использовать ли локальный сервер вместо удаленного
  bool get useLocalServer => false;

  /// Автоматическое обновление данных при изменении
  bool get autoRefresh => true;

  /// Показывать техническую информацию в UI
  bool get showTechnicalInfo => true;
}
