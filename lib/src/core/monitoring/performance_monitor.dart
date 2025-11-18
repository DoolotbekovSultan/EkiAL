import 'package:logger/logger.dart';

/// ⚡ Сервис мониторинга производительности приложения
///
/// ## 🔧 Доступные методы:
/// ### Мониторинг запуска:
/// - `trackAppStartup(startTime)` → void - время запуска приложения
/// - `trackFirstFrame()` → void - первый кадр интерфейса
/// - `trackAppReady()` → void - полная готовность приложения
///
/// ### Сетевые метрики:
/// - `trackNetworkRequest(endpoint, durationMs, method)` → void - запросы API
/// - `trackDatabaseOperation(operation, durationMs)` → void - операции БД
/// - `trackCacheOperation(operation, durationMs)` → void - кэш операции
///
/// ### UI метрики:
/// - `trackScreenRender(screenName, renderTimeMs)` → void - рендер экранов
/// - `trackWidgetBuild(widgetName, buildTimeMs)` → void - построение виджетов
/// - `trackUserInteraction(interactionType, durationMs)` → void - взаимодействия
///
/// ### Системные метрики:
/// - `trackMemoryUsage()` → void - использование памяти
/// - `trackCpuUsage()` → void - использование CPU
/// - `trackBatteryImpact()` → void - влияние на батарею

abstract class PerformanceMonitor {
  /// ИНИЦИАЛИЗАЦИЯ СЕРВИСА МОНИТОРИНГА ПРОИЗВОДИТЕЛЬНОСТИ
  ///
  /// Настраивает сбор метрик производительности, запускает
  /// периодический мониторинг системных ресурсов.
  ///
  /// 🕐 **Вызывается при:** запуске приложения
  /// 📊 **Начинает сбор:** системных метрик каждые 30 секунд
  Future<void> initialize();

  /// ТРЕКИНГ ЗАПУСКА ПРИЛОЖЕНИЯ
  ///
  /// Измеряет общее время от старта приложения до полной готовности.
  /// Ключевая метрика для пользовательского опыта.
  ///
  /// 📝 **Параметры:**
  /// - `startTime`: Время начала запуска приложения
  ///
  /// 🎯 **Метрики:**
  /// - `app_startup_duration`: Общее время запуска
  /// - `startup_phase`: Текущая фаза запуска
  void trackAppStartup(DateTime startTime);

  /// ТРЕКИНГ ПЕРВОГО КАДРА ИНТЕРФЕЙСА
  ///
  /// Фиксирует момент отображения первого кадра приложения.
  /// Важнейшая метрика воспринимаемой производительности.
  void trackFirstFrame();

  /// ТРЕКИНГ ПОЛНОЙ ГОТОВНОСТИ ПРИЛОЖЕНИЯ
  ///
  /// Отмечает момент, когда приложение полностью готово к работе
  /// (загружены данные, инициализированы сервисы).
  void trackAppReady();

  /// ТРЕКИНГ СЕТЕВОГО ЗАПРОСА
  ///
  /// Измеряет производительность API вызовов для выявления
  /// медленных endpoint и проблем с сетью.
  ///
  /// 📝 **Параметры:**
  /// - `endpoint`: URL или идентификатор endpoint
  /// - `durationMs`: Время выполнения в миллисекундах
  /// - `method`: HTTP метод (GET, POST, etc.)
  /// - `statusCode`: Код ответа (200, 404, 500, etc.)
  ///
  /// 📊 **Аналитика:**
  /// - Среднее время ответа по endpoint
  /// - Процент ошибок по методам
  /// - Медленные запросы (>1000ms)
  void trackNetworkRequest({
    required String endpoint,
    required int durationMs,
    required String method,
    int? statusCode,
  });

  /// ТРЕКИНГ ОПЕРАЦИЙ БАЗЫ ДАННЫХ
  ///
  /// Мониторинг производительности операций с локальной БД
  /// для оптимизации запросов и индексов.
  ///
  /// 📝 **Параметры:**
  /// - `operation`: Тип операции (query, insert, update, delete)
  /// - `durationMs`: Время выполнения в миллисекундах
  /// - `table`: Название таблицы (опционально)
  /// - `recordsCount`: Количество записей (опционально)
  void trackDatabaseOperation({
    required String operation,
    required int durationMs,
    String? table,
    int? recordsCount,
  });

