# Models

## Назначение
Папка `models` содержит Data Transfer Objects (DTO) - модели данных для работы с внешними источниками. Эти классы представляют структуру данных для API, локальной БД и других внешних систем.

## Используемые библиотеки
- **json_annotation** - для аннотаций JSON сериализации и кодогенерации
- **freezed** - для создания immutable классов (опционально)
- **equatable** - для упрощения реализации equals и hashCode (опционально)

## Структура
**models/** - 📊 Модели данных
- model.dart - 🎯 Базовые DTO классы

## Описание

### model.dart
Базовые модели данных с использованием json_annotation. Содержит:
- Аннотированные классы для всех моделей с кодогенерацией
- Базовые DTO классы с автоматической сериализацией
- Generic модели для переиспользования
- Утилиты для работы с моделями

## Основные компоненты

### BaseModel
Абстрактный класс для всех моделей с json_annotation, определяющий:
- Базовые поля (id, createdAt, updatedAt) с аннотациями
- Автогенерируемые методы сериализации/десериализации
- Стандартную валидацию данных
- Автоматическое сравнение моделей

### DataTransferObject
Интерфейс для DTO классов с кодогенерацией:
- `fromJson` - автогенерируемое создание из JSON
- `toJson` - автогенерируемое преобразование в JSON
- `copyWith` - создание копии с изменениями
- Стандартные методы для данных

## Преимущества

- **Типобезопасность** - строгая проверка типов при сериализации
- **Автоматизация** - кодогенерация исключает ручные ошибки
- **Стандартизация** - единая структура для всех моделей
- **Согласованность** - одинаковые подходы к сериализации
- **Поддерживаемость** - легкое добавление и изменение полей

## Best Practices

1. Всегда используйте `json_annotation` для моделей в этой папке
2. Запускайте `build_runner` при изменении моделей
3. Используйте `@JsonKey` для кастомных преобразований полей
4. Документируйте форматы данных для каждого поля
5. Тестируйте сериализацию и десериализацию
6. Используйте generic модели для переиспользуемых структур
7. Следите за обратной совместимостью при изменении моделей

## Примеры использования

```dart
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

// Базовый класс модели с json_annotation
@JsonSerializable()
abstract class BaseModel {
  @JsonKey(name: 'id')
  final String id;
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const BaseModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson();
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// Интерфейс DTO
abstract class DataTransferObject {
  Map<String, dynamic> toJson();
}

// Конкретная реализация модели с кодогенерацией
@JsonSerializable()
class UserModel extends BaseModel implements DataTransferObject {
  final String name;
  final String email;
  
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  
  @JsonKey(name: 'user_role', unknownEnumValue: UserRole.user)
  final UserRole role;

  const UserModel({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.role,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? name,
    String? email,
    String? avatarUrl,
    UserRole? role,
  }) {
    return UserModel(
      id: id,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
    );
  }
}

// Generic модель для API ответов
@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final bool success;
  final T data;
  final String? message;
  final Map<String, dynamic>? meta;

  ApiResponse({
    required this.success,
    required this.data,
    this.message,
    this.meta,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) => _$ApiResponseToJson(this, toJsonT);
}

// Enum с аннотациями для сериализации
enum UserRole {
  @JsonValue('user')
  user,
  
  @JsonValue('admin')
  admin,
  
  @JsonValue('moderator')
  moderator,
}

Команды для кодогенерации

# Генерация кода для моделей
flutter pub run build_runner build

# Watch режим для разработки
flutter pub run build_runner watch

# Очистка и перегенерация
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs

Конфигурация pubspec.yaml

dependencies:
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.0
  json_serializable: ^6.7.1