// ================================
// 🧭 APP ROUTER - АРХИТЕКТУРА НАВИГАЦИИ
// ================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart'; // Авто-генерируемый файл

// ================================
// 🎯 МАРКЕРЫ СТРАНИЦ ДЛЯ КОДОГЕНЕРАЦИИ
// ================================

/// 🚀 МАРКЕР СТРАНИЦЫ ЗАГРУЗКИ (SPLASH)
///
/// ## 🎯 РЕАЛЬНАЯ РЕАЛИЗАЦИЯ:
/// Будет создана в `features/splash/presentation/pages/splash_page.dart`
@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Splash Page - Architecture Marker')),
    );
  }
}

/// 🔐 МАРКЕР СТРАНИЦЫ АВТОРИЗАЦИИ (LOGIN)
///
/// ## 🎯 РЕАЛЬНАЯ РЕАЛИЗАЦИЯ:
/// Будет создана в `features/auth/presentation/pages/login_page.dart`
@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Login Page - Architecture Marker')),
    );
  }
}

/// 🏠 МАРКЕР ГЛАВНОЙ СТРАНИЦЫ (HOME/DASHBOARD)
///
/// ## 🎯 РЕАЛЬНАЯ РЕАЛИЗАЦИЯ:
/// Будет создана в `features/home/presentation/pages/home_page.dart`
@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Home Page - Architecture Marker')),
    );
  }
}

/// 👤 МАРКЕР СТРАНИЦЫ ПРОФИЛЯ ПОЛЬЗОВАТЕЛЯ
///
/// ## 🎯 ПАРАМЕТРЫ:
/// - `userId` - идентификатор пользователя
///
/// ## 🎯 РЕАЛЬНАЯ РЕАЛИЗАЦИЯ:
/// Будет создана в `features/profile/presentation/pages/profile_page.dart`
@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({required this.userId, super.key});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Profile Page - User: $userId')));
  }
}

/// ⚙️ МАРКЕР СТРАНИЦЫ НАСТРОЕК ПРИЛОЖЕНИЯ
///
/// ## 🎯 РЕАЛЬНАЯ РЕАЛИЗАЦИЯ:
/// Будет создана в `features/settings/presentation/pages/settings_page.dart`
@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Settings Page - Architecture Marker')),
    );
  }
}

// ================================
// 🎯 ОСНОВНОЙ РОУТЕР ПРИЛОЖЕНИЯ
// ================================

/// 🧭 ЦЕНТРАЛЬНЫЙ РОУТЕР ПРИЛОЖЕНИЯ
///
/// ## 🏗️ АРХИТЕКТУРНЫЕ ОСОБЕННОСТИ:
/// - **Type-safe навигация** - compile-time проверки
/// - **Guards система** - защита маршрутов
/// - **Nested routing** - сложные навигационные сценарии
/// - **Deep linking** - универсальные ссылки

@AutoRouterConfig()
class AppRouter {
  List<AutoRoute> get routes => [
    // ================================
    // 🔓 PUBLIC ROUTES - ОТКРЫТЫЕ МАРШРУТЫ
    // ================================

    /// 🚀 МАРШРУТ ЗАГРУЗКИ
    AutoRoute(page: SplashRoute.page, initial: true),

    /// 🔐 МАРШРУТ АВТОРИЗАЦИИ
    AutoRoute(page: LoginRoute.page),

    // ================================
    // 🔐 PROTECTED ROUTES - ЗАЩИЩЕННЫЕ МАРШРУТЫ
    // ================================

    /// 🏠 МАРШРУТ ГЛАВНОЙ СТРАНИЦЫ
    AutoRoute(
      page: HomeRoute.page,
      // guards: [AuthGuard], // Будет добавлен после создания AuthGuard
    ),

    /// 👤 МАРШРУТ ПРОФИЛЯ ПОЛЬЗОВАТЕЛЯ
    AutoRoute(
      page: ProfileRoute.page,
      // guards: [AuthGuard],
    ),

    /// ⚙️ МАРШРУТ НАСТРОЕК
    AutoRoute(
      page: SettingsRoute.page,
      // guards: [AuthGuard],
    ),
  ];
}

// ================================
// 🎯 NAVIGATION EXTENSIONS
// ================================

/// 🧭 РАСШИРЕНИЯ ДЛЯ УПРОЩЕННОЙ НАВИГАЦИИ
extension AppNavigation on BuildContext {
  /// 🚀 ПЕРЕХОД НА SPLASH ЭКРАН
  void navigateToSplash() => pushRoute(const SplashRoute());

  /// 🔐 ПЕРЕХОД НА LOGIN ЭКРАН
  void navigateToLogin() => pushRoute(const LoginRoute());

  /// 🏠 ПЕРЕХОД НА HOME ЭКРАН
  void navigateToHome() => pushRoute(const HomeRoute());

  /// 👤 ПЕРЕХОД НА PROFILE ЭКРАН
  void navigateToProfile(String userId) =>
      pushRoute(ProfileRoute(userId: userId));

  /// ⚙️ ПЕРЕХОД НА SETTINGS ЭКРАН
  void navigateToSettings() => pushRoute(const SettingsRoute());

  /// 🔄 ЗАМЕНА ВСЕГО СТЕКА НА HOME
  //void clearStackToHome() => pushReplacement(const HomeRoute()); Убрал потому что не работает и не факт что нужен
}
