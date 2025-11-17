// ================================
// ☀️ LIGHT THEME - СВЕТЛАЯ ТЕМА ПРИЛОЖЕНИЯ
// ================================

import 'package:eki_al/src/core/theme/qap.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

/// 🎯 КОНФИГУРАЦИЯ СВЕТЛОЙ ТЕМЫ ПРИЛОЖЕНИЯ
///
/// Реализует полную светлую тему на основе Material Design 3.
///
/// ## 🎯 ОСОБЕННОСТИ СВЕТЛОЙ ТЕМЫ:
/// - ✅ Яркие и чистые цвета
/// - ✅ Высокая контрастность для лучшей читабельности
/// - ✅ Оптимизирована для дневного использования
/// - ✅ Соответствует WCAG AA accessibility standards
/// - ✅ Полная поддержка Material Design 3 компонентов
///
/// ## 🎨 ЦВЕТОВАЯ СТРАТЕГИЯ:
/// - Primary: Синий (#0066FF) - для основных действий
/// - Surface: Белый (#FFFFFF) - для фонов и карточек
/// - Background: Светло-серый (#FAFBFD) - для основного фона
/// - Text: Темно-серый (#1A1A1A) - для оптимальной читабельности
class LightTheme {
  LightTheme._();

  // ================================
  // 🌟 ОСНОВНАЯ КОНФИГУРАЦИЯ ТЕМЫ
  // ================================

  /// 🌟 ГЛАВНАЯ СВЕТЛАЯ ТЕМА ПРИЛОЖЕНИЯ
  ///
  /// ## КЛЮЧЕВЫЕ ХАРАКТЕРИСТИКИ:
  /// - Material Design 3: Полная поддержка latest Material Design
  /// - Accessibility: Оптимизирована для доступности
  /// - Consistency: Единообразие across all components
  /// - Performance: Оптимизирована для производительности
  static ThemeData get themeData {
    return ThemeData(
      // ================================
      // 🎨 БАЗОВАЯ КОНФИГУРАЦИЯ
      // ================================
      colorScheme: _colorScheme,
      useMaterial3: true,
      brightness: Brightness.light,

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

  /// 🎯 ЦВЕТОВАЯ СХЕМА ДЛЯ СВЕТЛОЙ ТЕМЫ
  ///
  /// ## КЛЮЧЕВЫЕ ПРИНЦИПЫ:
  /// - Primary Colors: Для brand identity и основных действий
  /// - Surface Colors: Для фонов, карточек и контейнеров
  /// - Semantic Colors: Для состояний (success, error, warning)
  /// - Neutral Colors: Для текста, границ и разделителей
  static ColorScheme get _colorScheme => const ColorScheme.light(
    // ================================
    // 🔵 PRIMARY COLORS - ОСНОВНЫЕ ЦВЕТА
    // ================================
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryContainer,

    // ================================
    // 🟣 SECONDARY COLORS - ВТОРОСТЕПЕННЫЕ ЦВЕТА
    // ================================
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    secondaryContainer: AppColors.secondaryContainer,

    // ================================
    // 🖼️ SURFACE COLORS - ЦВЕТА ПОВЕРХНОСТЕЙ
    // ================================
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    surfaceContainerHighest: AppColors.surfaceVariant,

    // ================================
    // 📱 BACKGROUND COLORS - ЦВЕТА ФОНОВ
    // ================================
    background: AppColors.background,
    onBackground: AppColors.onBackground,

    // ================================
    // ❌ ERROR COLORS - ЦВЕТА ОШИБОК
    // ================================
    error: AppColors.error,
    onError: AppColors.onError,
    errorContainer: AppColors.errorContainer,

    // ================================
    // 📐 OUTLINE COLORS - ЦВЕТА ГРАНИЦ
    // ================================
    outline: AppColors.neutral400,
    outlineVariant: AppColors.neutral300,
  );

  // ================================
  // 🔤 TEXT THEME - ТЕКСТОВАЯ ТЕМА
  // ================================

  /// 🎯 ТЕКСТОВАЯ ТЕМА ДЛЯ СВЕТЛОЙ ТЕМЫ
  ///
  /// ## ОСОБЕННОСТИ:
  /// - Optimized Contrast: Высокая контрастность для readability
  /// - Consistent Hierarchy: Единая иерархия текстовых стилей
  /// - Accessibility: Соответствует стандартам доступности
  static TextTheme get _textTheme => TextTheme(
    // ================================
    // 🎪 DISPLAY STYLES - КРУПНЫЕ ЗАГОЛОВКИ
    // ================================
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,

    // ================================
    // 📰 HEADLINE STYLES - ОСНОВНЫЕ ЗАГОЛОВКИ
    // ================================
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall,

    // ================================
    // 📝 TITLE STYLES - ЗАГОЛОВКИ РАЗДЕЛОВ
    // ================================
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    titleSmall: AppTextStyles.titleSmall,

    // ================================
    // 📄 BODY STYLES - ОСНОВНОЙ ТЕКСТ
    // ================================
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,

    // ================================
    // 🏷️ LABEL STYLES - МЕТКИ И КНОПКИ
    // ================================
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
    labelSmall: AppTextStyles.labelSmall,
  );

  // ================================
  // 🎯 COMPONENT THEMES - ТЕМЫ КОМПОНЕНТОВ
  // ================================

  /// 🎯 APP BAR THEME - ТЕМА ДЛЯ APPBAR
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Background: Белый фон для четкого отделения
  /// - Elevation: Нулевая тень для плоского дизайна
  /// - Typography: Крупный заголовок для ясности
  static AppBarTheme get _appBarTheme => const AppBarTheme(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.onSurface,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: AppTextStyles.titleLarge,
  );

  /// 🎯 BOTTOM NAVIGATION THEME - ТЕМА ДЛЯ НИЖНЕЙ НАВИГАЦИИ
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Selected Item: Primary цвет для активного элемента
  /// - Unselected Items: Neutral цвет для неактивных элементов
  /// - Background: Белый фон для четкого отделения
  static BottomNavigationBarThemeData get _bottomNavigationBarTheme =>
      const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.neutral600,
        elevation: 2,
      );

  /// 🎯 ELEVATED BUTTON THEME - ТЕМА ДЛЯ ELEVATED КНОПОК
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Background: Primary цвет для визуального акцента
  /// - Text: Белый текст для контрастности
  /// - Shape: Закругленные углы (8px) для современного вида
  /// - Padding: Комфортные отступы для usability
  static ElevatedButtonThemeData get _elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          textStyle: AppTextStyles.buttonMedium,
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
  /// - Border: Primary цвет границы для видимости
  /// - Text: Primary цвет текста для consistency
  /// - Background: Прозрачный фон для subtle appearance
  static OutlinedButtonThemeData get _outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.buttonMedium,
          padding: const EdgeInsets.symmetric(
            horizontal: Gap.xl,
            vertical: Gap.lg,
          ),
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );

