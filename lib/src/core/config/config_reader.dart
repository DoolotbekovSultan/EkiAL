// ================================
// 📖 CONFIG READER - УТИЛИТА ЧТЕНИЯ КОНФИГУРАЦИЙ
// ================================

import 'app_config.dart';
import '../utils/log_utils.dart';

/// 🎯 УТИЛИТА ДЛЯ РАБОТЫ С КОНФИГУРАЦИЯМИ ПРИЛОЖЕНИЯ
///
/// ## ФУНКЦИОНАЛЬНОСТЬ:
/// - Валидация конфигураций
/// - Логирование настроек
/// - Утилиты для работы с окружениями
/// - Вспомогательные методы
class ConfigReader {
  ConfigReader._();

  // ================================
  // 🎯 ОСНОВНЫЕ МЕТОДЫ ВАЛИДАЦИИ
  // ================================

  /// Полная валидация конфигурации приложения
  ///
  /// ## Проверяемые параметры:
  /// - Обязательные поля (baseUrl, apiKey)
  /// - Корректность форматов
  /// - Соответствие бизнес-правилам
  static bool validateConfig(AppConfig config) {
    final errors = <String>[];

    // Проверка обязательных полей
    if (config.baseUrl.isEmpty) {
      errors.add('Base URL cannot be empty');
    }

    if (config.apiKey.isEmpty) {
      errors.add('API key cannot be empty');
    }

    // Проверка форматов
    if (!config.baseUrl.startsWith('http')) {
      errors.add(
        'Base URL must be a valid URL starting with http:// or https://',
      );
    }

    if (config.apiTimeout <= 0) {
      errors.add('API timeout must be a positive number');
    }

    if (config.environmentName.isEmpty) {
      errors.add('Environment name cannot be empty');
    }

    // Бизнес-правила
    if (config.isDebug && config.enableAnalytics) {
      errors.add('Analytics should be disabled in debug mode');
    }

    if (config.cacheDuration < 0) {
      errors.add('Cache duration cannot be negative');
    }

    if (config.maxCacheSize <= 0) {
      errors.add('Max cache size must be positive');
    }

    // Вывод ошибок или успеха
    if (errors.isNotEmpty) {
      throw ConfigValidationException(
        'Configuration validation failed:\n${errors.map((e) => '  • $e').join('\n')}',
      );
    }

    return true;
  }

  // ================================
  // 📊 ЛОГИРОВАНИЕ И ДИАГНОСТИКА
  // ================================

  /// Детальное логирование конфигурации
  static void logDetailedConfig(AppConfig config) {
    final buffer = StringBuffer();

    buffer.writeln('🎯 APPLICATION CONFIGURATION');
    buffer.writeln('══════════════════════════════════════');

    // Основная информация
    buffer.writeln('🌍 ENVIRONMENT:');
    buffer.writeln('  • Name: ${config.environmentName}');
    buffer.writeln('  • Debug: ${config.isDebug}');
    buffer.writeln('  • Log Level: ${config.logLevel}');

    // API настройки
    buffer.writeln('🔗 API CONFIGURATION:');
    buffer.writeln('  • Base URL: ${config.baseUrl}');
    buffer.writeln('  • Timeout: ${config.apiTimeout}ms');
    buffer.writeln('  • API Key: ${_maskApiKey(config.apiKey)}');

    // Функциональные флаги
    buffer.writeln('⚙️  FEATURE FLAGS:');
    buffer.writeln('  • Debug Tools: ${config.enableDebugTools}');
    buffer.writeln('  • Mock Data: ${config.useMockData}');
    buffer.writeln('  • Analytics: ${config.enableAnalytics}');
    buffer.writeln(
      '  • Performance Monitoring: ${config.enablePerformanceMonitoring}',
    );
    buffer.writeln('  • Crash Reporting: ${config.enableCrashReporting}');

    // Настройки кэширования
    buffer.writeln('💾 CACHE SETTINGS:');
    buffer.writeln('  • Enabled: ${config.enableCaching}');
    buffer.writeln('  • Duration: ${config.cacheDuration}s');
    buffer.writeln('  • Max Size: ${config.maxCacheSize}MB');

    buffer.writeln('══════════════════════════════════════');

    // Используем ваш существующий логгер вместо debugPrint
    Log.i(buffer.toString());
  }

