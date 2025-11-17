// ================================
// 🌙 DARK THEME - ТЕМНАЯ ТЕМА ПРИЛОЖЕНИЯ
// ================================

import 'package:eki_al/src/core/theme/qap.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

/// 🎯 КОНФИГУРАЦИЯ ТЕМНОЙ ТЕМЫ ПРИЛОЖЕНИЯ
///
/// Реализует полную темную тему на основе Material Design 3.
///
/// ## 🎯 ОСОБЕННОСТИ ТЕМНОЙ ТЕМЫ:
/// - ✅ Приглушенные цвета для комфортного ночного использования
/// - ✅ Оптимальная контрастность для уменьшения нагрузки на глаза
/// - ✅ Сохранение readability при низкой освещенности
/// - ✅ Полная поддержка Material Design 3 компонентов
/// - ✅ Соответствует WCAG AA accessibility standards
///
/// ## 🎨 ЦВЕТОВАЯ СТРАТЕГИЯ:
/// - Primary: Светло-синий (#66A3FF) - для лучшей видимости в темноте
/// - Surface: Темно-серый (#121212) - для глубокого фона
/// - Background: Черный (#121212) - для основного фона
/// - Text: Белый и светло-серый - для оптимальной читабельности
class DarkTheme {
  DarkTheme._();

  // ================================
  // 🌟 ОСНОВНАЯ КОНФИГУРАЦИЯ ТЕМЫ
  // ================================

  /// 🌟 ГЛАВНАЯ ТЕМНАЯ ТЕМА ПРИЛОЖЕНИЯ
  ///
  /// ## КЛЮЧЕВЫЕ ХАРАКТЕРИСТИКИ:
  /// - Material Design 3: Полная поддержка latest Material Design
  /// - Eye Comfort: Оптимизирована для комфортного ночного использования
  /// - Accessibility: Соответствует стандартам доступности WCAG AA
  /// - Consistency: Единообразие across all components
  static ThemeData get themeData {
    return ThemeData(
      // ================================
      // 🎨 БАЗОВАЯ КОНФИГУРАЦИЯ
      // ================================
      colorScheme: _colorScheme,
      useMaterial3: true,
      brightness: Brightness.dark,

      // ================================
      // 🔤 ТИПОГРАФИКА И ТЕКСТ
      // ================================
      textTheme: _textTheme,

      // ================================
      // 🎯 КОМПОНЕНТЫ MATERIAL DESIGN
      // ================================
      appBarTheme: _appBarTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      cardTheme: _cardTheme,
      dialogTheme: _dialogTheme,
      snackBarTheme: _snackBarTheme,

      // ================================
      // 📐 ВИЗУАЛЬНЫЕ НАСТРОЙКИ
      // ================================
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // ================================
  // 🎨 COLOR SCHEME - ЦВЕТОВАЯ СХЕМА
  // ================================

  /// 🎯 ЦВЕТОВАЯ СХЕМА ДЛЯ ТЕМНОЙ ТЕМЫ
  ///
  /// ## КЛЮЧЕВЫЕ ПРИНЦИПЫ:
  /// - Primary Colors: Светлые варианты для лучшей видимости в темноте
  /// - Surface Colors: Темные фоны для уменьшения нагрузки на глаза
  /// - Semantic Colors: Сохранение семантики с адаптацией для темного режима
  /// - Text Colors: Белый и светло-серый для оптимальной читабельности
  static ColorScheme get _colorScheme => const ColorScheme.dark(
    // ================================
    // 🔵 PRIMARY COLORS - ОСНОВНЫЕ ЦВЕТА
    // ================================
    primary: AppColors.primaryLight,
    onPrimary: AppColors.onPrimary,
    primaryContainer: Color(0xFF1A3A7A),

    // ================================
    // 🟣 SECONDARY COLORS - ВТОРОСТЕПЕННЫЕ ЦВЕТА
    // ================================
    secondary: AppColors.secondaryLight,
    onSecondary: AppColors.onSecondary,
    secondaryContainer: Color(0xFF2A1A5C),

    // ================================
    // 🖼️ SURFACE COLORS - ЦВЕТА ПОВЕРХНОСТЕЙ
    // ================================
    surface: Color(0xFF121212),
    onSurface: Colors.white,
    surfaceContainerHighest: Color(0xFF1E1E1E),

    // ================================
    // 📱 BACKGROUND COLORS - ЦВЕТА ФОНОВ
    // ================================
    background: Color(0xFF121212),
    onBackground: Colors.white,

    // ================================
    // ❌ ERROR COLORS - ЦВЕТА ОШИБОК
    // ================================
    error: AppColors.errorLight,
    onError: AppColors.onError,
    errorContainer: Color(0xFF8C1D18),

    // ================================
    // 📐 OUTLINE COLORS - ЦВЕТА ГРАНИЦ
    // ================================
    outline: AppColors.neutral600,
    outlineVariant: AppColors.neutral700,
  );

  // ================================
  // 🔤 TEXT THEME - ТЕКСТОВАЯ ТЕМА
  // ================================

  /// 🎯 ТЕКСТОВАЯ ТЕМА ДЛЯ ТЕМНОЙ ТЕМЫ
  ///
  /// ## ОСОБЕННОСТИ:
  /// - Light Text Colors: Белый и светло-серый для контраста на темном фоне
  /// - Consistent Hierarchy: Сохранение иерархии текстовых стилей
  /// - Readability: Оптимизирована для чтения в условиях низкой освещенности
  static TextTheme get _textTheme => TextTheme(
    // ================================
    // 🎪 DISPLAY STYLES - КРУПНЫЕ ЗАГОЛОВКИ
    // ================================
    displayLarge: AppTextStyles.displayLarge.copyWith(color: Colors.white),
    displayMedium: AppTextStyles.displayMedium.copyWith(color: Colors.white),
    displaySmall: AppTextStyles.displaySmall.copyWith(color: Colors.white),

    // ================================
    // 📰 HEADLINE STYLES - ОСНОВНЫЕ ЗАГОЛОВКИ
    // ================================
    headlineLarge: AppTextStyles.headlineLarge.copyWith(color: Colors.white),
    headlineMedium: AppTextStyles.headlineMedium.copyWith(color: Colors.white),
    headlineSmall: AppTextStyles.headlineSmall.copyWith(color: Colors.white),

    // ================================
    // 📝 TITLE STYLES - ЗАГОЛОВКИ РАЗДЕЛОВ
    // ================================
    titleLarge: AppTextStyles.titleLarge.copyWith(color: Colors.white),
    titleMedium: AppTextStyles.titleMedium.copyWith(color: Colors.white),
    titleSmall: AppTextStyles.titleSmall.copyWith(color: Colors.white),

    // ================================
    // 📄 BODY STYLES - ОСНОВНОЙ ТЕКСТ
    // ================================
    bodyLarge: AppTextStyles.bodyLarge.copyWith(color: Colors.white70),
    bodyMedium: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
    bodySmall: AppTextStyles.bodySmall.copyWith(color: Colors.white60),

    // ================================
    // 🏷️ LABEL STYLES - МЕТКИ И КНОПКИ
    // ================================
    labelLarge: AppTextStyles.labelLarge.copyWith(color: Colors.white),
    labelMedium: AppTextStyles.labelMedium.copyWith(color: Colors.white),
    labelSmall: AppTextStyles.labelSmall.copyWith(color: Colors.white60),
  );

  // ================================
  // 🎯 COMPONENT THEMES - ТЕМЫ КОМПОНЕНТОВ
  // ================================

  /// 🎯 APP BAR THEME - ТЕМА ДЛЯ APPBAR
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Background: Темно-серый фон для гармонии с общей темой
  /// - Text: Белый текст для максимальной читабельности
  /// - Elevation: Нулевая тень для плоского дизайна
  static AppBarTheme get _appBarTheme => const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
  );

  /// 🎯 BOTTOM NAVIGATION THEME - ТЕМА ДЛЯ НИЖНЕЙ НАВИГАЦИИ
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Background: Темно-серый фон для интеграции с темной темой
  /// - Selected Item: Светло-синий для визуального выделения активного элемента
  /// - Unselected Items: Средне-серый для неактивных элементов
  static BottomNavigationBarThemeData get _bottomNavigationBarTheme =>
      const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.neutral500,
      );

