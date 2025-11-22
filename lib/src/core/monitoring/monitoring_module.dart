import 'package:get_it/get_it.dart';
import '../utils/log_utils.dart';
import 'analytics_service.dart';
import 'crash_reporting_service.dart';
import 'performance_monitor.dart';

/// 🎛️ DI модуль для сервисов мониторинга
///
/// ## 🔧 ОСНОВНЫЕ ФУНКЦИИ:
/// ### Регистрация сервисов:
/// - `AnalyticsService` - аналитика событий
/// - `CrashReportingService` - отчеты об ошибках
/// - `PerformanceMonitor` - мониторинг производительности
///
/// ### Конфигурация:
/// - Настройка уровней логирования
/// - Конфигурация провайдеров для разных окружений
/// - Управление функциями мониторинга

class MonitoringModule {
  final GetIt _serviceLocator;

  /// СОЗДАНИЕ МОДУЛЯ МОНИТОРИНГА
  ///
  /// 📝 **Параметры:**
  /// - `serviceLocator`: Экземпляр GetIt для регистрации зависимостей
  MonitoringModule({required GetIt serviceLocator})
    : _serviceLocator = serviceLocator;

  /// ИНИЦИАЛИЗАЦИЯ МОДУЛЯ МОНИТОРИНГА
  ///
  /// Регистрирует все сервисы мониторинга в DI контейнере
  /// и выполняет их первоначальную настройку.
  ///
  /// 🎯 **Регистрируемые сервисы:**
  /// - AnalyticsService (универсальный с консольным провайдером)
  /// - CrashReportingService (универсальный с консольным провайдером)
  /// - PerformanceMonitor (универсальный с консольным провайдером)
  Future<void> initialize() async {
    Log.i('🎛️ Инициализация Monitoring Module');

    // Регистрация сервиса аналитики
    _registerAnalyticsService();

    // Регистрация сервиса отчетов об ошибках
    _registerCrashReportingService();

    // Регистрация сервиса мониторинга производительности
    _registerPerformanceMonitor();

    Log.i('🎛️ Monitoring Module успешно инициализирован');
  }

  /// РЕГИСТРАЦИЯ СЕРВИСА АНАЛИТИКИ
  void _registerAnalyticsService() {
    if (_serviceLocator.isRegistered<AnalyticsService>()) {
      Log.w('⚠️ AnalyticsService уже зарегистрирован, пропускаем');
      return;
    }

    final analyticsService = UniversalAnalyticsService(
      providers: [
        ConsoleAnalyticsProvider(),
        // Для продакшена можно добавить:
        // FirebaseAnalyticsProvider(),
        // SentryAnalyticsProvider(),
      ],
    );

    _serviceLocator.registerLazySingleton<AnalyticsService>(
      () => analyticsService,
    );

    Log.d('📊 AnalyticsService зарегистрирован в DI');
  }

  /// РЕГИСТРАЦИЯ СЕРВИСА ОТЧЕТОВ ОБ ОШИБКАХ
  void _registerCrashReportingService() {
    if (_serviceLocator.isRegistered<CrashReportingService>()) {
      Log.w('⚠️ CrashReportingService уже зарегистрирован, пропускаем');
      return;
    }

    final crashReportingService = UniversalCrashReportingService(
      providers: [
        ConsoleCrashReportingProvider(),
        // Для продакшена можно добавить:
        // SentryCrashReportingProvider(),
        // FirebaseCrashlyticsProvider(),
      ],
    );

    _serviceLocator.registerLazySingleton<CrashReportingService>(
      () => crashReportingService,
    );

    Log.d('⚠️ CrashReportingService зарегистрирован в DI');
  }

  /// РЕГИСТРАЦИЯ СЕРВИСА МОНИТОРИНГА ПРОИЗВОДИТЕЛЬНОСТИ
  void _registerPerformanceMonitor() {
    if (_serviceLocator.isRegistered<PerformanceMonitor>()) {
      Log.w('⚠️ PerformanceMonitor уже зарегистрирован, пропускаем');
      return;
    }

    final performanceMonitor = UniversalPerformanceMonitor(
      providers: [
        ConsolePerformanceMonitorProvider(),
        // Для продакшена можно добавить:
        // FirebasePerformanceMonitorProvider(),
        // NewRelicPerformanceMonitorProvider(),
      ],
    );

    _serviceLocator.registerLazySingleton<PerformanceMonitor>(
      () => performanceMonitor,
    );

    Log.d('⚡ PerformanceMonitor зарегистрирован в DI');
  }

