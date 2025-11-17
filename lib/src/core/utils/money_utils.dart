// ================================
// 💰 MONEY UTILS
// ================================

import 'dart:math' show pow;

import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';

/// Утилиты для работы с денежными суммами и валютами
///
/// СОДЕРЖАНИЕ ФАЙЛА:
///
/// 🎯 КОНСТАНТЫ:
/// - defaultCurrency - основная валюта
/// - currencySymbols - символы валют
/// - currencyNames - названия валют
///
/// 💫 ФОРМАТИРОВАНИЕ:
/// - formatAmount() - базовое форматирование
/// - formatCompact() - компактное отображение
/// - amountInWords() - прописью
///
/// 🧮 ВЫЧИСЛЕНИЯ:
/// - add() - сложение сумм
/// - subtract() - вычитание
/// - multiply() - умножение
/// - divide() - деление
/// - round() - округление
///
/// 🔄 КОНВЕРТАЦИЯ:
/// - convertCurrency() - конвертация валют
/// - formatExchangeRate() - форматирование курса
///
/// ✅ ВАЛИДАЦИЯ:
/// - isValidAmount() - проверка суммы
/// - parseAmount() - парсинг из строки
/// - isInRange() - проверка диапазона
///
/// 🎯 УТИЛИТЫ:
/// - rublesToKopecks() - конвертация в копейки
/// - kopecksToRubles() - конвертация в рубли
/// - getIntegerPart() - целая часть
/// - getFractionalPart() - дробная часть

class MoneyUtils {
  // ================================
  // ⚙️ КОНСТАНТЫ И НАСТРОЙКИ
  // ================================

  static const String defaultCurrency = 'RUB';
  static const Map<String, String> currencySymbols = {
    'RUB': '₽',
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
    'JPY': '¥',
    'CNY': '¥',
    'KZT': '₸',
    'UAH': '₴',
  };
  static const Map<String, String> currencyNames = {
    'RUB': 'Российский рубль',
    'USD': 'Доллар США',
    'EUR': 'Евро',
    'GBP': 'Фунт стерлингов',
    'JPY': 'Японская иена',
    'CNY': 'Китайский юань',
    'KZT': 'Казахстанский тенге',
    'UAH': 'Украинская гривна',
  };

  // ================================
  // 💫 ФОРМАТИРОВАНИЕ СУММ
  // ================================

  static String formatAmount(
    double amount, {
    String currency = 'RUB',
    int decimals = 2,
    String? locale,
    bool showSymbol = true,
  }) {
    final format = NumberFormat.currency(
      locale: locale ?? 'ru_RU',
      symbol: showSymbol ? _getCurrencySymbol(currency) : '',
      decimalDigits: decimals,
    );
    return format.format(amount);
  }

  static String formatCompact(
    double amount, {
    String currency = 'RUB',
    String? locale,
  }) {
    if (amount.abs() >= 1000000000) {
      final billions = amount / 1000000000;
      return '${_formatDecimal(billions)} млрд ${_getCurrencySymbol(currency)}';
    } else if (amount.abs() >= 1000000) {
      final millions = amount / 1000000;
      return '${_formatDecimal(millions)} млн ${_getCurrencySymbol(currency)}';
    } else if (amount.abs() >= 1000) {
      final thousands = amount / 1000;
      return '${_formatDecimal(thousands)} тыс ${_getCurrencySymbol(currency)}';
    } else {
      return formatAmount(amount, currency: currency, decimals: 0);
    }
  }

  static String amountInWords(double amount, String currency) {
    final rubles = amount.floor();
    final kopecks = ((amount - rubles) * 100).round();

    final rublesText = _numberToWords(rubles);
    final kopecksText = _numberToWords(kopecks);

    final currencyText = _getCurrencyText(rubles, currency);
    final fractionalText = _getFractionalText(kopecks, currency);

    return '$rublesText $currencyText $kopecksText $fractionalText'.trim();
  }

