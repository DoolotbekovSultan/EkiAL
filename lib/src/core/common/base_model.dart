// ================================
// 📊 BASE MODEL
// ================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_model.freezed.dart';
part 'base_model.g.dart';

/// Базовый класс для всех моделей данных
@freezed
abstract class BaseModel with _$BaseModel {
  const BaseModel._();

  // ================================
  // 🏗️ БАЗОВАЯ МОДЕЛЬ
  // ================================

  /// Базовая модель для наследования
  const factory BaseModel({required String id}) = _BaseModel;

  // ================================
  // 🔧 МЕТОДЫ СЕРИАЛИЗАЦИИ
  // ================================

  /// Создает модель из JSON
  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  // ================================
  // ✅ МЕТОДЫ ВАЛИДАЦИИ
  // ================================

  /// Валидирует модель
  List<String> validate() {
    return _validateFields();
  }

  /// Проверяет валидность модели
  bool get isValid => validate().isEmpty;

  /// Проверяет невалидность модели
  bool get isNotValid => !isValid;

  // ================================
  // ⚡ УТИЛИТНЫЕ МЕТОДЫ
  // ================================

  /// Проверяет является ли модель пустой
  bool get isEmpty => _isEmpty();

  /// Проверяет является ли модель непустой
  bool get isNotEmpty => !isEmpty;

  /// Объединяет модель с другой моделью
  BaseModel merge(BaseModel other) {
    return _mergeWith(other);
  }

  /// Создает глубокую копию модели
  BaseModel deepCopy() {
    return _deepCopy();
  }

  /// Преобразует модель в Map для базы данных
  Map<String, dynamic> toDbMap() {
    return _toDbMap();
  }

  /// Создает модель из Map базы данных
  factory BaseModel.fromDbMap(Map<String, dynamic> map) {
    return _fromDbMap(map);
  }

  // ================================
  // 🔒 ВНУТРЕННИЕ МЕТОДЫ (для переопределения)
  // ================================

  /// Валидация полей модели
  @protected
  List<String> _validateFields() {
    final errors = <String>[];
    if (id.isEmpty) {
      errors.add('ID не может быть пустым');
    }
    return errors;
  }

  /// Проверка на пустоту
  @protected
  bool _isEmpty() {
    return id.isEmpty;
  }

  /// Объединение с другой моделью
  @protected
  BaseModel _mergeWith(BaseModel other) {
    return copyWith(id: other.id);
  }

  /// Создание глубокой копии
  @protected
  BaseModel _deepCopy() {
    return BaseModel.fromJson(toJson());
  }

  /// Преобразование в Map для БД
  @protected
  Map<String, dynamic> _toDbMap() {
    final json = toJson();
    return {
      ...json,
      '_type': runtimeType.toString(),
      '_createdAt': DateTime.now().toIso8601String(),
    };
  }

  /// Создание из Map БД
  @protected
  static BaseModel _fromDbMap(Map<String, dynamic> map) {
    final cleanMap = Map<String, dynamic>.from(map)
      ..removeWhere((key, value) => key.startsWith('_'));
    return BaseModel.fromJson(cleanMap);
  }
}

/// Миксин для добавления функциональности BaseModel к кастомным моделям
mixin BaseModelMixin {
  /// Получает ID модели (для переопределения)
  String get id;

  /// Получает тип модели
  String get modelType => runtimeType.toString();

  /// Создает пустую версию модели
  BaseModel get empty;

  /// Проверяет является ли модель новой (без ID)
  bool get isNew => id.isEmpty;

  /// Сравнивает модели по ID
  bool hasSameId(BaseModel other) => id == other.id;

  /// Преобразует модель в строку для отладки
  String toDebugString() {
    return '$modelType(id: $id)';
  }
}

/// Расширение для работы с коллекциями моделей
extension BaseModelListExtensions on List<BaseModel> {
  /// Фильтрует модели по валидности
  List<BaseModel> whereValid() => where((model) => model.isValid).toList();

  /// Фильтрует модели по невалидности
  List<BaseModel> whereNotValid() =>
      where((model) => model.isNotValid).toList();

  /// Фильтрует непустые модели
  List<BaseModel> whereNotEmpty() =>
      where((model) => model.isNotEmpty).toList();

  /// Фильтрует пустые модели
  List<BaseModel> whereEmpty() => where((model) => model.isEmpty).toList();

  /// Получает модели по ID
  BaseModel? getById(String id) => firstWhereOrNull((model) => model.id == id);

  /// Проверяет содержит ли модель с ID
  bool containsId(String id) => any((model) => model.id == id);

  /// Удаляет модель по ID
  List<BaseModel> removeById(String id) =>
      where((model) => model.id != id).toList();
}

/// Вспомогательное расширение для List
extension _FirstWhereOrNullExtension<E> on List<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