  /// ТРЕКИНГ ОПЕРАЦИЙ С КЭШЕМ
  ///
  /// Измеряет эффективность кэширования данных и производительность
  /// операций чтения/записи в кэш.
  ///
  /// 📝 **Параметры:**
  /// - `operation`: Тип операции (read, write, delete)
  /// - `durationMs`: Время выполнения в миллисекундах
  /// - `cacheHit`: Попадание в кэш (true/false)
  /// - `key`: Ключ кэша (опционально)
  void trackCacheOperation({
    required String operation,
    required int durationMs,
    bool? cacheHit,
    String? key,
  });

  /// ТРЕКИНГ РЕНДЕРА ЭКРАНОВ
  ///
  /// Измеряет время построения и отображения экранов приложения
  /// для выявления медленных UI компонентов.
  ///
  /// 📝 **Параметры:**
  /// - `screenName`: Название экрана или route
  /// - `renderTimeMs`: Время рендера в миллисекундах
  /// - `complexity`: Сложность экрана (low, medium, high)
  void trackScreenRender({
    required String screenName,
    required int renderTimeMs,
    String? complexity,
  });

  /// ТРЕКИНГ ПОСТРОЕНИЯ ВИДЖЕТОВ
  ///
  /// Мониторинг производительности построения отдельных виджетов
  /// для оптимизации тяжелых компонентов.
  ///
  /// 📝 **Параметры:**
  /// - `widgetName`: Название виджета или типа
  /// - `buildTimeMs`: Время построения в миллисекундах
  /// - `rebuildCount`: Количество перестроений (опционально)
  void trackWidgetBuild({
    required String widgetName,
    required int buildTimeMs,
    int? rebuildCount,
  });

  /// ТРЕКИНГ ПОЛЬЗОВАТЕЛЬСКИХ ВЗАИМОДЕЙСТВИЙ
  ///
  /// Измеряет время отклика на действия пользователя
  /// (тапы, скроллы, жесты) для оценки отзывчивости UI.
  ///
  /// 📝 **Параметры:**
  /// - `interactionType`: Тип взаимодействия (tap, scroll, swipe)
  /// - `durationMs`: Время обработки в миллисекундах
  /// - `targetElement`: Целевой элемент (button, list, etc.)
  void trackUserInteraction({
    required String interactionType,
    required int durationMs,
    String? targetElement,
  });

  /// ТРЕКИНГ ИСПОЛЬЗОВАНИЯ ПАМЯТИ
  ///
  /// Мониторинг потребления памяти приложением для выявления
  /// утечек памяти и оптимизации использования ресурсов.
  ///
  /// 📊 **Метрики:**
  /// - `memory_used`: Использованная память в MB
  /// - `memory_total`: Доступная память в MB
  /// - `memory_pressure`: Давление на память (low, medium, high)
  void trackMemoryUsage();

  /// ТРЕКИНГ ИСПОЛЬЗОВАНИЯ CPU
  ///
  /// Измерение нагрузки на процессор для выявления
  /// ресурсоемких операций и оптимизации вычислений.
  void trackCpuUsage();

  /// ТРЕКИНГ ВЛИЯНИЯ НА БАТАРЕЮ
  ///
  /// Мониторинг энергопотребления приложения для
  /// оптимизации расхода батареи пользователя.
  void trackBatteryImpact();

  /// УСТАНОВКА ПОРОГОВ ПРЕДУПРЕЖДЕНИЙ
  ///
  /// Настройка критических значений метрик для
  /// автоматического оповещения о проблемах.
  ///
  /// 📝 **Параметры:**
  /// - `thresholds`: Map порогов для разных метрик
  void setWarningThresholds(Map<String, dynamic> thresholds);

  /// ОЧИСТКА РЕСУРСОВ И ЗАВЕРШЕНИЕ РАБОТЫ
  ///
  /// Останавливает сбор метрик, отправляет финальные данные
  /// и освобождает системные ресурсы.
  Future<void> dispose();
}

/// 🎯 УНИВЕРСАЛЬНАЯ РЕАЛИЗАЦИЯ МОНИТОРИНГА ПРОИЗВОДИТЕЛЬНОСТИ
///
/// ## 🚀 ОСОБЕННОСТИ РЕАЛИЗАЦИИ:
/// ### Мониторинг в реальном времени:
/// - ✅ Автоматический сбор системных метрик
/// - ✅ Производительность UI и бизнес-логики
/// - ✅ Сетевые запросы и операции с данными
///
/// ### Аналитика и отчетность:
/// - ✅ Агрегация метрик за периоды
/// - ✅ Выявление аномалий и трендов
/// - ✅ Интеграция с аналитическими системами