  // ================================
  // 🧮 ТОЧНЫЕ ВЫЧИСЛЕНИЯ
  // ================================

  static double add(List<double> amounts) {
    Decimal result = Decimal.zero;
    for (final amount in amounts) {
      result += Decimal.parse(amount.toString());
    }
    return double.parse(result.toString());
  }

  static double subtract(double amount1, double amount2) {
    final decimal1 = Decimal.parse(amount1.toString());
    final decimal2 = Decimal.parse(amount2.toString());
    return double.parse((decimal1 - decimal2).toString());
  }

  static double multiply(double amount, double multiplier) {
    final decimalAmount = Decimal.parse(amount.toString());
    final decimalMultiplier = Decimal.parse(multiplier.toString());
    return double.parse((decimalAmount * decimalMultiplier).toString());
  }

  static double divide(double amount, double divisor) {
    if (divisor == 0) throw ArgumentError('Divisor cannot be zero');
    final decimalAmount = Decimal.parse(amount.toString());
    final decimalDivisor = Decimal.parse(divisor.toString());
    return double.parse((decimalAmount / decimalDivisor).toString());
  }

  static double round(
    double amount, {
    int decimals = 2,
    RoundingMode mode = RoundingMode.halfUp,
  }) {
    final factor = pow(10, decimals);
    final scaled = amount * factor;

    double result;
    switch (mode) {
      case RoundingMode.floor:
        result = scaled.floorToDouble();
        break;
      case RoundingMode.ceil:
        result = scaled.ceilToDouble();
        break;
      case RoundingMode.halfUp:
        result = scaled.roundToDouble();
        break;
      case RoundingMode.halfDown:
        final fractional = scaled - scaled.floor();
        if (fractional == 0.5) {
          result = scaled.floorToDouble();
        } else {
          result = scaled.roundToDouble();
        }
        break;
    }

    return result / factor;
  }
  // ================================
  // 🔄 КОНВЕРТАЦИЯ ВАЛЮТ
  // ================================

  static double convertCurrency({
    required double amount,
    required String fromCurrency,
    required String toCurrency,
    required double exchangeRate,
  }) {
    if (fromCurrency == toCurrency) return amount;
    return multiply(amount, exchangeRate);
  }

  static String formatExchangeRate(
    double rate,
    String fromCurrency,
    String toCurrency,
  ) {
    return '1 ${_getCurrencySymbol(fromCurrency)} = ${formatAmount(rate, currency: toCurrency, showSymbol: true)}';
  }

  // ================================
  // ✅ ВАЛИДАЦИЯ И ПРОВЕРКИ
  // ================================

  static bool isValidAmount(String amount) {
    try {
      final value = double.tryParse(amount.replaceAll(',', '.'));
      return value != null && value >= 0;
    } catch (e) {
      return false;
    }
  }

  static double? parseAmount(String amountString) {
    try {
      final cleanString = amountString
          .replaceAll(',', '.')
          .replaceAll(RegExp(r'[^\d.]'), '');
      return double.tryParse(cleanString);
    } catch (e) {
      return null;
    }
  }

  static bool isInRange(double amount, double min, double max) {
    return amount >= min && amount <= max;
  }

  static bool isPositive(double amount) {
    return amount > 0;
  }

  static bool isNegative(double amount) {
    return amount < 0;
  }

  static bool isZero(double amount) {
    return amount == 0;
  }

  // ================================
  // 🎯 УТИЛИТЫ ДЛЯ РАБОТЫ С КОПЕЙКАМИ
  // ================================

  static int rublesToKopecks(double rubles) {
    return (rubles * 100).round();
  }

  static double kopecksToRubles(int kopecks) {
    return kopecks / 100;
  }

  static int getIntegerPart(double amount) {
    return amount.floor();
  }

  static int getFractionalPart(double amount) {
    return ((amount - amount.floor()) * 100).round();
  }

  // ================================
  // 🔧 ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ
  // ================================

