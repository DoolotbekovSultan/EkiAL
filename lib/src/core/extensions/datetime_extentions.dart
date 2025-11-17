/// Расширения для класса DateTime
///
/// ## 🔧 Доступные методы:
/// ### Форматирование:
/// - `toFormattedDate` → String
/// - `toFormattedDateTime` → String
/// - `toRelativeTime` → String
///
/// ### Проверки дат:
/// - `isToday` → bool
/// - `isYesterday` → bool
/// - `isTomorrow` → bool
/// - `isPast` → bool
/// - `isFuture` → bool
///
/// ### Временные диапазоны:
/// - `startOfDay` → DateTime
/// - `endOfDay` → DateTime

// ignore_for_file: unnecessary_brace_in_string_interps, curly_braces_in_flow_control_structures, dangling_library_doc_comments

extension DateTimeExtensions on DateTime {
  // ================================
  // 🎨 ФОРМАТИРОВАНИЕ ДАТ
  // ================================

  /// Форматирует дату в строку 'dd.MM.yyyy'
  String get toFormattedDate =>
      '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.$year';

  /// Форматирует дату и время в строку 'dd.MM.yyyy HH:mm'
  String get toFormattedDateTime =>
      '${toFormattedDate} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  /// Возвращает относительное время (например, '2 часа назад')
  String get toRelativeTime {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${_pluralize(years, 'год', 'года', 'лет')} назад';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${_pluralize(months, 'месяц', 'месяца', 'месяцев')} назад';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${_pluralize(difference.inDays, 'день', 'дня', 'дней')} назад';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${_pluralize(difference.inHours, 'час', 'часа', 'часов')} назад';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${_pluralize(difference.inMinutes, 'минуту', 'минуты', 'минут')} назад';
    } else {
      return 'только что';
    }
  }

  // Вспомогательный метод для склонения слов
  String _pluralize(int number, String one, String two, String five) {
    final n = number.abs();
    if (n % 10 == 1 && n % 100 != 11) return one;
    if (n % 10 >= 2 && n % 10 <= 4 && (n % 100 < 10 || n % 100 >= 20))
      return two;
    return five;
  }

  // ================================
  // 📊 ПРОВЕРКИ ДАТ
  // ================================

  /// Проверяет является ли дата сегодняшним днем
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Проверяет является ли дата вчерашним днем
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Проверяет является ли дата завтрашним днем
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Проверяет находится ли дата в прошлом
  bool get isPast => isBefore(DateTime.now());

  /// Проверяет находится ли дата в будущем
  bool get isFuture => isAfter(DateTime.now());

  // ================================
  // ⏰ ВРЕМЕННЫЕ ДИАПАЗОНЫ
  // ================================

  /// Возвращает начало дня (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// Возвращает конец дня (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);
}
