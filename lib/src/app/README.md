# app/

## Назначение
Папка `app` содержит конфигурацию и инициализацию приложения, включая настройку окружений, навигацию и запуск.

## Структура
**app/** - 📱 Конфигурация приложения
- config/ - ⚙️ Настройки окружений
- navigation/ - 🧭 Маршрутизация
- bootstrap/ - 🚀 Инициализация
- app.dart

## Описание директорий

### config/
Конфигурации для разных окружений приложения.

Содержит:
- настройки для development окружения
- настройки для staging окружения  
- настройки для production окружения
- базовый класс конфигурации

### navigation/
Конфигурация навигации и маршрутизации.

Содержит:
- определение маршрутов приложения
- guards для защиты маршрутов
- утилиты для навигации
- анимации переходов

### bootstrap/
Инициализация и запуск приложения.

Содержит:
- инициализацию сервисов
- настройку зависимостей
- обработку ошибок запуска
- подготовку данных перед запуском

## Преимущества

- Централизованная конфигурация приложения
- Легкое переключение между окружениями
- Type-safe навигация
- Контролируемый запуск приложения
- Единая точка инициализации

## Best Practices

1. Используйте разные конфигурации для каждого окружения
2. Настройте guards для защиты маршрутов
3. Инициализируйте все сервисы перед запуском приложения
4. Обрабатывайте ошибки инициализации
5. Используйте type-safe навигацию
6. Логируйте процесс запуска приложения
7. Настройте обработку глубоких ссылок
8. Тестируйте разные сценарии запуска

## Примеры использования

```dart
// Инициализация приложения
void main() async {
  await Bootstrap.initialize();
  runApp(const MyApp());
}

// Использование конфигурации
final apiUrl = AppConfig.current.baseUrl;
final isDebug = AppConfig.current.isDebug;

// Навигация
context.router.push(const HomeRoute());
context.router.replace(const LoginRoute());

// Проверка guards
AutoRoute(
  page: ProfileRoute.page,
  guards: [AuthGuard],
);
// Конфигурация окружений
// Development конфигурация
class DevConfig implements AppConfig {
  @override
  String get baseUrl => 'https://dev.api.example.com';
  
  @override
  bool get isDebug => true;
  
  @override
  String get environmentName => 'Development';
}

// Production конфигурация  
class ProdConfig implements AppConfig {
  @override
  String get baseUrl => 'https://api.example.com';
  
  @override
  bool get isDebug => false;
  
  @override
  String get environmentName => 'Production';
}
// Навигация
// Определение маршрутов
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: ProfileRoute.page),
  ];
}

// Guards для защиты маршрутов
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authService.isAuthenticated) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
// Инициализация приложения
class Bootstrap {
  static Future<void> initialize() async {
    // Инициализация WidgetsBinding
    WidgetsFlutterBinding.ensureInitialized();
    
    // Настройка конфигурации
    await AppConfig.initialize();
    
    // Настройка DI
    await configureDependencies();
    
    // Предзагрузка данных
    await _preloadEssentialData();
    
    // Настройка мониторинга
    await _setupMonitoring();
  }
  
  static Future<void> _preloadEssentialData() async {
    // Загрузка необходимых данных при старте
    await settingsService.loadSettings();
    await userService.tryAutoLogin();
  }
}