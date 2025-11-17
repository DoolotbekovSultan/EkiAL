# repositories/

## Назначение
Папка `repositories` содержит интерфейсы (абстракции) репозиториев для работы с данными. Эти интерфейсы определяют контракты доступа к данным без указания конкретной реализации.

## Используемые библиотеки
- **dartz** - для типизированного возврата результатов (Either)

## Структура
**repositories/** - 📜 Интерфейсы репозиториев
- repository.dart - 🎯 Основной интерфейс
- cache_repository.dart - 💾 Кэширование данных
- stream_repository.dart - 🌊 Потоковые данные

## Описание файлов

### repository.dart
Основной интерфейс репозитория. Содержит:
- Контракты CRUD операций
- Методы для работы с данными
- Типизированные возвращаемые значения (Either)
- Спецификации для доменных операций

**Используемые библиотеки в файле:**
- `dartz` - Either, Unit для возврата результатов

### cache_repository.dart
Интерфейс для репозиториев с кэшированием. Содержит:
- Методы управления кэшем
- Стратегии обновления данных
- Контракты для синхронизации
- Операции инвалидации кэша

**Используемые библиотеки в файле:**
- `dartz` - Either для всех методов

### stream_repository.dart
Интерфейс для потоковых данных. Содержит:
- Методы возвращающие Stream
- Подписки на изменения данных
- Реактивные обновления состояний
- Контракты для real-time данных

**Используемые библиотеки в файле:**
- `dartz` - Either для синхронных методов

## Преимущества

- **Абстракция** - отделение бизнес-логики от реализации данных
- **Тестируемость** - легко мокать интерфейсы в тестах
- **Гибкость** - можно менять реализации без изменения домена
- **Чистота архитектуры** - domain слой не знает о деталях реализации
- **Type-safe** - строгая типизация всех операций

## Best Practices

1. Все методы должны возвращать Either
2. Используйте доменные сущности в параметрах и возвращаемых значениях
3. Определяйте Failure типы для конкретных ошибок домена
4. Разделяйте интерфейсы по ответственности
5. Используйте Stream для реактивных данных
6. Документируйте ожидаемое поведение методов
7. Следите за чистотой интерфейсов - без аннотаций реализации
8. Тестируйте реализации через интерфейсы

## Примеры использования

```dart
// repository.dart
abstract class Repository {
  // CRUD операции
  Future<Either<Failure, List<Entity>>> getAll();
  Future<Either<Failure, Entity>> getById(String id);
  Future<Either<Failure, Entity>> create(Entity entity);
  Future<Either<Failure, Entity>> update(Entity entity);
  Future<Either<Failure, Unit>> delete(String id);
  
  // Специфичные доменные операции
  Future<Either<Failure, List<Entity>>> search(String query);
  Future<Either<Failure, List<Entity>>> getByCategory(String categoryId);
}

// cache_repository.dart
abstract class CacheRepository {
  // Управление кэшем
  Future<Either<Failure, Unit>> clearCache();
  Future<Either<Failure, Unit>> refreshCache();
  Future<Either<Failure, bool>> isCacheValid();
  
  // Стратегии загрузки
  Future<Either<Failure, List<Entity>>> getWithCache();
  Future<Either<Failure, Entity>> getByIdWithCache(String id);
}

// stream_repository.dart  
abstract class StreamRepository {
  // Потоковые данные
  Stream<Either<Failure, List<Entity>>> watchAll();
  Stream<Either<Failure, Entity>> watchById(String id);
  Stream<Either<Failure, List<Entity>>> watchByCategory(String categoryId);
  
  // Синхронные операции
  Future<Either<Failure, Unit>> updateStream(Entity entity);
}

// Специализированный интерфейс для аутентификации
abstract class AuthRepository {
  Future<Either<AuthFailure, UserEntity>> login({
    required String email,
    required String password,
  });
  
  Future<Either<AuthFailure, Unit>> logout();
  Future<Either<AuthFailure, UserEntity>> register({
    required String email,
    required String password,
    required String name,
  });
  
  Future<Either<AuthFailure, bool>> isAuthenticated();
  Stream<UserEntity?> get userStream;
}

// Специализированный интерфейс для пользователей
abstract class UserRepository {
  Future<Either<UserFailure, UserEntity>> getCurrentUser();
  Future<Either<UserFailure, UserEntity>> updateProfile(UserEntity user);
  Future<Either<UserFailure, Unit>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  
  Stream<UserEntity> watchUserProfile(String userId);
}