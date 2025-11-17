// ================================
// 📝 ROUTE NAMES - КОНСТАНТЫ ИМЕН МАРШРУТОВ
// ================================

/// 🎯 КОНСТАНТЫ ДЛЯ ИМЕН МАРШРУТОВ
class RouteNames {
  // 🔓 PUBLIC ROUTES
  static const String splash = 'SplashRoute';
  static const String login = 'LoginRoute';

  // 🔐 PROTECTED ROUTES
  static const String home = 'HomeRoute';
  static const String profile = 'ProfileRoute';
  static const String settings = 'SettingsRoute';
}

/// 🎯 УТИЛИТЫ ДЛЯ ПОСТРОЕНИЯ ПУТЕЙ
class RoutePaths {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile/:userId';
  static const String settings = '/settings';

  /// 🎯 ПОСТРОЕНИЕ ПУТИ С ПАРАМЕТРАМИ
  static String profileWithId(String userId) => '/profile/$userId';
}
