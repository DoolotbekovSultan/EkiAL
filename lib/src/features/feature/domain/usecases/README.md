# usecases/

## Назначение
Папка `usecases` содержит сценарии использования (use cases) - конкретные бизнес-операции приложения. Каждый use case инкапсулирует одну бизнес-правило или операцию.

## Используемые библиотеки
- **dartz** - для типизированного возврата результатов (Either)
- **injectable** - для dependency injection через аннотации

## Примерная Структура
**usecases/** - 🔧 Сценарии использования
- get_items_usecase.dart - 📥 Получение данных
- create_item_usecase.dart - ➕ Создание данных
- update_item_usecase.dart - ✏️ Обновление данных
- delete_item_usecase.dart - 🗑️ Удаление данных
- complex_operation_usecase.dart - 🎯 Сложные операции
## Описание файлов

### get_items_usecase.dart
Use cases для получения данных. Содержит:
- Получение списков сущностей
- Фильтрацию и пагинацию
- Поиск и сортировку
- Получение отдельных сущностей

**Используемые библиотеки в файле:**
- `dartz` - Either для возврата результатов
- `injectable` - @injectable, @singleton (если используется)

### create_item_usecase.dart
Use cases для создания данных. Содержит:
- Валидацию входных данных
- Создание новых сущностей
- Проверку бизнес-правил
- Обработку конфликтов

**Используемые библиотеки в файле:**
- `dartz` - Either для возврата результатов

### update_item_usecase.dart
Use cases для обновления данных. Содержит:
- Обновление существующих сущностей
- Валидацию изменений
- Проверку прав доступа
- Оптимистичные обновления

**Используемые библиотеки в файле:**
- `dartz` - Either для возврата результатов

### delete_item_usecase.dart
Use cases для удаления данных. Содержит:
- Удаление сущностей
- Каскадное удаление
- Проверку зависимостей
- Soft delete операции

**Используемые библиотеки в файле:**
- `dartz` - Either для возврата результатов

### complex_operation_usecase.dart
Сложные бизнес-операции. Содержит:
- Композицию нескольких операций
- Транзакционную логику
- Координацию между репозиториями
- Сложную бизнес-логику

**Используемые библиотеки в файле:**
- `dartz` - Either для возврата результатов

## Преимущества

- **Единая ответственность** - каждый use case делает одну вещь
- **Тестируемость** - легко тестировать изолированную бизнес-логику
- **Переиспользуемость** - use cases можно использовать в разных местах
- **Чистота архитектуры** - отделение бизнес-логики от реализации
- **Документация** - use cases явно описывают бизнес-операции

## Best Practices

1. Один use case = одна бизнес-операция
2. Всегда возвращайте Either из execute методов
3. Используйте параметры вместо полей класса где возможно
4. Валидируйте входные параметры в use case
5. Инжектируйте зависимости через конструктор
6. Не храните состояние в use cases
7. Документируйте бизнес-правила в комментариях
8. Тестируйте все возможные сценарии use case

## Примеры использования

```dart
// get_items_usecase.dart
@injectable
class GetItemsUseCase {
  final Repository _repository;

  GetItemsUseCase(this._repository);

  Future<Either<Failure, List<Entity>>> execute() async {
    return await _repository.getAll();
  }
}

// get_item_by_id_usecase.dart
@injectable
class GetItemByIdUseCase {
  final Repository _repository;

  GetItemByIdUseCase(this._repository);

  Future<Either<Failure, Entity>> execute(String id) async {
    if (id.isEmpty) {
      return Left(InvalidParameterFailure('ID cannot be empty'));
    }
    return await _repository.getById(id);
  }
}

// create_item_usecase.dart
@injectable
class CreateItemUseCase {
  final Repository _repository;

  CreateItemUseCase(this._repository);

  Future<Either<Failure, Entity>> execute(CreateItemParams params) async {
    // Валидация бизнес-правил
    if (params.name.length < 3) {
      return Left(ValidationFailure('Name must be at least 3 characters'));
    }

    if (params.price <= 0) {
      return Left(ValidationFailure('Price must be positive'));
    }

    final entity = Entity(
      id: generateId(),
      name: params.name,
      price: params.price,
      createdAt: DateTime.now(),
    );

    return await _repository.create(entity);
  }
}

// update_item_usecase.dart
@injectable
class UpdateItemUseCase {
  final Repository _repository;

  UpdateItemUseCase(this._repository);

  Future<Either<Failure, Entity>> execute(UpdateItemParams params) async {
    // Получаем текущую сущность
    final currentResult = await _repository.getById(params.id);
    
    return currentResult.fold(
      (failure) => Left(failure),
      (currentEntity) async {
        // Применяем изменения с валидацией
        final updatedEntity = currentEntity.copyWith(
          name: params.name ?? currentEntity.name,
          price: params.price ?? currentEntity.price,
        );

        // Дополнительная бизнес-логика
        if (updatedEntity.price > 1000 && !params.isApproved) {
          return Left(ApprovalRequiredFailure('Approval required for high-value items'));
        }

        return await _repository.update(updatedEntity);
      },
    );
  }
}

// complex_operation_usecase.dart
@injectable
class ProcessOrderUseCase {
  final OrderRepository _orderRepository;
  final PaymentRepository _paymentRepository;
  final InventoryRepository _inventoryRepository;

  ProcessOrderUseCase(
    this._orderRepository,
    this._paymentRepository,
    this._inventoryRepository,
  );

  Future<Either<Failure, OrderEntity>> execute(ProcessOrderParams params) async {
    // 1. Проверяем доступность товаров
    final availabilityResult = await _checkAvailability(params.items);
    if (availabilityResult.isLeft()) {
      return availabilityResult;
    }

    // 2. Обрабатываем платеж
    final paymentResult = await _processPayment(params.paymentInfo);
    if (paymentResult.isLeft()) {
      return paymentResult;
    }

    // 3. Создаем заказ
    final orderResult = await _createOrder(params);
    if (orderResult.isLeft()) {
      // Отменяем платеж при ошибке
      await _paymentRepository.cancelPayment(params.paymentInfo.id);
      return orderResult;
    }

    // 4. Резервируем товары
    final reservationResult = await _reserveItems(params.items);
    if (reservationResult.isLeft()) {
      // Отменяем заказ и платеж при ошибке
      await _orderRepository.cancelOrder(orderResult.getOrElse(() => throw Exception()).id);
      await _paymentRepository.cancelPayment(params.paymentInfo.id);
      return reservationResult;
    }

    return orderResult;
  }
}

// Параметры для use cases
class CreateItemParams {
  final String name;
  final double price;
  final String? description;

  CreateItemParams({
    required this.name,
    required this.price,
    this.description,
  });
}

class UpdateItemParams {
  final String id;
  final String? name;
  final double? price;
  final bool isApproved;

  UpdateItemParams({
    required this.id,
    this.name,
    this.price,
    this.isApproved = false,
  });
}