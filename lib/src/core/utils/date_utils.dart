// ================================
// 📅 DATE UTILS
// ================================

import 'package:intl/intl.dart';

/// Утилиты для работы с датами и временем
///
/// Предоставляет методы для:
/// - Парсинга дат из различных форматов
/// - Форматирования дат для отображения
/// - Вычисления разницы между датами
/// - Работы с временными зонами
/// - Календарных операций
///
/// Все методы учитывают локаль и часовой пояс
class DateUtils {
  // ================================
  // ⏰ ФОРМАТЫ ДАТ
  // ================================

  /// Стандартные форматы дат для использования в приложении
  static const String apiFormat = 'yyyy-MM-dd';
  static const String apiDateTimeFormat = 'yyyy-MM-ddTHH:mm:ss';
  static const String displayDateFormat = 'dd.MM.yyyy';
  static const String displayTimeFormat = 'HH:mm';
  static const String displayDateTimeFormat = 'dd.MM.yyyy HH:mm';
  static const String relativeDateFormat = 'EEE, d MMM';

  // ================================
  // 🔄 ПАРСИНГ ДАТ
  // ================================

  /// Парсит дату из строки в формате API
  ///
  /// Пример использования:
  /// ```dart
  /// final date = DateUtils.parseApiDate('2024-01-15'); // DateTime(2024, 1, 15)
  /// final dateTime = DateUtils.parseApiDateTime('2024-01-15T14:30:00'); // DateTime(2024, 1, 15, 14, 30)
  /// ```
  static DateTime? parseApiDate(String dateString) {
    if (dateString.isEmpty) return null;
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Парсит дату и время из строки в формате API
  static DateTime? parseApiDateTime(String dateTimeString) {
    if (dateTimeString.isEmpty) return null;
    try {
      // Убираем часовой пояс если присутствует
      final cleanString = dateTimeString.replaceAll(RegExp(r'[Z+-].*$'), '');
      return DateTime.parse(cleanString);
    } catch (e) {
      return null;
    }
  }

  /// Парсит дату из timestamp (миллисекунды)
  static DateTime? parseTimestamp(int timestamp) {
    try {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    } catch (e) {
      return null;
    }
  }

  // ================================
  // 💫 ФОРМАТИРОВАНИЕ ДАТ
  // ================================

  /// Форматирует дату для отображения
  ///
  /// Пример использования:
  /// ```dart
  /// final date = DateTime(2024, 1, 15);
  /// final formatted = DateUtils.formatDisplayDate(date); // "15.01.2024"
  /// final withTime = DateUtils.formatDisplayDateTime(date); // "15.01.2024 00:00"
  /// ```
  static String formatDisplayDate(DateTime date, {String? locale}) {
    final format = DateFormat(displayDateFormat, locale);
    return format.format(date.toLocal());
  }

  /// Форматирует время для отображения
  static String formatDisplayTime(DateTime date, {String? locale}) {
    final format = DateFormat(displayTimeFormat, locale);
    return format.format(date.toLocal());
  }

  /// Форматирует дату и время для отображения
  static String formatDisplayDateTime(DateTime date, {String? locale}) {
    final format = DateFormat(displayDateTimeFormat, locale);
    return format.format(date.toLocal());
  }

  /// Форматирует дату для API
  static String formatApiDate(DateTime date) {
    final format = DateFormat(apiFormat);
    return format.format(date.toUtc());
  }

  /// Форматирует дату и время для API
  static String formatApiDateTime(DateTime date) {
    final format = DateFormat(apiDateTimeFormat);
    return format.format(date.toUtc());
  }

  // ================================
  // 📊 ОТНОСИТЕЛЬНЫЕ ДАТЫ
  // ================================

  /// Форматирует дату в относительном формате
  ///
  /// Пример использования:
  /// ```dart
  /// final now = DateTime.now();
  /// final today = DateUtils.formatRelativeDate(now); // "Сегодня"
  /// final yesterday = DateUtils.formatRelativeDate(now.subtract(Duration(days: 1))); // "Вчера"
  /// ```
  static String formatRelativeDate(DateTime date, {String? locale}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final input = DateTime(date.year, date.month, date.day);

    final difference = input.difference(today).inDays;

    switch (difference) {
      case 0:
        return 'Сегодня';
      case 1:
        return 'Завтра';
      case -1:
        return 'Вчера';
      default:
        if (difference.abs() <= 7) {
          final format = DateFormat('EEEE', locale);
          return format.format(date);
        } else {
          final format = DateFormat(relativeDateFormat, locale);
          return format.format(date);
        }
    }
  }

  /// Форматирует дату и время в относительном формате
  static String formatRelativeDateTime(DateTime date, {String? locale}) {
    final relativeDate = formatRelativeDate(date, locale: locale);
    final time = formatDisplayTime(date, locale: locale);
    return '$relativeDate в $time';
  }

  /// Возвращает человеко-читаемую разницу во времени
  ///
  /// Пример использования:
  /// ```dart
  /// final difference = DateUtils.timeAgo(DateTime.now().subtract(Duration(hours: 2))); // "2 часа назад"
  /// ```
  static String timeAgo(DateTime date, {String? locale}) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'только что';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return _pluralize(minutes, 'минуту', 'минуты', 'минут', 'назад');
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return _pluralize(hours, 'час', 'часа', 'часов', 'назад');
    } else if (difference.inDays < 30) {
      final days = difference.inDays;
      return _pluralize(days, 'день', 'дня', 'дней', 'назад');
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return _pluralize(months, 'месяц', 'месяца', 'месяцев', 'назад');
    } else {
      final years = (difference.inDays / 365).floor();
      return _pluralize(years, 'год', 'года', 'лет', 'назад');
    }
  }

  // ================================
  // 📐 ВЫЧИСЛЕНИЯ С ДАТАМИ
  // ================================

  /// Проверяет является ли дата сегодняшним днем
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Проверяет является ли дата вчерашним днем
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Проверяет является ли дата завтрашним днем
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Проверяет является ли год високосным
  static bool isLeapYear(int year) {
    return (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
  }

  /// Возвращает возраст по дате рождения
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    var age = now.year - birthDate.year;
    final monthDifference = now.month - birthDate.month;

    if (monthDifference < 0 ||
        (monthDifference == 0 && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  /// Возвращает разницу между датами в днях
  static int differenceInDays(DateTime from, DateTime to) {
    final fromDate = DateTime(from.year, from.month, from.day);
    final toDate = DateTime(to.year, to.month, to.day);
    return toDate.difference(fromDate).inDays;
  }

  /// Возвращает начало дня (00:00:00)
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Возвращает конец дня (23:59:59.999)
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Возвращает начало недели (понедельник)
  static DateTime startOfWeek(DateTime date) {
    final weekDay = date.weekday;
    return date.subtract(Duration(days: weekDay - 1));
  }

  /// Возвращает начало месяца
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Возвращает конец месяца
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  // ================================
  // 🎯 ВАЛИДАЦИЯ ДАТ
  // ================================

  /// Проверяет что дата находится в будущем
  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  /// Проверяет что дата находится в прошлом
  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Проверяет что дата находится в указанном диапазоне
  static bool isInRange(DateTime date, DateTime start, DateTime end) {
    return (date.isAfter(start) || date.isAtSameMomentAs(start)) &&
        (date.isBefore(end) || date.isAtSameMomentAs(end));
  }

  // ================================
  // 🔧 ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ
  // ================================

  /// Склонение слов в зависимости от числа
  static String _pluralize(
    int number,
    String one,
    String two,
    String five,
    String suffix,
  ) {
    final n = number.abs();
    String result;

    if (n % 10 == 1 && n % 100 != 11) {
      result = one;
    } else if (n % 10 >= 2 && n % 10 <= 4 && (n % 100 < 10 || n % 100 >= 20)) {
      result = two;
    } else {
      result = five;
    }

    return '$number $result $suffix';
  }

  /// Возвращает список месяцев на русском
  static List<String> get russianMonths => [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь',
  ];

  /// Возвращает список дней недели на русском
  static List<String> get russianWeekdays => [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье',
  ];
}