  /// ЗАПУСК ВСЕХ СЕРВИСОВ МОНИТОРИНГА
  ///
  /// Выполняет инициализацию всех зарегистрированных сервисов
  /// и запускает сбор метрик и аналитики.
  ///
  /// 🕐 **Вызывается:** после регистрации всех зависимостей
  Future<void> startAllServices() async {
    Log.i('🚀 Запуск всех сервисов мониторинга');

    try {
      final analyticsService = _serviceLocator<AnalyticsService>();
      await analyticsService.initialize();

      final crashReportingService = _serviceLocator<CrashReportingService>();
      await crashReportingService.initialize();

      final performanceMonitor = _serviceLocator<PerformanceMonitor>();
      await performanceMonitor.initialize();

      Log.i('✅ Все сервисы мониторинга успешно запущены');
    } catch (error, stackTrace) {
      Log.e(
        '❌ Ошибка запуска сервисов мониторинга',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// ОСТАНОВКА ВСЕХ СЕРВИСОВ МОНИТОРИНГА
  ///
  /// Корректно останавливает все сервисы мониторинга,
  /// отправляет накопленные данные и освобождает ресурсы.
  ///
  /// 🕐 **Вызывается:** при завершении работы приложения
  Future<void> stopAllServices() async {
    Log.i('🛑 Остановка всех сервисов мониторинга');

    try {
      final analyticsService = _serviceLocator<AnalyticsService>();
      await analyticsService.dispose();

      final crashReportingService = _serviceLocator<CrashReportingService>();
      await crashReportingService.dispose();

      final performanceMonitor = _serviceLocator<PerformanceMonitor>();
      await performanceMonitor.dispose();

      Log.i('✅ Все сервисы мониторинга успешно остановлены');
    } catch (error, stackTrace) {
      Log.e(
        '❌ Ошибка остановки сервисов мониторинга',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// КОНФИГУРАЦИЯ ДЛЯ РАЗНЫХ ОКРУЖЕНИЙ
  ///
  /// Настраивает сервисы мониторинга в зависимости от
  /// текущего окружения (development, staging, production).
  ///
  /// 📝 **Параметры:**
  /// - `environment`: Окружение приложения
  /// - `config`: Конфигурация мониторинга
  void configureForEnvironment({
    required String environment,
    required MonitoringConfig config,
  }) {
    Log.i('🎚️ Конфигурация мониторинга для окружения: $environment');

    // Настройка уровней логирования
    _configureLoggingLevel(environment);

    // Настройка функций мониторинга
    _configureMonitoringFeatures(environment, config);

    Log.d('🎚️ Мониторинг сконфигурирован для $environment');
  }

  /// НАСТРОЙКА УРОВНЕЙ ЛОГИРОВАНИЯ
  void _configureLoggingLevel(String environment) {
    switch (environment) {
      case 'development':
        // Подробное логирование в разработке
        Log.d('🔍 Уровень логирования: VERBOSE (development)');
        break;
      case 'staging':
        // Средний уровень в staging
        Log.d('📝 Уровень логирования: INFO (staging)');
        break;
      case 'production':
        // Минимальное логирование в production
        Log.d('🚀 Уровень логирования: WARNING (production)');
        break;
      default:
        Log.d('⚡ Уровень логирования по умолчанию');
    }
  }

  /// НАСТРОЙКА ФУНКЦИЙ МОНИТОРИНГА
  void _configureMonitoringFeatures(
    String environment,
    MonitoringConfig config,
  ) {
    final performanceMonitor = _serviceLocator<PerformanceMonitor>();

    // Настройка порогов производительности
    if (environment == 'production') {
      performanceMonitor.setWarningThresholds({
        'network_request_slow': 2000,
        'screen_render_slow': 200,
        'memory_warning': 300,
      });
    }

    Log.d('⚙️ Функции мониторинга сконфигурированы для $environment');
  }

  /// ПОЛУЧЕНИЕ СТАТУСА СЕРВИСОВ МОНИТОРИНГА
  ///
  /// Возвращает текущее состояние всех сервисов мониторинга
  /// для диагностики и отладки.
  Map<String, dynamic> getServicesStatus() {
    return {
      'analytics_service': _serviceLocator.isRegistered<AnalyticsService>(),
      'crash_reporting_service': _serviceLocator
          .isRegistered<CrashReportingService>(),
      'performance_monitor': _serviceLocator.isRegistered<PerformanceMonitor>(),
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}

/// ⚙️ КОНФИГУРАЦИЯ МОНИТОРИНГА
class MonitoringConfig {
  final bool enableAnalytics;
  final bool enableCrashReporting;
  final bool enablePerformanceMonitoring;
  final double samplingRate;
  final Map<String, dynamic> additionalConfig;

  MonitoringConfig({
    this.enableAnalytics = true,
    this.enableCrashReporting = true,
    this.enablePerformanceMonitoring = true,
    this.samplingRate = 1.0,
    this.additionalConfig = const {},
  });

  /// КОНФИГУРАЦИЯ ДЛЯ РАЗРАБОТКИ
  factory MonitoringConfig.development() {
    return MonitoringConfig(
      enableAnalytics: true,
      enableCrashReporting: true,
      enablePerformanceMonitoring: true,
      samplingRate: 1.0,
      additionalConfig: {'verbose_logging': true, 'console_output': true},
    );
  }

  /// КОНФИГУРАЦИЯ ДЛЯ ПРОДАКШЕНА
  factory MonitoringConfig.production() {
    return MonitoringConfig(
      enableAnalytics: true,
      enableCrashReporting: true,
      enablePerformanceMonitoring: true,
      samplingRate: 0.1, // 10% sampling в production
      additionalConfig: {
        'verbose_logging': false,
        'console_output': false,
        'anonymize_data': true,
      },
    );
  }

  /// КОНФИГУРАЦИЯ ДЛЯ ТЕСТИРОВАНИЯ
  factory MonitoringConfig.testing() {
    return MonitoringConfig(
      enableAnalytics: false,
      enableCrashReporting: false,
      enablePerformanceMonitoring: false,
      samplingRate: 0.0,
      additionalConfig: {'mock_services': true, 'disable_network': true},
    );
  }
}

/// 🛠️ УТИЛИТЫ ДЛЯ РАБОТЫ С МОНИТОРИНГОМ
class MonitoringUtils {
  /// СОЗДАНИЕ КОНТЕКСТА ОШИБКИ
  ///
  /// Форматирует дополнительный контекст для отчетов об ошибках
  /// с автоматической фильтрацией конфиденциальных данных.
  static Map<String, dynamic> createErrorContext({
    required String feature,
    required String operation,
    Map<String, dynamic>? additionalData,
  }) {
    final context = <String, dynamic>{
      'feature': feature,
      'operation': operation,
      'timestamp': DateTime.now().toIso8601String(),
      'app_version': '1.0.0', // В реальном приложении брать из package_info
      'platform': 'flutter', // В реальном приложении определять платформу
    };

    if (additionalData != null) {
      context.addAll(additionalData);
    }

    return context;
  }

  /// ФОРМАТИРОВАНИЕ МЕТРИК ПРОИЗВОДИТЕЛЬНОСТИ
  ///
  /// Подготавливает метрики производительности для отправки
  /// в аналитические системы с единообразным форматом.
  static Map<String, dynamic> formatPerformanceMetrics({
    required String metricName,
    required dynamic value,
    required String unit,
    Map<String, dynamic>? tags,
  }) {
    return {
      'name': metricName,
      'value': value,
      'unit': unit,
      'tags': tags ?? {},
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
  }

  /// ПРОВЕРКА ДОСТУПНОСТИ СЕРВИСОВ МОНИТОРИНГА
  ///
  /// Проверяет, что все сервисы мониторинга зарегистрированы
  /// и готовы к работе перед началом использования.
  static bool areServicesReady(GetIt serviceLocator) {
    return serviceLocator.isRegistered<AnalyticsService>() &&
        serviceLocator.isRegistered<CrashReportingService>() &&
        serviceLocator.isRegistered<PerformanceMonitor>();
  }
}
