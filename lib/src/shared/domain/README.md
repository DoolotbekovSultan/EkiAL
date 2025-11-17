# Domain

## Назначение
Папка `domain` содержит общие доменные сущности и бизнес-логику, которые используются несколькими фичами приложения. Эти классы представляют чистую бизнес-логику без зависимостей от внешних слоев.

## Структура
**domain/** - 🏛️ Доменный слой  
-  entity.dart - 🎯 Базовые сущности и бизнес-логика

## Описание

### entity.dart
Базовые доменные сущности. Содержит:
- Абстрактные классы для всех общих сущностей
- Базовые value objects и entities
- Общие бизнес-правила и валидации
- Интерфейсы для общих доменных сервисов

## Основные компоненты

### Entity
Абстрактный класс для всех общих сущностей, определяющий:
- Базовые идентификаторы и свойства
- Бизнес-правила и инварианты
- Методы сравнения и равенства
- Валидацию доменных объектов

### ValueObject
Базовый класс для value objects:
- Immutable объекты без идентификатора
- Бизнес-валидации при создании
- Семантическое равенство по значению
- Доменно-специфичная логика

### DomainService
Интерфейс для общих доменных сервисов:
- Операции, не принадлежащие конкретной сущности
- Сложная бизнес-логика spanning multiple entities
- Stateless сервисы с чистой логикой

## Преимущества

- **Чистая бизнес-логика** - независимость от внешних слоев
- **Согласованность** - единые бизнес-правила между фичами
- **Переиспользуемость** - общие сущности для всей системы
- **Тестируемость** - легкое unit-тестирование бизнес-логики
- **Поддерживаемость** - централизованные доменные правила

## Best Practices

1. Делайте все сущности immutable где это возможно
2. Инкапсулируйте бизнес-правила внутри сущностей
3. Валидируйте данные при создании доменных объектов
4. Используйте value objects для примитивов с бизнес-логикой
5. Документируйте бизнес-правила и инварианты
6. Тестируйте доменную логику изолированно
7. Избегайте зависимостей от внешних слоев

## Пример использования

```dart
// Базовый класс сущности
abstract class Entity<T> {
  final T id;

  const Entity(this.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Entity<T> &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// Базовый класс value object
abstract class ValueObject<T> {
  final T value;

  const ValueObject(this.value) {
    _validate(value);
  }

  void _validate(T value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueObject<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ValueObject($value)';
}

// Общая сущность пользователя для всех фич
class User extends Entity<String> {
  final UserName name;
  final Email email;
  final UserRole role;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required String id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  }) : super(id);

  User copyWith({
    UserName? name,
    Email? email,
    UserRole? role,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  bool get isAdmin => role == UserRole.admin;
  bool get isModerator => role == UserRole.moderator;
  
  // Бизнес-правила
  bool canManageUsers(User currentUser) {
    return currentUser.isAdmin || 
           (currentUser.isModerator && role != UserRole.admin);
  }
}

// Value object для email
class Email extends ValueObject<String> {
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  );

  const Email(super.value);

  @override
  void _validate(String value) {
    if (!_emailRegex.hasMatch(value)) {
      throw InvalidEmailException(value);
    }
  }
}

// Value object для имени пользователя
class UserName extends ValueObject<String> {
  const UserName(super.value);

  @override
  void _validate(String value) {
    if (value.isEmpty) {
      throw InvalidUserNameException('Username cannot be empty');
    }
    if (value.length < 2) {
      throw InvalidUserNameException('Username must be at least 2 characters');
    }
    if (value.length > 50) {
      throw InvalidUserNameException('Username cannot exceed 50 characters');
    }
  }
}

// Доменные исключения
class InvalidEmailException implements Exception {
  final String email;

  const InvalidEmailException(this.email);

  @override
  String toString() => 'InvalidEmailException: $email is not a valid email';
}

class InvalidUserNameException implements Exception {
  final String message;

  const InvalidUserNameException(this.message);

  @override
  String toString() => 'InvalidUserNameException: $message';
}

// Enum ролей пользователя
enum UserRole {
  user,
  moderator,
  admin,
}