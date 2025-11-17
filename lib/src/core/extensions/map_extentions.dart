import 'dart:convert'; // для jsonEncode/jsonDecode

/// Расширения для Map
///
/// ## 🔧 Доступные методы:
/// ### Безопасный доступ к значениям:
/// - `getString(key)` → String?
/// - `getInt(key)` → int?
/// - `getDouble(key)` → double?
/// - `getBool(key)` → bool?
/// - `getList(key)` → List`<dynamic>`?
/// - `getMap(key)` → Map`<String, dynamic>`?
///
/// ### Преобразование и фильтрация:
/// - `deepCopy()` → Map`<K, V>`
/// - `filter(predicate)` → Map`<K, V>`
/// - `mapKeys(transform)` → Map`<K2, V>`
/// - `mapValues(transform)` → Map`<K, V2>`
/// - `whereNotNull()` → Map`<K, V>`
///
/// ### Сериализация:
/// - `toJsonString()` → String
/// - `fromJsonString(jsonString)` → Map`<String, dynamic>`

extension MapExtensions<K, V> on Map<K, V> {
  // ================================
  // 🔍 БЕЗОПАСНЫЙ ДОСТУП К ЗНАЧЕНИЯМ
  // ================================

  /// Безопасно получает строковое значение по ключу
  String? getString(K key) {
    final value = this[key];
    return value is String ? value : null;
  }

  /// Безопасно получает целочисленное значение по ключу
  int? getInt(K key) {
    final value = this[key];
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  /// Безопасно получает дробное значение по ключу
  double? getDouble(K key) {
    final value = this[key];
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  /// Безопасно получает булево значение по ключу
  bool? getBool(K key) {
    final value = this[key];
    if (value is bool) return value;
    if (value is String) {
      return value.toLowerCase() == 'true';
    }
    return null;
  }

  /// Безопасно получает список по ключу
  List<dynamic>? getList(K key) {
    final value = this[key];
    return value is List ? value : null;
  }

  /// Безопасно получает вложенную map по ключу
  Map<String, dynamic>? getMap(K key) {
    final value = this[key];
    return value is Map ? Map<String, dynamic>.from(value as Map) : null;
  }

  // ================================
  // 🔄 ПРЕОБРАЗОВАНИЕ И ФИЛЬТРАЦИЯ
  // ================================

  /// Создает глубокую копию map
  Map<K, V> deepCopy() => Map<K, V>.from(this);

  /// Фильтрует элементы по условию
  Map<K, V> filter(bool Function(K key, V value) predicate) {
    return Map<K, V>.fromEntries(
      entries.where((entry) => predicate(entry.key, entry.value)),
    );
  }

  /// Преобразует ключи с помощью функции
  Map<K2, V> mapKeys<K2>(K2 Function(K key, V value) transform) {
    return Map<K2, V>.fromEntries(
      entries.map(
        (entry) => MapEntry(transform(entry.key, entry.value), entry.value),
      ),
    );
  }

  /// Преобразует значения с помощью функции
  Map<K, V2> mapValues<V2>(V2 Function(K key, V value) transform) {
    return Map<K, V2>.fromEntries(
      entries.map(
        (entry) => MapEntry(entry.key, transform(entry.key, entry.value)),
      ),
    );
  }

  /// Возвращает map без null значений
  Map<K, V> whereNotNull() {
    return Map<K, V>.fromEntries(entries.where((entry) => entry.value != null));
  }

  // ================================
  // 📄 СЕРИАЛИЗАЦИЯ
  // ================================

  /// Конвертирует map в JSON строку
  String toJsonString() {
    try {
      return jsonEncode(this);
    } catch (e) {
      return '{}';
    }
  }
}

/// Утилиты для работы с JSON
class MapUtils {
  /// Парсит JSON строку в Map
  static Map<String, dynamic> fromJsonString(String jsonString) {
    try {
      final decoded = jsonDecode(jsonString);
      return Map<String, dynamic>.from(decoded);
    } catch (e) {
      return {};
    }
  }
}
