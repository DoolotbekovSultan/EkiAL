# entities/

## Назначение
Папка `entities` содержит бизнес-сущности (domain entities) - основные объекты предметной области приложения. Эти классы представляют ключевые концепции бизнес-логики и не зависят от внешних слоев.

## Используемые библиотеки
- **freezed** - для создания immutable классов с кодогенерацией (рекомендуется)
- **equatable** - для упрощения реализации equals и hashCode (альтернатива)

## Структура
**entities/** - 🎯 Бизнес-сущности
- entity.dart - 🏷️ Основная сущность
- value_objects/ - 💎 Объекты-значения
- aggregates/ - 🎪 Агрегаты данных

## Описание файлов

### entity.dart
Основная бизнес-сущность. Содержит:
- Уникальный идентификатор сущности
- Основные свойства и атрибуты
- Бизнес-правила и инварианты
- Методы для работы с сущностью

**Используемые библиотеки в файле:**
- `freezed` - @freezed, @unfreezed (если используется)
- `equatable` - Equatable (если используется вместо freezed)

### value_objects/
Объекты-значения сущности. Содержит:
- Простые объекты с собственной логикой валидации
- Специфичные типы данных предметной области
- Бизнес-правила для составных свойств
- Методы сравнения и преобразования

**Используемые библиотеки в файлах:**
- `freezed` или `equatable` для value objects

### aggregates/
Агрегаты (составные сущности). Содержит:
- Группы связанных сущностей
- Корневые сущности агрегатов
- Правила целостности между сущностями
- Транзакционную логику изменений

**Используемые библиотеки в файлах:**
- `freezed` для сложных структур данных

## Преимущества

- **Чистота бизнес-логики** - нет зависимостей от внешних слоев
- **Неизменяемость** - предотвращение побочных эффектов
- **Бизнес-правила** - централизованное хранение инвариантов
- **Тестируемость** - легко тестировать бизнес-логику изолированно
- **Доменный язык** - отражение терминов предметной области

## Best Practices

1. Делайте все сущности immutable
2. Используйте value objects для сложных свойств
3. Валидируйте инварианты в конструкторах
4. Выносите сложную логику в методы сущностей
5. Используйте агрегаты для группировки связанных сущностей
6. Избегайте аннотаций внешних библиотек (кроме freezed/equatable)
7. Документируйте бизнес-правила в комментариях
8. Тестируйте все инварианты и бизнес-правила

## Примеры использования

```dart
// entity.dart с freezed
@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required Email email,
    required Name name,
    required DateTime createdAt,
    UserRole? role,
    @Default(false) bool isActive,
  }) = _UserEntity;

  // Бизнес-методы
  bool get canLogin => isActive;
  
  UserEntity deactivate() {
    return copyWith(isActive: false);
  }
  
  UserEntity changeRole(UserRole newRole) {
    return copyWith(role: newRole);
  }
}

// value_objects/email.dart
class Email {
  final String value;

  Email(this.value) {
    if (!_isValidEmail(value)) {
      throw InvalidEmailException(value);
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Email && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}

// value_objects/name.dart
class Name {
  final String value;

  Name(this.value) {
    if (value.isEmpty) {
      throw InvalidNameException('Name cannot be empty');
    }
    if (value.length > 50) {
      throw InvalidNameException('Name is too long');
    }
  }

  bool get isLong => value.length > 20;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Name && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}

// aggregates/order_aggregate.dart
@freezed
class OrderAggregate with _$OrderAggregate {
  const factory OrderAggregate({
    required OrderEntity order,
    required List<OrderItemEntity> items,
    required CustomerEntity customer,
  }) = _OrderAggregate;

  // Бизнес-правила агрегата
  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  bool get canBeCancelled {
    return order.status.canBeCancelled && items.every((item) => item.canBeCancelled);
  }

  OrderAggregate cancel() {
    if (!canBeCancelled) {
      throw CannotCancelOrderException();
    }
    return copyWith(
      order: order.cancel(),
      items: items.map((item) => item.cancel()).toList(),
    );
  }
}