/// Расширения для класса List
///
/// ## 🔧 Доступные методы:
/// ### Безопасный доступ:
/// - `firstOrNull` → T?
/// - `lastOrNull` → T?
/// - `elementAtOrNull(index)` → T?
/// - `elementAtOrDefault(index, defaultValue)` → T
///
/// ### Фильтрация и преобразование:
/// - `unique` → List<T>
/// - `whereNotNull` → List<T>
/// - `chunk(size)` → List<List<T>>
/// - `joinWith(separator)` → String
///
/// ### Пагинация и группировка:
/// - `paginate(page, pageSize)` → List<T>
/// - `groupBy(keyFunction)` → Map<K, List<T>>

// ignore_for_file: unintended_html_in_doc_comment, dangling_library_doc_comments

extension ListExtensions<T> on List<T> {
  // ================================
  // 🔍 БЕЗОПАСНЫЙ ДОСТУП К ЭЛЕМЕНТАМ
  // ================================

  /// Возвращает первый элемент или null если список пуст
  T? get firstOrNull => isEmpty ? null : first;

  /// Возвращает последний элемент или null если список пуст
  T? get lastOrNull => isEmpty ? null : last;

  /// Возвращает элемент по индексу или null если индекс вне диапазона
  T? elementAtOrNull(int index) =>
      index >= 0 && index < length ? this[index] : null;

  /// Возвращает элемент по индексу или значение по умолчанию
  T elementAtOrDefault(int index, T defaultValue) =>
      elementAtOrNull(index) ?? defaultValue;

  // ================================
  // 🎯 ФИЛЬТРАЦИЯ И ПРЕОБРАЗОВАНИЕ
  // ================================

  /// Возвращает список без дубликатов
  List<T> get unique => toSet().toList();

  /// Возвращает список без null элементов
  List<T> get whereNotNull => where((element) => element != null).toList();

  /// Разделяет список на чанки указанного размера
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  /// Объединяет список в строку с разделителем
  String joinWith(String separator) => join(separator);

  // ================================
  // 📊 ПАГИНАЦИЯ И ГРУППИРОВКА
  // ================================

  /// Возвращает срез списка для пагинации
  List<T> paginate(int page, int pageSize) {
    final start = (page - 1) * pageSize;
    final end = start + pageSize;
    return start < length ? sublist(start, end > length ? length : end) : [];
  }

  /// Группирует элементы по ключу
  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) {
    final groups = <K, List<T>>{};
    for (final element in this) {
      final key = keyFunction(element);
      groups.putIfAbsent(key, () => []).add(element);
    }
    return groups;
  }
}
