# monitoring/

## Назначение
Папка `monitoring` содержит сервисы для мониторинга приложения, включая аналитику, отслеживание ошибок и производительности.

## Используемые библиотеки
- **sentry_flutter** - отчеты об ошибках и crash reporting
- **firebase_analytics** - аналитика событий (опционально)
- **logger** - структурированное логирование

## Структура
**monitoring/** - 📊 Мониторинг приложения
- analytics_service.dart - 📈 Аналитика событий
- crash_reporting_service.dart - ⚠️ Отчеты об ошибках
- performance_monitor.dart - ⚡ Мониторинг производительности
- monitoring_module.dart - 🎛️ DI модуль мониторинга

## Описание файлов

### analytics_service.dart
Сервис для отслеживания аналитических событий.

Содержит:
- трекинг пользовательских событий
- отслеживание экранов и навигации
- пользовательские метрики и свойства
- абстракцию для разных аналитических провайдеров

### crash_reporting_service.dart
Сервис для отчетов об ошибках и crash reporting.

Содержит:
- автоматическое отслеживание ошибок
- ручную отправку исключений
- контекст пользователя для ошибок
- интеграцию с системами мониторинга

### performance_monitor.dart
Мониторинг производительности приложения.

Содержит:
- замер времени запуска приложения
- отслеживание производительности сетевых запросов
- мониторинг времени отклика UI
- метрики использования памяти

### monitoring_module.dart
Модуль DI для сервисов мониторинга.

Содержит:
- регистрацию сервисов мониторинга в DI
- настройку провайдеров аналитики
- конфигурацию уровней логирования

## Преимущества

- Централизованное управление мониторингом
- Абстракция от конкретных провайдеров аналитики
- Единообразное логирование ошибок
- Легкое тестирование с mock реализациями
- Гибкая настройка уровней мониторинга

## Best Practices

1. Используйте абстракции для легкой смены провайдеров аналитики
2. Настройте разные уровни логирования для dev/prod окружений
3. Не логируйте конфиденциальные данные пользователя
4. Используйте структурированные события для аналитики
5. Настройте автоматическое отслеживание ошибок
6. Мониторьте ключевые метрики производительности
7. Тестируйте все сценарии мониторинга
8. Настройте фильтрацию спам-событий

## Примеры использования

```dart
// Абстрактный сервис аналитики
abstract class AnalyticsService {
  Future<void> initialize();
  void trackEvent(String name, [Map<String, dynamic>? parameters]);
  void trackScreen(String screenName, [Map<String, dynamic>? parameters]);
  void setUserProperties(Map<String, dynamic> properties);
  void setUserId(String? userId);
}
// Реализация с Firebase Analytics
class FirebaseAnalyticsService implements AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> initialize() async {
    await _analytics.setAnalyticsCollectionEnabled(true);
  }

  @override
  void trackEvent(String name, [Map<String, dynamic>? parameters]) {
    _analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  @override
  void trackScreen(String screenName, [Map<String, dynamic>? parameters]) {
    _analytics.logScreenView(
      screenName: screenName,
      parameters: parameters,
    );
  }
}
// Сервис отчетов об ошибках
abstract class CrashReportingService {
  Future<void> initialize();
  void recordError(dynamic error, StackTrace stackTrace, {String? context});
  void recordFlutterError(FlutterErrorDetails details);
  void setUserContext(String? userId, Map<String, dynamic>? userData);
}

class SentryCrashReportingService implements CrashReportingService {
  @override
  Future<void> initialize() async {
    await SentryFlutter.init(
      (options) {
        options.dsn = 'YOUR_SENTRY_DSN';
        options.tracesSampleRate = 1.0;
        options.enableAppLifecycleBreadcrumbs = true;
      },
    );
  }

  @override
  void recordError(dynamic error, StackTrace stackTrace, {String? context}) {
    Sentry.captureException(
      error,
      stackTrace: stackTrace,
      hint: context != null ? Hint.withMap({'context': context}) : null,
    );
  }
}
// Мониторинг производительности
abstract class PerformanceMonitor {
  void trackAppStartup(DateTime startTime);
  void trackNetworkRequest(String endpoint, int durationMs);
  void trackScreenRender(String screenName, int renderTimeMs);
  void trackMemoryUsage();
}

class AppPerformanceMonitor implements PerformanceMonitor {
  final AnalyticsService _analytics;

  AppPerformanceMonitor(this._analytics);

  @override
  void trackAppStartup(DateTime startTime) {
    final duration = DateTime.now().difference(startTime).inMilliseconds;
    _analytics.trackEvent('app_startup', {'duration_ms': duration});
  }

  @override
  void trackNetworkRequest(String endpoint, int durationMs) {
    _analytics.trackEvent('network_request', {
      'endpoint': endpoint,
      'duration_ms': durationMs,
    });
  }
}
// Модуль DI для мониторинга
@module
abstract class MonitoringModule {
  @singleton
  AnalyticsService get analyticsService => FirebaseAnalyticsService();

  @singleton
  CrashReportingService get crashReportingService => 
      SentryCrashReportingService();

  @singleton
  PerformanceMonitor get performanceMonitor => 
      AppPerformanceMonitor(getIt<AnalyticsService>());
}
// Использование в приложении
class MyApp extends StatelessWidget {
  final DateTime _startTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        // Отслеживание производительности запуска
        WidgetsBinding.instance.addPostFrameCallback((_) {
          getIt<PerformanceMonitor>().trackAppStartup(_startTime);
        });

        return child!;
      },
      home: const HomePage(),
    );
  }
}

// В репозитории для отслеживания сетевых запросов
class UserRepositoryImpl implements UserRepository {
  final AnalyticsService _analytics;

  Future<User> getUser(String id) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final user = await _apiService.getUser(id);
      _analytics.trackEvent('user_fetch_success', {'user_id': id});
      return user;
    } catch (error, stackTrace) {
      _analytics.trackEvent('user_fetch_error', {
        'user_id': id,
        'error': error.toString(),
      });
      getIt<CrashReportingService>().recordError(error, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
      getIt<PerformanceMonitor>().trackNetworkRequest(
        '/users/$id',
        stopwatch.elapsedMilliseconds,
      );
    }
  }
}

Конфигурация для разных окружений

class MonitoringConfig {
  static bool get isCrashReportingEnabled => 
      !AppConfig.current.isDebug || kDebugMode;

  static bool get isAnalyticsEnabled =>
      AppConfig.current.enableAnalytics;

  static double get tracesSampleRate =>
      AppConfig.current.isDebug ? 0.1 : 1.0;
}