  /// 🎯 TEXT BUTTON THEME - ТЕМА ДЛЯ TEXT КНОПОК
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Text: Primary цвет для видимости
  /// - Background: Прозрачный фон для минималистичного вида
  /// - Padding: Компактные отступы для экономии места
  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      textStyle: AppTextStyles.buttonMedium,
      padding: const EdgeInsets.symmetric(horizontal: Gap.md, vertical: Gap.sm),
    ),
  );

  /// 🎯 INPUT DECORATION THEME - ТЕМА ДЛЯ ПОЛЕЙ ВВОДА
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Filled: Заливка фоном для визуального отделения
  /// - Border: Без границ в обычном состоянии для чистоты
  /// - Focus Border: Primary цвет при фокусе для ясности
  /// - Error Border: Error цвет при ошибках для очевидности
  static InputDecorationTheme get _inputDecorationTheme =>
      const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariant,
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
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.error),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Gap.lg,
          vertical: Gap.md,
        ),
      );

  /// 🎯 CARD THEME - ТЕМА ДЛЯ КАРТОЧЕК
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Background: Белый фон для четкого отделения
  /// - Elevation: Легкая тень для глубины
  /// - Shape: Закругленные углы (12px) для современности
  static CardThemeData get _cardTheme => const CardThemeData(
    color: AppColors.surface,
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    margin: EdgeInsets.zero,
  );

  /// 🎯 DIALOG THEME - ТЕМА ДЛЯ ДИАЛОГОВЫХ ОКОН
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Background: Белый фон для focus на контенте
  /// - Shape: Закругленные углы (16px) для мягкости
  /// - Typography: Четкая иерархия текста
  static DialogThemeData get _dialogTheme => DialogThemeData(
    backgroundColor: AppColors.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    titleTextStyle: AppTextStyles.headlineSmall,
    contentTextStyle: AppTextStyles.bodyMedium,
  );

  /// 🎯 SNACKBAR THEME - ТЕМА ДЛЯ SNACKBAR УВЕДОМЛЕНИЙ
  ///
  /// ## КОНФИГУРАЦИЯ:
  /// - Behavior: Floating для современного вида
  /// - Shape: Закругленные углы для consistency
  static SnackBarThemeData get _snackBarTheme => const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
}
