/// 🧩 КОНСТАНТЫ ДЛЯ UI КОМПОНЕНТОВ
///
/// Содержит размеры, отступы, анимации и другие визуальные константы
abstract class WidgetConstants {
  // ================================
  // 📏 РАЗМЕРЫ ЭЛЕМЕНТОВ UI
  // ================================

  /// Высота AppBar
  static const double appBarHeight = 56.0;

  /// Высота BottomNavigationBar
  static const double bottomNavBarHeight = 64.0;

  /// Стандартная высота кнопки
  static const double buttonHeight = 48.0;

  /// Размер иконки по умолчанию
  static const double iconSize = 24.0;

  /// Размер маленькой иконки
  static const double smallIconSize = 16.0;

  /// Размер большой иконки
  static const double largeIconSize = 32.0;

  // ================================
  // 📐 ОТСТУПЫ И ПРОБЕЛЫ
  // ================================

  /// Стандартный отступ
  static const double defaultPadding = 16.0;

  /// Маленький отступ
  static const double smallPadding = 8.0;

  /// Большой отступ
  static const double largePadding = 24.0;

  /// Очень большой отступ
  static const double extraLargePadding = 32.0;

  // ================================
  // 🎨 РАДИУСЫ СКРУГЛЕНИЯ
  // ================================

  /// Маленький радиус скругления
  static const double borderRadiusSmall = 4.0;

  /// Средний радиус скругления
  static const double borderRadiusMedium = 8.0;

  /// Большой радиус скругления
  static const double borderRadiusLarge = 16.0;

  /// Очень большой радиус скругления
  static const double borderRadiusExtraLarge = 24.0;

  // ================================
  // ⏱️ ДЛИТЕЛЬНОСТИ АНИМАЦИЙ
  // ================================

  /// Короткая анимация
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);

  /// Средняя анимация
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);

  /// Длинная анимация
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // ================================
  // 🎭 ТЕНИ И ВИЗУАЛЬНЫЕ ЭФФЕКТЫ
  // ================================

  /// Радиус размытия тени
  static const double shadowBlurRadius = 4.0;

  /// Радиус распространения тени
  static const double shadowSpreadRadius = 0.0;

  /// Смещение тени
  static const double shadowOffset = 2.0;

  // ================================
  // 📝 РАЗМЕРЫ ЭЛЕМЕНТОВ ФОРМ
  // ================================

  /// Высота текстового поля
  static const double textFieldHeight = 56.0;

  /// Размер чекбокса
  static const double checkboxSize = 24.0;

  /// Размер радио-кнопки
  static const double radioSize = 24.0;

  /// Ширина переключателя
  static const double switchWidth = 48.0;

  /// Высота переключателя
  static const double switchHeight = 32.0;
}
