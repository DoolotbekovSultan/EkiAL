# navigation/

## Назначение
Папка `navigation` содержит конфигурацию маршрутизации и навигации приложения с использованием **AutoRoute** для type-safe навигации.

## Используемые библиотеки
- **auto_route** - type-safe маршрутизация с кодогенерацией
- **injectable** - интеграция с Dependency Injection

## Структура
**navigation/** - 🧭 Маршрутизация
- app_router.dart - 🎯 Основной роутер
- route_guards.dart - 🛡️ Защита маршрутов
- route_names.dart - 📝 Имена маршрутов
- navigation_utils.dart - 🔧 Навигационные утилиты

## Описание файлов

### app_router.dart
Основной файл маршрутизации приложения с AutoRoute.

Содержит:
- определение всех маршрутов с кодогенерацией
- настройку навигационных стеков
- конфигурацию переходов и анимаций
- обработку глубоких ссылок

### route_guards.dart
Guards для защиты маршрутов.

Содержит:
- проверки авторизации
- валидацию доступа к маршрутам
- обработку перенаправлений
- условия для навигации

### route_names.dart
Константы с именами маршрутов.

Содержит:
- именованные константы для всех маршрутов
- параметры маршрутов
- пути для глубоких ссылок
- утилиты для построения URL

### navigation_utils.dart
Утилиты для работы с навигацией.

Содержит:
- методы для упрощенной навигации
- обработку навигационных событий
- утилиты для работы с историей
- методы для модальных окон

## Преимущества AutoRoute

- **Type-safe навигация** - ошибки ловятся на этапе компиляции
- **Кодогенерация** - автоматическое создание кода маршрутов
- **Интеграция с DI** - работает с GetIt/Injectable
- **Вложенные роутеры** - для сложной навигации
- **Null-safety** - полная поддержка

## Best Practices

1. Используйте именованные константы для всех маршрутов
2. Настройте guards для защиты чувствительных маршрутов
3. Используйте кодогенерацию AutoRoute для type-safe навигации
4. Обрабатывайте глубокие ссылки и универсальные ссылки
5. Логируйте навигационные события для отладки
6. Тестируйте все сценарии навигации
7. Используйте модальные маршруты для всплывающих окон
8. Настройте правильную историю навигации

## Особенности AutoRoute

- Все маршруты должны заканчиваться на "Page"
- Классы маршрутов генерируются автоматически
- Навигация полностью type-safe
- Поддержка параметров через конструкторы
- Интеграция с системой зависимостей

## Команды для кодогенерации

```bash
# Для разработки (автоматическая генерация при изменениях)
flutter pub run build_runner watch --delete-conflicting-outputs

# Для продакшн (однократная генерация)
flutter pub run build_runner build --delete-conflicting-outputs

# Очистка сгенерированных файлов
flutter pub run build_runner clean

// Основной роутер приложения с AutoRoute
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    // Public routes
    AutoRoute(
      page: SplashRoute.page,
      initial: true,
    ),
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
    ),
    
    // Protected routes
    AutoRoute(
      page: HomeRoute.page,
      path: '/home',
      guards: [AuthGuard],
    ),
    
    // Nested routes
    AutoRoute(
      page: MainRoute.page,
      path: '/main',
      guards: [AuthGuard],
      children: [
        AutoRoute(
          page: DashboardRoute.page,
          path: 'dashboard',
        ),
        AutoRoute(
          page: SettingsRoute.page,
          path: 'settings',
        ),
      ],
    ),
  ];
}
// Guards для AutoRoute
class AuthGuard extends AutoRouteGuard {
  final AuthRepository _authRepository;
  
  AuthGuard(this._authRepository);
  
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isAuthenticated = await _authRepository.isAuthenticated();
    
    if (isAuthenticated) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
// Type-safe навигация с AutoRoute
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Type-safe навигация
            context.pushRoute(const ProfileRoute(userId: '123'));
          },
          child: const Text('Go to Profile'),
        ),
      ),
    );
  }
}
// Интеграция с DI
@module
abstract class NavigationModule {
  @singleton
  AppRouter get appRouter => AppRouter();
  
  @factory
  AuthGuard get authGuard => AuthGuard(getIt<AuthRepository>());
}
// Использование в приложении
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Настройка DI
  await configureDependencies();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter router = getIt<AppRouter>();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router.config(),
      theme: AppTheme.light,
    );
  }
}