  /// Краткое логирование основных параметров конфигурации
  static void logSummaryConfig(AppConfig config) {
    Log.i(
      '🎯 App Config Summary - '
      'Env: ${config.environmentName} | '
      'Debug: ${config.isDebug} | '
      'URL: ${config.baseUrl} | '
      'Analytics: ${config.enableAnalytics}',
    );
  }

  // ================================
  // 🛠️ ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ
  // ================================

  /// Маскировка API ключа для безопасного логирования
  static String _maskApiKey(String apiKey) {
    if (apiKey.length <= 8) return '***';
    return '${apiKey.substring(0, 4)}...${apiKey.substring(apiKey.length - 4)}';
  }

  /// Получить информацию о текущем окружении в виде Map
  static Map<String, dynamic> getEnvironmentInfo(AppConfig config) {
    return {
      'environment': config.environmentName,
      'isDebug': config.isDebug,
      'baseUrl': config.baseUrl,
      'apiTimeout': config.apiTimeout,
      'features': {
        'analytics': config.enableAnalytics,
        'debugTools': config.enableDebugTools,
        'performanceMonitoring': config.enablePerformanceMonitoring,
        'crashReporting': config.enableCrashReporting,
      },
      'cache': {
        'enabled': config.enableCaching,
        'duration': config.cacheDuration,
        'maxSize': config.maxCacheSize,
      },
    };
  }

  /// Проверка, является ли текущее окружение production
  static bool isProduction(AppConfig config) {
    return config.environmentName.toLowerCase() == 'production';
  }

  /// Проверка, является ли текущее окружение development
  static bool isDevelopment(AppConfig config) {
    return config.environmentName.toLowerCase() == 'development';
  }

  /// Проверка, является ли текущее окружение staging
  static bool isStaging(AppConfig config) {
    return config.environmentName.toLowerCase() == 'staging';
  }

  /// Получить безопасную версию конфигурации для логирования (без sensitive данных)
  static Map<String, dynamic> getSafeConfigForLogging(AppConfig config) {
    return {
      'environment': config.environmentName,
      'isDebug': config.isDebug,
      'baseUrl': config.baseUrl,
      'apiTimeout': config.apiTimeout,
      'apiKey': _maskApiKey(config.apiKey),
      'logLevel': config.logLevel,
      'enableAnalytics': config.enableAnalytics,
      'enableDebugTools': config.enableDebugTools,
      'useMockData': config.useMockData,
      'enableCaching': config.enableCaching,
      'cacheDuration': config.cacheDuration,
      'maxCacheSize': config.maxCacheSize,
      'enablePerformanceMonitoring': config.enablePerformanceMonitoring,
      'enableCrashReporting': config.enableCrashReporting,
    };
  }

  /// Валидация и логирование конфигурации в одном методе
  static void validateAndLogConfig(AppConfig config) {
    try {
      Log.i('🔄 Starting configuration validation...');

      // Валидация
      validateConfig(config);

      // Логирование успеха
      Log.i('✅ Configuration validation passed');

      // Детальное логирование
      logDetailedConfig(config);

      // Логирование безопасной версии для аналитики
      final safeConfig = getSafeConfigForLogging(config);
      Log.d('🔒 Safe config for analytics: $safeConfig');
    } on ConfigValidationException catch (e) {
      Log.e('❌ Configuration validation failed', error: e);
      rethrow;
    } catch (e) {
      Log.e('💥 Unexpected error during config validation', error: e);
      rethrow;
    }
  }
}
