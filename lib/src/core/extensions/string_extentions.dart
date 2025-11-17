/// Расширения для класса String
///
/// ## 🔧 Доступные методы:
/// ### Валидация:
/// - `isValidEmail` → bool
/// - `isValidPhone` → bool
/// - `isValidUrl` → bool
/// - `isBlank` → bool
/// - `isNumeric` → bool
///
/// ### Форматирование:
/// - `capitalize` → String
/// - `capitalizeWords` → String
/// - `truncate(maxLength)` → String
/// - `removeAllWhitespace` → String
///
/// ### Работа с путями:
/// - `fileExtension` → String
/// - `fileName` → String
/// - `isImagePath` → bool

// ignore_for_file: dangling_library_doc_comments

extension StringExtensions on String {
  // ================================
  // ✅ ВАЛИДАЦИЯ И ПРОВЕРКИ
  // ================================

  /// Проверяет является ли строка валидным email адресом
  bool get isValidEmail => RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(this);

  /// Проверяет является ли строка валидным номером телефона
  bool get isValidPhone => RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(this);

  /// Проверяет является ли строка валидным URL адресом
  bool get isValidUrl =>
      RegExp(r'^(https?://)?([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$').hasMatch(this);

  /// Проверяет является ли строка пустой или состоящей только из пробелов
  bool get isBlank => trim().isEmpty;

  /// Проверяет содержит ли строка только цифры
  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);

  // ================================
  // 🎨 ФОРМАТИРОВАНИЕ ТЕКСТА
  // ================================

  /// Преобразует первую букву строки в верхний регистр
  String get capitalize =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  /// Преобразует первую букву каждого слова в верхний регистр
  String get capitalizeWords =>
      split(' ').map((word) => word.capitalize).join(' ');

  /// Обрезает строку до указанной длины и добавляет многоточие
  String truncate(int maxLength) =>
      length <= maxLength ? this : '${substring(0, maxLength - 3)}...';

  /// Удаляет все пробелы из строки
  String get removeAllWhitespace => replaceAll(RegExp(r'\s+'), '');

  // ================================
  // 🔧 РАБОТА С ПУТЯМИ И ФАЙЛАМИ
  // ================================

  /// Извлекает расширение файла из строки пути
  String get fileExtension {
    final parts = split('.');
    return parts.length > 1 ? parts.last : '';
  }

  /// Извлекает имя файла из строки пути
  String get fileName {
    final parts = split('/');
    return parts.last;
  }

  /// Проверяет является ли строка путем к изображению
  bool get isImagePath {
    final ext = fileExtension.toLowerCase();
    return ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp'].contains('.$ext');
  }
}
