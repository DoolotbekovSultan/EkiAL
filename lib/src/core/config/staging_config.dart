// ================================
// 🧪 STAGING CONFIG - STAGING КОНФИГУРАЦИЯ
// ================================

import 'app_config.dart';
import '../utils/log_utils.dart';

/// 🎯 КОНФИГУРАЦИЯ ДЛЯ STAGING ОКРУЖЕНИЯ
///
/// ## ОСОБЕННОСТИ STAGING РЕЖИМА:
/// - ✅ Тестовые серверы, максимально приближенные к production
/// - ✅ Баланс между логированием и производительностью
/// - ✅ Тестовая аналитика для проверки интеграций
/// - ✅ Используются реальные данные (но тестовые)
class StagingConfig implements AppConfig {
  @override
  String get baseUrl => 'https://staging.api.example.com';

  @override
  String get apiKey => const String.fromEnvironment('STAGING_API_KEY');

  @override
  bool get isDebug => false;

  @override
  String get environmentName => 'Staging';

  @override
  int get apiTimeout => 20000; // 20 секунд

  @override
  bool get enableAnalytics => true;

  @override
  bool get enableDebugTools => false;

  @override
  bool get useMockData => false;

  @override
  String get logLevel => 'info';

  @override
  bool get enablePerformanceMonitoring => true;

  @override
  bool get enableCrashReporting => true;

  @override
  String get analyticsKey =>
      const String.fromEnvironment('STAGING_ANALYTICS_KEY');

  @override
  String get crashlyticsKey =>
      const String.fromEnvironment('STAGING_CRASHLYTICS_KEY');

  @override
  bool get enableCaching => true;

  @override
  int get cacheDuration => 1800; // 30 минут

  @override
  int get maxCacheSize => 250; // 250 MB

  // ================================
  // 🎯 STAGING-СПЕЦИФИЧНЫЕ СВОЙСТВА
  // ================================

  /// Включить ли дополнительные проверки для QA
  bool get enableQAChecks => true;

  /// Собирать ли расширенные метрики для тестирования
  bool get enableExtendedMetrics => true;

  /// URL для тестового окружения
  String get testingBaseUrl => 'https://test.api.example.com';

  /// Использовать ли тестовое окружение
  bool get useTestingEnvironment => false;

  @override
  void validate() {
    final errors = <String>[];

    // Staging-специфичная валидация
    if (baseUrl.contains('production')) {
      errors.add('Staging should not use production URLs');
    }

    if (isDebug) {
      errors.add('Staging environment should not be in debug mode');
    }

    if (errors.isNotEmpty) {
      throw ConfigValidationException(
        'Staging configuration validation failed:\n${errors.map((e) => '  • $e').join('\n')}',
      );
    }
  }

  @override
  void logConfig() {
    Log.i('🎯 STAGING Configuration loaded');

    Log.i('🌍 Environment: $environmentName');
    Log.i('🔗 Base URL: $baseUrl');
    Log.i('🐛 Debug Mode: $isDebug');
    Log.i('📊 Analytics: $enableAnalytics');
    Log.i('🚨 Crash Reporting: $enableCrashReporting');
  }
}
