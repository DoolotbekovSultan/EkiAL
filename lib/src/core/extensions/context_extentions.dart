import 'package:flutter/material.dart';

/// Расширения для BuildContext
///
/// ## 🔧 Доступные методы:
/// ### Тема и стили:
/// - `theme` → ThemeData
/// - `colorScheme` → ColorScheme
/// - `textTheme` → TextTheme
/// - `isDarkMode` → bool
/// - `primaryColor` → Color
///
/// ### Размеры экрана:
/// - `screenSize` → Size
/// - `screenWidth` → double
/// - `screenHeight` → double
/// - `isTablet` → bool
/// - `isPhone` → bool
/// - `safeAreaPadding` → EdgeInsets
///
/// ### Навигация и диалоги:
/// - `push(page)` → Future`<T?>`
/// - `pop([result])` → void
/// - `pushReplacement(page)` → Future`<T?>`
/// - `showSnackBar(message)` → void
/// - `showAppDialog(dialog)` → Future`<T?>`

extension ContextExtensions on BuildContext {
  // ================================
  // 🎨 ДОСТУП К ТЕМЕ И СТИЛЯМ
  // ================================

  /// Возвращает тему приложения
  ThemeData get theme => Theme.of(this);

  /// Возвращает цветовую схему
  ColorScheme get colorScheme => theme.colorScheme;

  /// Возвращает текстовую тему
  TextTheme get textTheme => theme.textTheme;

  /// Проверяет используется ли темная тема
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Возвращает primary цвет
  Color get primaryColor => colorScheme.primary;

  // ================================
  // 📱 РАЗМЕРЫ ЭКРАНА И ОРИЕНТАЦИЯ
  // ================================

  /// Возвращает размеры экрана
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Возвращает ширину экрана
  double get screenWidth => screenSize.width;

  /// Возвращает высоту экрана
  double get screenHeight => screenSize.height;

  /// Проверяет является ли устройство планшетом
  bool get isTablet => screenWidth >= 600;

  /// Проверяет является ли устройство телефоном
  bool get isPhone => screenWidth < 600;

  /// Возвращает padding от безопасных областей
  EdgeInsets get safeAreaPadding => MediaQuery.paddingOf(this);

  // ================================
  // 🧭 НАВИГАЦИЯ И ДИАЛОГИ
  // ================================

  /// Переход на новый экран
  Future<T?> push<T>(Widget page) =>
      Navigator.push(this, MaterialPageRoute(builder: (_) => page));

  /// Возврат на предыдущий экран
  void pop<T>([T? result]) => Navigator.pop(this, result);

  /// Замена текущего экрана
  Future<T?> pushReplacement<T>(Widget page) =>
      Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => page));

  /// Показ snackbar сообщения
  void showSnackBar(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));

  /// Показ диалогового окна (переименован чтобы избежать конфликта)
  Future<T?> showAppDialog<T>(Widget dialog) =>
      showDialog<T>(context: this, builder: (_) => dialog);
}
