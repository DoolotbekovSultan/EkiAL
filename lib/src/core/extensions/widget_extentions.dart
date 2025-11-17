import 'package:flutter/material.dart';

/// Расширения для Widget
///
/// ## 🔧 Доступные методы:
/// ### Отступы и выравнивание:
/// - `withPadding(all)` → Widget
/// - `withPaddingSymmetric(horizontal, vertical)` → Widget
/// - `withPaddingOnly(left, top, right, bottom)` → Widget
/// - `withMargin(all)` → Widget
/// - `withCenterAlignment()` → Widget
///
/// ### Стилизация:
/// - `withBackground(color)` → Widget
/// - `withBorderRadius(radius)` → Widget
/// - `withBorder(color, width)` → Widget
/// - `withShadow([color, elevation])` → Widget
/// - `withSize(width, height)` → Widget
/// - `withExpanded()` → Widget
///
/// ### Жесты и взаимодействия:
/// - `withOnTap(onTap)` → Widget
/// - `withOnLongPress(onLongPress)` → Widget
/// - `withTooltip(message)` → Widget

extension WidgetExtensions on Widget {
  // ================================
  // 📐 ОТСТУПЫ И ВЫРАВНИВАНИЕ
  // ================================

  /// Добавляет отступы со всех сторон
  Widget withPadding(double all) =>
      Padding(padding: EdgeInsets.all(all), child: this);

  /// Добавляет симметричные отступы
  Widget withPaddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  /// Добавляет отступы только с указанных сторон
  Widget withPaddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );

  /// Добавляет внешние отступы (margin)
  Widget withMargin(double all) =>
      Container(margin: EdgeInsets.all(all), child: this);

  /// Центрирует виджет
  Widget withCenterAlignment() => Center(child: this);

  // ================================
  // 🎨 СТИЛИЗАЦИЯ
  // ================================

  /// Добавляет фоновый цвет
  Widget withBackground(Color color) => Container(color: color, child: this);

  /// Добавляет скругление углов
  Widget withBorderRadius(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);

  /// Добавляет границу
  Widget withBorder(Color color, double width) => Container(
    decoration: BoxDecoration(
      border: Border.all(color: color, width: width),
    ),
    child: this,
  );

  /// Добавляет тень
  Widget withShadow([Color? color, double elevation = 4]) => Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: color ?? Colors.black.withValues(alpha: 0.1),
          blurRadius: elevation * 2,
          offset: Offset(0, elevation),
        ),
      ],
    ),
    child: this,
  );

  /// Устанавливает фиксированный размер
  Widget withSize(double width, double height) =>
      SizedBox(width: width, height: height, child: this);

  /// Занимает все доступное пространство
  Widget withExpanded([int flex = 1]) => Expanded(flex: flex, child: this);

  // ================================
  // 👆 ЖЕСТЫ И ВЗАИМОДЕЙСТВИЯ
  // ================================

  /// Добавляет обработчик нажатия
  Widget withOnTap(VoidCallback onTap) =>
      GestureDetector(onTap: onTap, child: this);

  /// Добавляет обработчик долгого нажатия
  Widget withOnLongPress(VoidCallback onLongPress) =>
      GestureDetector(onLongPress: onLongPress, child: this);

  /// Добавляет всплывающую подсказку
  Widget withTooltip(String message) => Tooltip(message: message, child: this);
}
