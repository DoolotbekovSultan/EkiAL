// ================================
// 📝 FORMATTERS
// ================================

import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Утилиты для форматирования различных типов данных
///
/// Предоставляет методы для:
/// - Форматирования чисел и валют
/// - Преобразования регистров текста
/// - Обрезки и обработки строк
/// - Маски для ввода данных
///
/// Все методы оптимизированы для использования в UI
class Formatters {
  // ================================
  // 🔢 ФОРМАТИРОВАНИЕ ЧИСЕЛ
  // ================================

  /// Форматирует число с разделителями тысяч
  ///
  /// Пример использования:
  /// ```dart
  /// final formatted = Formatters.formatNumber(1234567.89); // "1 234 567.89"
  /// final noDecimals = Formatters.formatNumber(1234567, decimals: 0); // "1 234 567"
  /// ```
  static String formatNumber(
    double number, {
    int decimals = 2,
    String? locale,
  }) {
    final format = NumberFormat.decimalPattern(locale);
    format.minimumFractionDigits = decimals;
    format.maximumFractionDigits = decimals;
    return format.format(number);
  }

  /// Форматирует число как проценты
  ///
  /// Пример использования:
  /// ```dart
  /// final percent = Formatters.formatPercent(0.1567); // "15.67%"
  /// final noDecimals = Formatters.formatPercent(0.15, decimals: 0); // "15%"
  /// ```
  static String formatPercent(
    double value, {
    int decimals = 2,
    String? locale,
  }) {
    final format = NumberFormat.percentPattern(locale);
    format.minimumFractionDigits = decimals;
    format.maximumFractionDigits = decimals;
    return format.format(value);
  }

  // ================================
  // 💰 ФОРМАТИРОВАНИЕ ВАЛЮТ
  // ================================

  /// Форматирует число как денежную сумму
  ///
  /// Пример использования:
  /// ```dart
  /// final rubles = Formatters.formatCurrency(1500.50, 'RUB'); // "1 500,50 ₽"
  /// final dollars = Formatters.formatCurrency(1500.50, 'USD'); // "$1,500.50"
  /// ```
  static String formatCurrency(
    double amount,
    String currencyCode, {
    String? locale,
    int? decimalDigits,
  }) {
    final format = NumberFormat.currency(
      locale: locale,
      symbol: _getCurrencySymbol(currencyCode),
      decimalDigits: decimalDigits,
    );
    return format.format(amount);
  }

  /// Возвращает символ валюты по коду
  static String _getCurrencySymbol(String currencyCode) {
    final symbols = {
      'RUB': '₽',
      'USD': '\$',
      'EUR': '€',
      'GBP': '£',
      'JPY': '¥',
      'CNY': '¥',
    };
    return symbols[currencyCode] ?? currencyCode;
  }

  // ================================
  // 📄 ОБРАБОТКА ТЕКСТА
  // ================================

  /// Преобразует первую букву строки в заглавную
  ///
  /// Пример использования:
  /// ```dart
  /// final result = Formatters.capitalize('hello world'); // "Hello world"
  /// final multiple = Formatters.capitalize('hello world', allWords: true); // "Hello World"
  /// ```
  static String capitalize(String text, {bool allWords = false}) {
    if (text.isEmpty) return text;

    if (allWords) {
      return text.split(' ').map((word) => capitalize(word)).join(' ');
    }

    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// Обрезает строку и добавляет многоточие если превышена длина
  ///
  /// Пример использования:
  /// ```dart
  /// final result = Formatters.ellipsize('Very long text here', 10); // "Very long..."
  /// ```
  static String ellipsize(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Удаляет лишние пробелы и обрезает строку
  ///
  /// Пример использования:
  /// ```dart
  /// final result = Formatters.trimAndRemoveExtraSpaces('  hello   world  '); // "hello world"
  /// ```
  static String trimAndRemoveExtraSpaces(String text) {
    return text.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  /// Форматирует имя файла - обрезает расширение и длинное имя
  static String formatFileName(String fileName, {int maxLength = 30}) {
    final withoutExtension = fileName.replaceAll(RegExp(r'\.[^\.]+$'), '');
    return ellipsize(withoutExtension, maxLength);
  }

  // ================================
  // 📱 МАСКИ ДЛЯ ВВОДА
  // ================================

  /// Создает маску для номера телефона
  ///
  /// Пример использования:
  /// ```dart
  /// final mask = Formatters.phoneMask; // +7 (XXX) XXX-XX-XX
  /// ```
  static String get phoneMask => '+7 (XXX) XXX-XX-XX';

  /// Создает маску для банковской карты (группы по 4 цифры)
  ///
  /// Пример использования:
  /// ```dart
  /// final mask = Formatters.cardNumberMask; // XXXX XXXX XXXX XXXX
  /// ```
  static String get cardNumberMask => 'XXXX XXXX XXXX XXXX';

  /// Создает TextInputFormatter для маски телефона
  static TextInputFormatter get phoneInputFormatter =>
      FilteringTextInputFormatter.deny(RegExp(r'[^\d+]'));

  /// Создает TextInputFormatter для ввода только букв
  static TextInputFormatter get lettersOnlyFormatter =>
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я]'));

  /// Создает TextInputFormatter для ввода только цифр
  static TextInputFormatter get digitsOnlyFormatter =>
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  // ================================
  // 🎨 ФОРМАТИРОВАНИЕ РАЗМЕРОВ
  // ================================

  /// Форматирует размер файла в читаемом виде
  ///
  /// Пример использования:
  /// ```dart
  /// final size = Formatters.formatFileSize(1024); // "1 KB"
  /// final large = Formatters.formatFileSize(1500000); // "1.5 MB"
  /// ```
  static String formatFileSize(int bytes, {int decimals = 1}) {
    if (bytes <= 0) return '0 B';

    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    final i = (log(bytes) / log(1024)).floor();

    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  /// Форматирует продолжительность в читаемом виде
  ///
  /// Пример использования:
  /// ```dart
  /// final duration = Formatters.formatDuration(Duration(minutes: 90)); // "1h 30m"
  /// ```
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }
}

// Вспомогательная функция для вычисления степени
num pow(num x, num exponent) {
  return x.pow(exponent.toInt());
}

extension NumPow on num {
  num pow(int exponent) {
    var result = 1.0;
    for (var i = 0; i < exponent; i++) {
      result *= this;
    }
    return result;
  }
}