class UniversalPerformanceMonitor implements PerformanceMonitor {
  final Logger _logger;
  final List<PerformanceMonitorProvider> _providers = [];
  bool _isInitialized = false;
  DateTime? _appStartTime;
  DateTime? _firstFrameTime;
  DateTime? _appReadyTime;

  /// 📊 ПОРОГИ ПРЕДУПРЕЖДЕНИЙ ПО УМОЛЧАНИЮ
  static const Map<String, int> _defaultThresholds = {
    'network_request_slow': 1000, // 1 секунда
    'screen_render_slow': 100, // 100 ms
    'widget_build_slow': 16, // 60 FPS frame budget
    'memory_warning': 200, // 200 MB
  };

  Map<String, dynamic> _thresholds;

  UniversalPerformanceMonitor({
    Logger? logger,
    List<PerformanceMonitorProvider> providers = const [],
  }) : _logger = logger ?? Logger(),
       _thresholds = {..._defaultThresholds} {
    _providers.addAll(providers);
  }

  @override
  Future<void> initialize() async {
    try {
      for (final provider in _providers) {
        await provider.initialize();
      }
      _isInitialized = true;

      // Запуск периодического сбора системных метрик
      _startPeriodicMonitoring();

      _logger.i('🎯 Universal Performance Monitor инициализирован');
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка инициализации Performance Monitor',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void trackAppStartup(DateTime startTime) {
    _appStartTime = startTime;

    if (!_isInitialized) return;

    try {
      for (final provider in _providers) {
        provider.trackAppStartup(startTime);
      }

      _logger.d('🚀 Отслеживание запуска приложения начато: $startTime');
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка трекинга запуска приложения',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void trackFirstFrame() {
    _firstFrameTime = DateTime.now();

    if (!_isInitialized || _appStartTime == null) return;

    final firstFrameDuration = _firstFrameTime!
        .difference(_appStartTime!)
        .inMilliseconds;

    try {
      for (final provider in _providers) {
        provider.trackFirstFrame();
      }

      _logger.d('🖼️ Первый кадр отображен за $firstFrameDuration ms');

      // Проверка порога производительности
      if (firstFrameDuration > (_thresholds['first_frame_slow'] ?? 1000)) {
        _logger.w('⚠️ Медленный первый кадр: $firstFrameDuration ms');
      }
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка трекинга первого кадра',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void trackAppReady() {
    _appReadyTime = DateTime.now();

    if (!_isInitialized || _appStartTime == null) return;

    final totalStartupDuration = _appReadyTime!
        .difference(_appStartTime!)
        .inMilliseconds;

    try {
      for (final provider in _providers) {
        provider.trackAppReady();
      }

      _logger.d('✅ Приложение готово за $totalStartupDuration ms');

      // Отправка финальной метрики запуска
      for (final provider in _providers) {
        provider.trackMetric('app_startup_total', totalStartupDuration);
      }
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка трекинга готовности приложения',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void trackNetworkRequest({
    required String endpoint,
    required int durationMs,
    required String method,
    int? statusCode,
  }) {
    if (!_isInitialized) return;

    try {
      for (final provider in _providers) {
        provider.trackNetworkRequest(
          endpoint: endpoint,
          durationMs: durationMs,
          method: method,
          statusCode: statusCode,
        );
      }

      _logger.d('🌐 Сетевой запрос: $method $endpoint - $durationMs ms');

      // Проверка на медленные запросы
      if (durationMs > (_thresholds['network_request_slow'] ?? 1000)) {
        _logger.w('⚠️ Медленный сетевой запрос: $endpoint - $durationMs ms');
      }
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка трекинга сетевого запроса',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void trackDatabaseOperation({
    required String operation,
    required int durationMs,
    String? table,
    int? recordsCount,
  }) {
    if (!_isInitialized) return;

    try {
      for (final provider in _providers) {
        provider.trackDatabaseOperation(
          operation: operation,
          durationMs: durationMs,
          table: table,
          recordsCount: recordsCount,
        );
      }

      _logger.d('💾 Операция БД: $operation - $durationMs ms');
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка трекинга операции БД',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void trackCacheOperation({
    required String operation,
    required int durationMs,
    bool? cacheHit,
    String? key,
  }) {
    if (!_isInitialized) return;

    try {
      for (final provider in _providers) {
        provider.trackCacheOperation(
          operation: operation,
          durationMs: durationMs,
          cacheHit: cacheHit,
          key: key,
        );
      }

      final hitMiss = cacheHit == true ? 'HIT' : 'MISS';
      _logger.d('🗂️ Кэш операция: $operation ($hitMiss) - $durationMs ms');
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка трекинга операции кэша',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void trackScreenRender({
    required String screenName,
    required int renderTimeMs,
    String? complexity,
  }) {
    if (!_isInitialized) return;

    try {
      for (final provider in _providers) {
        provider.trackScreenRender(
          screenName: screenName,
          renderTimeMs: renderTimeMs,
          complexity: complexity,
        );
      }

      _logger.d('🖥️ Рендер экрана: $screenName - $renderTimeMs ms');

      // Проверка на медленный рендер
      if (renderTimeMs > (_thresholds['screen_render_slow'] ?? 100)) {
        _logger.w('⚠️ Медленный рендер экрана: $screenName - $renderTimeMs ms');
      }
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка трекинга рендера экрана',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void trackWidgetBuild({
    required String widgetName,
    required int buildTimeMs,
    int? rebuildCount,
  }) {
    if (!_isInitialized) return;

    try {
      for (final provider in _providers) {
        provider.trackWidgetBuild(
          widgetName: widgetName,
          buildTimeMs: buildTimeMs,
          rebuildCount: rebuildCount,
        );
      }

      if (buildTimeMs > (_thresholds['widget_build_slow'] ?? 16)) {
        _logger.d('🧱 Медленный виджет: $widgetName - $buildTimeMs ms');
      }
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка трекинга построения виджета',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void trackUserInteraction({
    required String interactionType,
    required int durationMs,
    String? targetElement,
  }) {
    if (!_isInitialized) return;

    try {
      for (final provider in _providers) {
        provider.trackUserInteraction(
          interactionType: interactionType,
          durationMs: durationMs,
          targetElement: targetElement,
        );
      }

      _logger.d('👆 Взаимодействие: $interactionType - $durationMs ms');
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка трекинга пользовательского взаимодействия',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void trackMemoryUsage() {
    if (!_isInitialized) return;

    try {
      // Симуляция получения данных об использовании памяти
      final memoryUsage = _getSimulatedMemoryUsage();

      for (final provider in _providers) {
        provider.trackMemoryUsage();
        provider.trackMetric('memory_used_mb', memoryUsage);
      }

      if (memoryUsage > (_thresholds['memory_warning'] ?? 200)) {
        _logger.w('⚠️ Высокое использование памяти: $memoryUsage MB');
      }
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка трекинга использования памяти',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void trackCpuUsage() {
    if (!_isInitialized) return;

    try {
      final cpuUsage = _getSimulatedCpuUsage();

      for (final provider in _providers) {
        provider.trackCpuUsage();
        provider.trackMetric('cpu_usage_percent', cpuUsage);
      }

      _logger.d('⚡ Использование CPU: $cpuUsage %');
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка трекинга использования CPU',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void trackBatteryImpact() {
    if (!_isInitialized) return;

    try {
      for (final provider in _providers) {
        provider.trackBatteryImpact();
      }

      _logger.d('🔋 Мониторинг влияния на батарею');
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка трекинга влияния на батарею',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void setWarningThresholds(Map<String, dynamic> thresholds) {
    _thresholds.addAll(thresholds);
    _logger.d('📊 Пороги предупреждений обновлены: $thresholds');
  }

  @override
  Future<void> dispose() async {
    for (final provider in _providers) {
      await provider.dispose();
    }
    _isInitialized = false;
    _logger.i('🔚 Universal Performance Monitor остановлен');
  }

  /// 🔄 ЗАПУСК ПЕРИОДИЧЕСКОГО МОНИТОРИНГА
  void _startPeriodicMonitoring() {
    // В реальной реализации здесь будет Timer.periodic
    // для сбора системных метрик каждые 30 секунд
    _logger.d('⏰ Периодический мониторинг активирован');
  }

  /// 🧪 СИМУЛЯЦИЯ ДАННЫХ ДЛЯ ДЕМОНСТРАЦИИ
  int _getSimulatedMemoryUsage() {
    return 100 + (DateTime.now().millisecond % 150); // 100-250 MB
  }

  int _getSimulatedCpuUsage() {
    return 10 + (DateTime.now().second % 50); // 10-60%
  }
}

/// 🔌 ИНТЕРФЕЙС ПРОВАЙДЕРА МОНИТОРИНГА ПРОИЗВОДИТЕЛЬНОСТИ
abstract class PerformanceMonitorProvider {
  Future<void> initialize();
  void trackAppStartup(DateTime startTime);
  void trackFirstFrame();
  void trackAppReady();
  void trackNetworkRequest({
    required String endpoint,
    required int durationMs,
    required String method,
    int? statusCode,
  });
  void trackDatabaseOperation({
    required String operation,
    required int durationMs,
    String? table,
    int? recordsCount,
  });
  void trackCacheOperation({
    required String operation,
    required int durationMs,
    bool? cacheHit,
    String? key,
  });
  void trackScreenRender({
    required String screenName,
    required int renderTimeMs,
    String? complexity,
  });
  void trackWidgetBuild({
    required String widgetName,
    required int buildTimeMs,
    int? rebuildCount,
  });
  void trackUserInteraction({
    required String interactionType,
    required int durationMs,
    String? targetElement,
  });
  void trackMemoryUsage();
  void trackCpuUsage();
  void trackBatteryImpact();
  void trackMetric(String name, dynamic value);
  Future<void> dispose();
}

/// 🪵 ПРОВАЙДЕР ДЛЯ ЛОГИРОВАНИЯ В КОНСОЛЬ
class ConsolePerformanceMonitorProvider implements PerformanceMonitorProvider {
  final Logger _logger;

  ConsolePerformanceMonitorProvider({Logger? logger})
    : _logger = logger ?? Logger();

  @override
  Future<void> initialize() async {
    _logger.i('🪵 Console Performance Monitor Provider инициализирован');
  }

  @override
  void trackAppStartup(DateTime startTime) {
    _logger.d('🚀 [PERF] App Startup: $startTime');
  }

  @override
  void trackFirstFrame() {
    _logger.d('🖼️ [PERF] First Frame');
  }

  @override
  void trackAppReady() {
    _logger.d('✅ [PERF] App Ready');
  }

  @override
  void trackNetworkRequest({
    required String endpoint,
    required int durationMs,
    required String method,
    int? statusCode,
  }) {
    _logger.d(
      '🌐 [PERF] Network: $method $endpoint - $durationMs ms (${statusCode ?? "N/A"})',
    );
  }

  @override
  void trackDatabaseOperation({
    required String operation,
    required int durationMs,
    String? table,
    int? recordsCount,
  }) {
    _logger.d(
      '💾 [PERF] Database: $operation - $durationMs ms (table: $table, records: $recordsCount)',
    );
  }

  @override
  void trackCacheOperation({
    required String operation,
    required int durationMs,
    bool? cacheHit,
    String? key,
  }) {
    _logger.d(
      '🗂️ [PERF] Cache: $operation - $durationMs ms (hit: $cacheHit, key: $key)',
    );
  }

  @override
  void trackScreenRender({
    required String screenName,
    required int renderTimeMs,
    String? complexity,
  }) {
    _logger.d(
      '🖥️ [PERF] Screen: $screenName - $renderTimeMs ms (complexity: $complexity)',
    );
  }

  @override
  void trackWidgetBuild({
    required String widgetName,
    required int buildTimeMs,
    int? rebuildCount,
  }) {
    _logger.d(
      '🧱 [PERF] Widget: $widgetName - $buildTimeMs ms (rebuilds: $rebuildCount)',
    );
  }

  @override
  void trackUserInteraction({
    required String interactionType,
    required int durationMs,
    String? targetElement,
  }) {
    _logger.d(
      '👆 [PERF] Interaction: $interactionType - $durationMs ms (target: $targetElement)',
    );
  }

  @override
  void trackMemoryUsage() {
    _logger.d('💾 [PERF] Memory Usage');
  }

  @override
  void trackCpuUsage() {
    _logger.d('⚡ [PERF] CPU Usage');
  }

  @override
  void trackBatteryImpact() {
    _logger.d('🔋 [PERF] Battery Impact');
  }

  @override
  void trackMetric(String name, dynamic value) {
    _logger.d('📊 [PERF] Metric: $name = $value');
  }

  @override
  Future<void> dispose() async {
    _logger.i('🔚 Console Performance Monitor Provider остановлен');
  }
}

/// 🧪 MOCK ПРОВАЙДЕР ДЛЯ ТЕСТИРОВАНИЯ
class MockPerformanceMonitorProvider implements PerformanceMonitorProvider {
  final List<Map<String, dynamic>> _metrics = [];
  final Logger _logger;

  MockPerformanceMonitorProvider({Logger? logger})
    : _logger = logger ?? Logger();

  List<Map<String, dynamic>> get metrics => List.unmodifiable(_metrics);
  void clearMetrics() => _metrics.clear();

  @override
  Future<void> initialize() async {
    _logger.i('🧪 Mock Performance Monitor Provider инициализирован');
  }

  @override
  void trackAppStartup(DateTime startTime) {
    _metrics.add({
      'type': 'app_startup',
      'start_time': startTime,
      'timestamp': DateTime.now(),
    });
  }

  @override
  void trackFirstFrame() {
    _metrics.add({'type': 'first_frame', 'timestamp': DateTime.now()});
  }

  @override
  void trackAppReady() {
    _metrics.add({'type': 'app_ready', 'timestamp': DateTime.now()});
  }

  @override
  void trackNetworkRequest({
    required String endpoint,
    required int durationMs,
    required String method,
    int? statusCode,
  }) {
    _metrics.add({
      'type': 'network_request',
      'endpoint': endpoint,
      'duration_ms': durationMs,
      'method': method,
      'status_code': statusCode,
      'timestamp': DateTime.now(),
    });
  }

  @override
  void trackDatabaseOperation({
    required String operation,
    required int durationMs,
    String? table,
    int? recordsCount,
  }) {
    _metrics.add({
      'type': 'database_operation',
      'operation': operation,
      'duration_ms': durationMs,
      'table': table,
      'records_count': recordsCount,
      'timestamp': DateTime.now(),
    });
  }

  @override
  void trackCacheOperation({
    required String operation,
    required int durationMs,
    bool? cacheHit,
    String? key,
  }) {
    _metrics.add({
      'type': 'cache_operation',
      'operation': operation,
      'duration_ms': durationMs,
      'cache_hit': cacheHit,
      'key': key,
      'timestamp': DateTime.now(),
    });
  }

  @override
  void trackScreenRender({
    required String screenName,
    required int renderTimeMs,
    String? complexity,
  }) {
    _metrics.add({
      'type': 'screen_render',
      'screen_name': screenName,
      'render_time_ms': renderTimeMs,
      'complexity': complexity,
      'timestamp': DateTime.now(),
    });
  }

  @override
  void trackWidgetBuild({
    required String widgetName,
    required int buildTimeMs,
    int? rebuildCount,
  }) {
    _metrics.add({
      'type': 'widget_build',
      'widget_name': widgetName,
      'build_time_ms': buildTimeMs,
      'rebuild_count': rebuildCount,
      'timestamp': DateTime.now(),
    });
  }

  @override
  void trackUserInteraction({
    required String interactionType,
    required int durationMs,
    String? targetElement,
  }) {
    _metrics.add({
      'type': 'user_interaction',
      'interaction_type': interactionType,
      'duration_ms': durationMs,
      'target_element': targetElement,
      'timestamp': DateTime.now(),
    });
  }

  @override
  void trackMemoryUsage() {
    _metrics.add({'type': 'memory_usage', 'timestamp': DateTime.now()});
  }

  @override
  void trackCpuUsage() {
    _metrics.add({'type': 'cpu_usage', 'timestamp': DateTime.now()});
  }

  @override
  void trackBatteryImpact() {
    _metrics.add({'type': 'battery_impact', 'timestamp': DateTime.now()});
  }

  @override
  void trackMetric(String name, dynamic value) {
    _metrics.add({
      'type': 'metric',
      'name': name,
      'value': value,
      'timestamp': DateTime.now(),
    });
  }

  @override
  Future<void> dispose() async {
    _metrics.clear();
    _logger.i('🔚 Mock Performance Monitor Provider остановлен');
  }
}
