# bootstrap/

## Назначение
Папка `bootstrap` содержит логику инициализации и запуска приложения, включая настройку сервисов, загрузку зависимостей и подготовку данных перед стартом.

## Используемые библиотеки
- **get_it** - доступ к DI контейнеру

## Структура
**bootstrap/** - 🚀 Инициализация приложения
- app_initializer.dart - 🎯 Основной инициализатор
- service_configurator.dart - ⚙️ Конфигуратор сервисов
- data_preloader.dart - 📥 Предзагрузчик данных

## Описание файлов

### app_initializer.dart
Основной класс инициализации приложения.

Содержит:
- последовательность инициализации компонентов
- обработку ошибок запуска
- настройку глобальных обработчиков ошибок
- отслеживание прогресса инициализации

### service_configurator.dart
Конфигуратор сервисов приложения.

Содержит:
- настройку сетевых сервисов
- инициализацию локального хранилища
- конфигурацию кэширования
- настройку инфраструктурных сервисов

### data_preloader.dart
Предзагрузчик данных приложения.

Содержит:
- загрузку пользовательских настроек
- проверку авторизации
- загрузку кэшированных данных
- инициализацию необходимых данных при старте

## Преимущества

- Контролируемый порядок инициализации
- Централизованная обработка ошибок запуска
- Оптимизированное время старта приложения
- Надежная подготовка окружения
- Отслеживание прогресса инициализации

## Best Practices

1. Инициализируйте сервисы в правильном порядке зависимостей
2. Обрабатывайте ошибки инициализации каждого компонента
3. Используйте асинхронную инициализацию для тяжелых операций
4. Логируйте процесс инициализации для отладки
5. Предзагружайте только критически важные данные
6. Настройте fallback-механизмы при неудачной инициализации
7. Тестируйте различные сценарии запуска приложения
8. Оптимизируйте время инициализации для лучшего UX

## Примеры использования

```dart
// Основная инициализация приложения с прогрессом
class AppInitializer {
  static final ValueNotifier<double> progress = ValueNotifier(0.0);
  
  static Future<void> initialize() async {
    try {
      final totalSteps = 4;
      var currentStep = 0;
      
      _updateProgress(++currentStep, totalSteps); // 25%
      await _setupErrorHandling();
      
      _updateProgress(++currentStep, totalSteps); // 50%
      await ServiceConfigurator.initializeServices();
      
      _updateProgress(++currentStep, totalSteps); // 75%
      await DataPreloader.preloadEssentialData();
      
      _updateProgress(++currentStep, totalSteps); // 100%
      await _setupMonitoring();
      
    } catch (error, stackTrace) {
      await _handleInitializationError(error, stackTrace);
    }
  }
  
  static void _updateProgress(int step, int total) {
    progress.value = step / total;
  }
}
// Конфигурация только инфраструктурных сервисов
class ServiceConfigurator {
  static Future<void> initializeServices() async {
    // 1. Базовая конфигурация
    await _initializeCoreServices();
    
    // 2. Сетевые сервисы
    await _initializeNetworkServices();
    
    // 3. Локальное хранилище
    await _initializeStorageServices();
    
    // Бизнес-сервисы инициализируются лениво через DI
  }
  
  static Future<void> _initializeCoreServices() async {
    // Настройка DI
    await configureDependencies();
    
    // Проверка, что DI готов
    assert(getIt.isReady<Dio>(), 'Dio service not registered in DI');
    
    // Инициализация тем
    await getIt<ThemeController>().initialize();
    
    // Настройка локализации
    await getIt<LocalizationService>().initialize();
  }
  
  static Future<void> _initializeNetworkServices() async {
    final dio = getIt<Dio>();
    final networkInfo = getIt<NetworkInfo>();
    
    // Проверка сетевого подключения
    final hasConnection = await networkInfo.isConnected;
    if (!hasConnection) {
      throw NetworkException('No internet connection on app start');
    }
    
    // Настройка базовых интерцепторов
    dio.interceptors.addAll([
      getIt<AuthInterceptor>(),
      getIt<LoggingInterceptor>(),
    ]);
  }
  
  static Future<void> _initializeStorageServices() async {
    // Инициализация локальных баз данных
    await getIt<LocalDatabase>().initialize();
    await getIt<CacheService>().initialize();
  }
}
// Предзагрузка данных с проверкой зависимостей
class DataPreloader {
  static Future<void> preloadEssentialData() async {
    // Проверка, что необходимые сервисы зарегистрированы в DI
    _verifyDependencies();
    
    final preloadTasks = <Future<void>>[
      // Загрузка пользовательских настроек
      _loadUserSettings(),
      
      // Проверка авторизации (не блокирующая)
      _checkAuthenticationStatus(),
    ];
    
    await Future.wait(preloadTasks, eagerError: true);
  }
  
  static void _verifyDependencies() {
    final requiredServices = [
      SettingsService,
      AuthRepository,
      UserRepository,
    ];
    
    for (final service in requiredServices) {
      if (!getIt.isRegistered<service>()) {
        throw StateError('Service $service not registered in DI');
      }
    }
  }
  
  static Future<void> _loadUserSettings() async {
    final settings = getIt<SettingsService>();
    await settings.loadSettings();
    
    // Применение настроек темы
    final themeController = getIt<ThemeController>();
    await themeController.applySavedTheme();
  }
  
  static Future<void> _checkAuthenticationStatus() async {
    final authRepo = getIt<AuthRepository>();
    final userRepo = getIt<UserRepository>();
    
    try {
      final isAuthenticated = await authRepo.isAuthenticated();
      if (isAuthenticated) {
        // Предзагрузка данных пользователя
        await userRepo.getCurrentUser();
      }
    } catch (error) {
      // Не блокируем запуск приложения при ошибке авторизации
      Logger.warning('Auth preload failed: $error');
    }
  }
}
// Обработка ошибок инициализации с recovery
class AppInitializer {
  static Future<void> _handleInitializationError(
    dynamic error, 
    StackTrace stackTrace,
  ) async {
    Logger.error('App initialization failed', error, stackTrace);
    
    // Логирование для аналитики
    getIt<AnalyticsService>().trackError(
      'app_initialization_failed', 
      error, 
      stackTrace,
    );
    
    // Попытка восстановиться для некритических ошибок
    if (await _canRecoverFromError(error)) {
      Logger.info('Attempting to recover from initialization error');
      await _attemptRecovery();
    } else {
      // Критическая ошибка - показываем пользователю
      await _showFatalErrorDialog(error);
    }
  }
  
  static Future<bool> _canRecoverFromError(dynamic error) async {
    return error is NetworkException || 
           error is CacheException ||
           error is TimeoutException;
  }
  
  static Future<void> _attemptRecovery() async {
    try {
      // Попытка переинициализировать проблемные сервисы
      await getIt<CacheService>().clearCorruptedData();
      await getIt<NetworkInfo>().checkConnection();
    } catch (recoveryError) {
      // Если восстановление не удалось - фатальная ошибка
      await _showFatalErrorDialog(recoveryError);
    }
  }
  
  static Future<void> _setupErrorHandling() {
    // Глобальная обработка ошибок Flutter
    FlutterError.onError = (details) {
      Logger.error('Flutter error', details.exception, details.stack);
      getIt<AnalyticsService>().trackError(
        'flutter_error',
        details.exception,
        details.stack,
      );
    };
    
    // Обработка непойманных исключений
    PlatformDispatcher.instance.onError = (error, stack) {
      Logger.error('Uncaught exception', error, stack);
      getIt<AnalyticsService>().trackError('uncaught_exception', error, stack);
      return true;
    };
  }
  
  static Future<void> _setupMonitoring() async {
    // Инициализация мониторинга после успешного старта
    await getIt<AnalyticsService>().initialize();
    await getIt<PerformanceMonitor>().start();
  }
}
// Использование в main.dart
void main() async {
  // Отслеживание прогресса инициализации
  AppInitializer.progress.addListener(() {
    debugPrint('Initialization progress: ${(AppInitializer.progress.value * 100).round()}%');
  });
  
  try {
    await AppInitializer.initialize();
    runApp(const MyApp());
  } catch (error) {
    // Резервный запуск при критической ошибке
    runApp(const ErrorApp());
  }
}