// ================================
// 🚀 PROD CONFIG - PRODUCTION КОНФИГУРАЦИЯ
// ================================

import 'app_config.dart';
import '../utils/log_utils.dart';

/// 🎯 КОНФИГУРАЦИЯ ДЛЯ PRODUCTION ОКРУЖЕНИЯ
///
/// ## ОСОБЕННОСТИ PRODUCTION РЕЖИМА:
/// - ✅ Production серверы и реальные данные
/// - ✅ Минимальное логирование для производительности
/// - ✅ Оптимизированные таймауты для UX
/// - ✅ Включена аналитика и мониторинг
class ProdConfig implements AppConfig {
  @override
  String get baseUrl => 'https://api.example.com';

  @override
  String get apiKey => const String.fromEnvironment('PROD_API_KEY');

  @override
  bool get isDebug => false;

  @override
  String get environmentName => 'Production';

  @override
  int get apiTimeout => 15000; // 15 секунд

  @override
  bool get enableAnalytics => true;

  @override
  bool get enableDebugTools => false;

  @override
  bool get useMockData => false;

  @override
  String get logLevel => 'warning';

  @override
  bool get enablePerformanceMonitoring => true;

  @override
  bool get enableCrashReporting => true;

  @override
  String get analyticsKey => const String.fromEnvironment('ANALYTICS_KEY');

  @override
  String get crashlyticsKey => const String.fromEnvironment('CRASHLYTICS_KEY');

  @override
  bool get enableCaching => true;

  @override
  int get cacheDuration => 3600; // 1 час

  @override
  int get maxCacheSize => 500; // 500 MB

  // ================================
  // 🎯 PRODUCTION-СПЕЦИФИЧНЫЕ СВОЙСТВА
  // ================================

  /// Включить ли сжатие данных
  bool get enableCompression => true;

  /// Включить ли кэширование изображений
  bool get enableImageCaching => true;

  /// Минимальный уровень логирования для production
  String get minLogLevel => 'warning';

  /// Включить ли мониторинг производительности в реальном времени
  bool get enableRealtimeMonitoring => true;

  @override
  void validate() {
    final errors = <String>[];

    // Production-специфичная валидация
    if (!baseUrl.startsWith('https://')) {
      errors.add('Production URLs must use HTTPS');
    }

    if (isDebug) {
      errors.add('Production environment should not be in debug mode');
    }

    if (!enableAnalytics) {
      errors.add('Analytics must be enabled in production');
    }

    if (!enableCrashReporting) {
      errors.add('Crash reporting must be enabled in production');
    }

    if (errors.isNotEmpty) {
      throw ConfigValidationException(
        'Production configuration validation failed:\n${errors.map((e) => '  • $e').join('\n')}',
      );
    }
  }

  @override
  void logConfig() {
    Log.i('🎯 PRODUCTION Configuration loaded');

    // Минимальное логирование для production
    Log.i('🌍 Environment: $environmentName');
    Log.i('🔗 Base URL: $baseUrl');
    Log.i('📊 Analytics: $enableAnalytics');
    Log.i('🚨 Crash Reporting: $enableCrashReporting');
  }
}
