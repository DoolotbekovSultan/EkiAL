# repositories/

## Назначение
Папка `repositories` содержит реализации репозиториев, объявленных в domain слое. Отвечает за координацию работы с различными источниками данных и преобразование исключений в доменные ошибки.

## Используемые библиотеки
- **dartz** - для работы с Either и функциональной обработки ошибок
- **get_it** - для доступа к зависимостям через DI (в конструкторах)

## Структура
**repositories/** - 🔄 Реализации репозиториев
- repository_impl.dart - 🎯 Основная реализация
- cached_repository_impl.dart - 💾 Реализация с кэшированием
- network_repository_impl.dart - 🌐 Сетевая реализация

## Описание файлов

### repository_impl.dart
Основная реализация репозитория. Содержит:
- Реализацию всех методов из domain интерфейса
- Координацию между remote и local data sources
- Преобразование исключений в Failure объекты
- Бизнес-логику работы с данными

**Используемые библиотеки в файле:**
- `dartz` - Either, Left, Right для возврата результатов
- `get_it` - получение зависимостей в конструкторе

### cached_repository_impl.dart
Реализация с стратегией кэширования. Содержит:
- Логику кэширования часто запрашиваемых данных
- Стратегии инвалидации кэша
- Приоритеты источников данных (cache-first, network-first)
- Синхронизацию локальных и удаленных данных

**Используемые библиотеки в файле:**
- `dartz` - Either для всех возвращаемых значений

### network_repository_impl.dart
Реализация только с сетевыми источниками. Содержит:
- Работу исключительно с API
- Обработку сетевых ошибок
- Повторные попытки запросов
- Преобразование сетевых моделей в доменные сущности

**Используемые библиотеки в файле:**
- `dartz` - Either для обработки результатов

## Преимущества

- **Единая точка доступа** - координация всех источников данных
- **Обработка ошибок** - преобразование исключений в доменные Failure
- **Кэширование** - оптимизация производительности
- **Тестируемость** - легко мокать отдельные data sources
- **Гибкость** - можно менять стратегии работы с данными

## Best Practices

1. Всегда возвращайте Either из методов репозитория
2. Преобразуйте все исключения в соответствующие Failure
3. Используйте стратегию cache-then-network для часто меняющихся данных
4. Логируйте важные операции с данными
5. Разделяйте ответственность между разными репозиториями
6. Используйте DI для внедрения зависимостей
7. Тестируйте все сценарии работы репозитория
8. Документируйте стратегии кэширования и обновления данных

## Примеры использования

```dart
// repository_impl.dart
class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  RepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Either<Failure, List<Entity>>> getItems() async {
    try {
      // Сначала пробуем получить из кэша
      final cachedItems = _localDataSource.getCachedItems();
      if (cachedItems.isNotEmpty) {
        return Right(cachedItems.map((model) => model.toEntity()).toList());
      }

      // Если в кэше нет, запрашиваем с сервера
      final remoteItems = await _remoteDataSource.getItems();
      await _localDataSource.cacheItems(remoteItems);
      
      return Right(remoteItems.map((model) => model.toEntity()).toList());
      
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Entity>> getItemById(String id) async {
    try {
      // Сначала ищем локально
      final localItem = _localDataSource.getItemById(id);
      if (localItem != null) {
        return Right(localItem.toEntity());
      }

      // Если нет локально, запрашиваем с сервера
      final remoteItem = await _remoteDataSource.getItemById(id);
      await _localDataSource.cacheItem(remoteItem);
      
      return Right(remoteItem.toEntity());
      
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

// cached_repository_impl.dart
class CachedRepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final Map<String, Entity> _memoryCache = {};

  @override
  Future<Either<Failure, List<Entity>>> getItems() async {
    // Проверяем memory cache first
    if (_memoryCache.isNotEmpty) {
      return Right(_memoryCache.values.toList());
    }

    try {
      final result = await _remoteDataSource.getItems();
      final entities = result.map((model) => model.toEntity()).toList();
      
      // Обновляем memory cache
      for (final entity in entities) {
        _memoryCache[entity.id] = entity;
      }
      
      // Сохраняем в persistent cache
      await _localDataSource.cacheItems(result);
      
      return Right(entities);
    } on ServerException catch (e) {
      // При ошибке сети пробуем вернуть из локального кэша
      final cachedItems = _localDataSource.getCachedItems();
      if (cachedItems.isNotEmpty) {
        return Right(cachedItems.map((model) => model.toEntity()).toList());
      }
      return Left(ServerFailure(e.message));
    }
  }
}

// network_repository_impl.dart
class NetworkRepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;

  NetworkRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Entity>>> getItems() async {
    try {
      final result = await _remoteDataSource.getItems();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }
}