  /// 🎯 ELEVATED BUTTON THEME - ТЕМА ДЛЯ ELEVATED КНОПОК
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Background: Светло-синий для визуального акцента в темноте
  /// - Text: Белый текст для контрастности
  /// - Shape: Закругленные углы для consistency со светлой темой
  static ElevatedButtonThemeData get _elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: Gap.xl,
            vertical: Gap.lg,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );

  /// 🎯 OUTLINED BUTTON THEME - ТЕМА ДЛЯ OUTLINED КНОПОК
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Border: Светло-синяя граница для видимости в темноте
  /// - Text: Светло-синий текст для визуальной связи с брендом
  /// - Background: Прозрачный фон для интеграции с темным окружением
  static OutlinedButtonThemeData get _outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          side: const BorderSide(color: AppColors.primaryLight),
          padding: const EdgeInsets.symmetric(
            horizontal: Gap.xl,
            vertical: Gap.lg,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );

  /// 🎯 TEXT BUTTON THEME - ТЕМА ДЛЯ TEXT КНОПОК
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Text: Светло-синий для видимости и brand consistency
  /// - Background: Прозрачный фон для минималистичного вида
  /// - Padding: Компактные отступы для экономии места
  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
      padding: const EdgeInsets.symmetric(horizontal: Gap.md, vertical: Gap.sm),
    ),
  );

  /// 🎯 INPUT DECORATION THEME - ТЕМА ДЛЯ ПОЛЕЙ ВВОДА
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Filled: Темно-серый фон для визуального отделения
  /// - Border: Без границ в обычном состоянии для чистоты
  /// - Focus Border: Светло-синий цвет при фокусе для ясности
  static InputDecorationTheme get _inputDecorationTheme =>
      const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF1E1E1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Gap.lg,
          vertical: Gap.md,
        ),
      );

  /// 🎯 CARD THEME - ТЕМА ДЛЯ КАРТОЧЕК
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Background: Темно-серый фон для отделения от основного фона
  /// - Elevation: Увеличенная тень для лучшего восприятия глубины
  /// - Shape: Закругленные углы для consistency со светлой темой
  static CardThemeData get _cardTheme => const CardThemeData(
    color: Color(0xFF1E1E1E),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  /// 🎯 DIALOG THEME - ТЕМА ДЛЯ ДИАЛОГОВЫХ ОКОН
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Background: Темно-серый фон для focus на контенте
  /// - Shape: Закругленные углы для мягкости
  /// - Text: Белый текст для читабельности
  static DialogThemeData get _dialogTheme => DialogThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  /// 🎯 SNACKBAR THEME - ТЕМА ДЛЯ SNACKBAR УВЕДОМЛЕНИЙ
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Behavior: Floating для современного вида
  /// - Shape: Закругленные углы для consistency
  /// - Background: Темный фон для интеграции с темной темой
  static SnackBarThemeData get _snackBarTheme => const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    backgroundColor: Color(0xFF1E1E1E),
    contentTextStyle: TextStyle(color: Colors.white),
  );
}