  static String _getCurrencySymbol(String currency) {
    return currencySymbols[currency] ?? currency;
  }

  static String _formatDecimal(double value) {
    final format = NumberFormat('#,##0.0', 'ru_RU');
    return format.format(value);
  }

  static String _getCurrencyText(int amount, String currency) {
    return _pluralizeCurrency(amount, currency);
  }

  static String _getFractionalText(int fractional, String currency) {
    final fractionalName = _getFractionalCurrencyName(currency);
    return _pluralize(
      fractional,
      fractionalName[0],
      fractionalName[1],
      fractionalName[2],
    );
  }

  static String _pluralizeCurrency(int number, String currency) {
    final n = number % 100;
    if (currency == 'RUB') {
      if (n >= 11 && n <= 19) return 'рублей';
      switch (n % 10) {
        case 1:
          return 'рубль';
        case 2:
        case 3:
        case 4:
          return 'рубля';
        default:
          return 'рублей';
      }
    }
    return currency.toLowerCase();
  }

  static List<String> _getFractionalCurrencyName(String currency) {
    switch (currency) {
      case 'RUB':
        return ['копейка', 'копейки', 'копеек'];
      case 'USD':
        return ['цент', 'цента', 'центов'];
      case 'EUR':
        return ['цент', 'цента', 'центов'];
      default:
        return ['ед.', 'ед.', 'ед.'];
    }
  }

  static String _pluralize(int number, String one, String two, String five) {
    final n = number.abs() % 100;
    if (n >= 11 && n <= 19) return five;
    switch (n % 10) {
      case 1:
        return one;
      case 2:
      case 3:
      case 4:
        return two;
      default:
        return five;
    }
  }

  static String _numberToWords(int number) {
    if (number == 0) return 'ноль';
    final units = [
      '',
      'один',
      'два',
      'три',
      'четыре',
      'пять',
      'шесть',
      'семь',
      'восемь',
      'девять',
    ];
    final teens = [
      'десять',
      'одиннадцать',
      'двенадцать',
      'тринадцать',
      'четырнадцать',
      'пятнадцать',
      'шестнадцать',
      'семнадцать',
      'восемнадцать',
      'девятнадцать',
    ];
    final tens = [
      '',
      '',
      'двадцать',
      'тридцать',
      'сорок',
      'пятьдесят',
      'шестьдесят',
      'семьдесят',
      'восемьдесят',
      'девяносто',
    ];
    final hundreds = [
      '',
      'сто',
      'двести',
      'триста',
      'четыреста',
      'пятьсот',
      'шестьсот',
      'семьсот',
      'восемьсот',
      'девятьсот',
    ];

    if (number < 10) return units[number];
    if (number < 20) return teens[number - 10];
    if (number < 100) {
      final result = '${tens[number ~/ 10]} ${units[number % 10]}'.trim();
      return result;
    }
    if (number < 1000) {
      final result =
          '${hundreds[number ~/ 100]} ${_numberToWords(number % 100)}'.trim();
      return result;
    }
    return number.toString();
  }
}

enum RoundingMode { floor, ceil, halfUp, halfDown }

extension MoneyExtensions on double {
  String toMoneyString({String currency = 'RUB', int decimals = 2}) {
    return MoneyUtils.formatAmount(
      this,
      currency: currency,
      decimals: decimals,
    );
  }

  int get toKopecks => MoneyUtils.rublesToKopecks(this);
  bool get isPositive => MoneyUtils.isPositive(this);
  bool get isNegative => MoneyUtils.isNegative(this);
  bool get isZero => MoneyUtils.isZero(this);
}

extension MoneyIntExtensions on int {
  double get toRubles => MoneyUtils.kopecksToRubles(this);
  String toMoneyString({String currency = 'RUB', int decimals = 0}) {
    return MoneyUtils.formatAmount(
      toDouble(),
      currency: currency,
      decimals: decimals,
    );
  }
}
