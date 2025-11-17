// ================================
// 🎛️ THEME CONTROLLER - КОНТРОЛЛЕР УПРАВЛЕНИЯ ТЕМАМИ
// ================================

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 🎯 КОНТРОЛЛЕР ДЛЯ УПРАВЛЕНИЯ ТЕМАМИ ПРИЛОЖЕНИЯ
///
/// Отвечает за:
/// - Переключение между светлой и темной темами
/// - Сохранение выбора темы пользователя
/// - Синхронизацию с системной темой
/// - Уведомление об изменении темы
///
/// ## 🎯 ЛУЧШИЕ ПРАКТИКИ ИСПОЛЬЗОВАНИЯ:
/// - ✅ Используйте ChangeNotifier для реактивности
/// - ✅ Сохраняйте выбор темы в持久ном хранилище
/// - ✅ Поддерживайте синхронизацию с системной темой
/// - ✅ Обрабатывайте ошибки при загрузке/сохранении
/// - ✅ Уведомляйте подписчиков об изменении состояния
class ThemeController with ChangeNotifier {
  // ================================
  // 🏗️ КОНСТАНТЫ И ПЕРЕМЕННЫЕ
  // ================================

  /// Ключ для сохранения темы в SharedPreferences
  static const String _themeModeKey = 'app_theme_mode';

  /// Текущий режим темы приложения
  ThemeMode _themeMode = ThemeMode.system;

  /// Приватный конструктор
  ThemeController();

  // ================================
  // 🎯 ГЕТТЕРЫ ДЛЯ ДОСТУПА К СОСТОЯНИЮ
  // ================================

  /// Текущий режим темы приложения
  ThemeMode get themeMode => _themeMode;

  /// Проверка, активна ли светлая тема
  bool get isLight => _themeMode == ThemeMode.light;

  /// Проверка, активна ли темная тема
  bool get isDark => _themeMode == ThemeMode.dark;

  /// Проверка, используется ли системная тема
  bool get isSystem => _themeMode == ThemeMode.system;

  /// Получить актуальную тему на основе текущего режима и яркости системы
  ThemeData getCurrentTheme(Brightness platformBrightness) {
    switch (_themeMode) {
      case ThemeMode.light:
        return _lightTheme;
      case ThemeMode.dark:
        return _darkTheme;
      case ThemeMode.system:
        return platformBrightness == Brightness.dark ? _darkTheme : _lightTheme;
    }
  }

  // ================================
  // 🎯 МЕТОДЫ УПРАВЛЕНИЯ ТЕМОЙ
  // ================================

  /// Переключить на светлую тему
  ///
  /// ## Использование:
  /// ```dart
  /// themeController.setLightTheme();
  /// ```
  Future<void> setLightTheme() async {
    _themeMode = ThemeMode.light;
    await _saveThemeMode();
    notifyListeners();
  }

  /// Переключить на темную тему
  ///
  /// ## Использование:
  /// ```dart
  /// themeController.setDarkTheme();
  /// ```
  Future<void> setDarkTheme() async {
    _themeMode = ThemeMode.dark;
    await _saveThemeMode();
    notifyListeners();
  }

  /// Переключить на системную тему
  ///
  /// ## Использование:
  /// ```dart
  /// themeController.setSystemTheme();
  /// ```
  Future<void> setSystemTheme() async {
    _themeMode = ThemeMode.system;
    await _saveThemeMode();
    notifyListeners();
  }

  /// Переключить тему (циклическое переключение)
  ///
  /// ## Логика переключения:
  /// - light → dark → system → light
  ///
  /// ## Использование:
  /// ```dart
  /// themeController.toggleTheme();
  /// ```
  Future<void> toggleTheme() async {
    switch (_themeMode) {
      case ThemeMode.light:
        await setDarkTheme();
        break;
      case ThemeMode.dark:
        await setSystemTheme();
        break;
      case ThemeMode.system:
        await setLightTheme();
        break;
    }
  }

  // ================================
  // 💾 СОХРАНЕНИЕ И ЗАГРУЗКА СОСТОЯНИЯ
  // ================================

  /// Загрузить сохраненную тему из SharedPreferences
  ///
  /// ## Использование:
  /// - Вызывать при инициализации приложения
  /// - Восстанавливает выбор пользователя
  Future<void> loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedThemeMode = prefs.getString(_themeModeKey);

      if (savedThemeMode != null) {
        _themeMode = _parseThemeMode(savedThemeMode);
        notifyListeners();
      }
    } catch (error) {
      // В случае ошибки используем тему по умолчанию
      _themeMode = ThemeMode.system;
      debugPrint('Ошибка загрузки темы: $error');
    }
  }

  /// Сохранить текущий режим темы в SharedPreferences
  ///
  /// ## Использование:
  /// - Вызывается автоматически при изменении темы
  /// - Сохраняет выбор пользователя для будущих сессий
  Future<void> _saveThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeModeKey, _themeMode.toString());
    } catch (error) {
      debugPrint('Ошибка сохранения темы: $error');
      // Продолжаем работу даже при ошибке сохранения
    }
  }

  // ================================
  // 🛠️ ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ
  // ================================

  /// Парсить строку в ThemeMode
  ThemeMode _parseThemeMode(String themeModeString) {
    switch (themeModeString) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.system':
      default:
        return ThemeMode.system;
    }
  }

  /// Сбросить настройки темы к значениям по умолчанию
  ///
  /// ## Использование:
  /// - Для debug целей
  /// - При сбросе настроек приложения
  Future<void> resetToDefault() async {
    _themeMode = ThemeMode.system;
    await _saveThemeMode();
    notifyListeners();
  }

  // ================================
  // 🎨 ССЫЛКИ НА ТЕМЫ (заменить на ваши реальные темы)
  // ================================

  /// Ссылка на светлую тему
  ///
  /// ## Замените на вашу реальную светлую тему:
  /// ```dart
  /// static final ThemeData _lightTheme = LightTheme.themeData;
  /// ```
  static final ThemeData _lightTheme = ThemeData.light();

  /// Ссылка на темную тему
  ///
  /// ## Замените на вашу реальную темную тему:
  /// ```dart
  /// static final ThemeData _darkTheme = DarkTheme.themeData;
  /// ```
  static final ThemeData _darkTheme = ThemeData.dark();
}
