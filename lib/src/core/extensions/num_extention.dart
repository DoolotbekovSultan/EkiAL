import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:math';

/// Расширения для числовых типов (int, double)
///
/// ## 🔧 Доступные методы:
/// ### Форматирование:
/// - `toPriceString([currency])` → String
/// - `toPercentString()` → String
/// - `toFormattedString()` → String
///
/// ### Преобразование единиц:
/// - `pxToDp()` → double
/// - `dpToPx()` → double
/// - `toDegrees()` → double
/// - `toRadians()` → double
///
/// ### Математические операции:
/// - `clamp(min, max)` → num
/// - `lerp(end, t)` → double
/// - `isBetween(min, max)` → bool

extension NumExtensions on num {
  // ================================
  // 💰 ФОРМАТИРОВАНИЕ ЧИСЕЛ
  // ================================

  /// Форматирует число как цену с разделителями тысяч
  String toPriceString([String currency = '₽']) {
    final formatter = NumberFormat('#,##0', 'ru_RU');
    return '${formatter.format(this)} $currency';
  }

  /// Форматирует число как процент
  String toPercentString() {
    return '${(this * 100).toStringAsFixed(1)}%';
  }

  /// Форматирует число с разделителями тысяч
  String toFormattedString() {
    return NumberFormat('#,##0', 'ru_RU').format(this);
  }

  // ================================
  // 📏 ПРЕОБРАЗОВАНИЕ ЕДИНИЦ
  // ================================

  /// Конвертирует пиксели в dp (плотность-независимые пиксели)
  double pxToDp() =>
      this /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  /// Конвертирует dp в пиксели
  double dpToPx() =>
      this *
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  /// Конвертирует радианы в градусы
  double toDegrees() => this * (180 / pi);

  /// Конвертирует градусы в радианы
  double toRadians() => this * (pi / 180);

  // ================================
  // 🧮 МАТЕМАТИЧЕСКИЕ ОПЕРАЦИИ
  // ================================

  /// Ограничивает число диапазоном [min, max]
  num clamp(num min, num max) => this < min ? min : (this > max ? max : this);

  /// Линейная интерполяция между этим числом и [end]
  double lerp(num end, double t) => this + (end - this) * t;

  /// Проверяет находится ли число в диапазоне [min, max]
  bool isBetween(num min, num max) => this >= min && this <= max;
}
