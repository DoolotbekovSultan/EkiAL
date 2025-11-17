# Repositories

## Назначение
Папка `repositories` содержит реализации общих репозиториев, которые используются несколькими фичами приложения. Эти классы предоставляют единый интерфейс для доступа к общим данным.

## Структура
**repositories/** - 🔄 Репозитории данных
- shared_repository.dart - 🎯 Базовые репозитории и интерфейсы

## Описание

### repository.dart
Базовые репозитории для общих данных. Содержит:
- Абстрактные классы для всех общих репозиториев
- Базовые реализации CRUD операций
- Общие интерфейсы для работы с shared данными
- Утилиты для кэширования и синхронизации

## Основные компоненты

### BaseRepository
Абстрактный класс для всех общих репозиториев, определяющий:
- Стандартные методы доступа к данным
- Обработку ошибок и исключений
- Кэширование общих данных
- Синхронизацию между источниками данных

### SharedRepository
Интерфейс для общих репозиториев:
- `get` - получение данных
- `getAll` - получение всех данных
- `save` - сохранение данных
- `delete` - удаление данных
- `clear` - очистка кэша

## Преимущества

- **Единый интерфейс** - стандартизированный доступ к общим данным
- **Согласованность** - одинаковое поведение между фичами
- **Переиспользуемость** - общая логика для всех shared репозиториев
- **Кэширование** - централизованное управление общими данными
- **Поддерживаемость** - изменения в одном месте влияют на все фичи

## Best Practices

1. Наследуйте все общие репозитории от BaseRepository
2. Реализуйте стандартные методы доступа к данным
3. Используйте кэширование для часто используемых общих данных
4. Обрабатывайте ошибки единообразно
5. Документируйте поведение каждого общего репозитория
6. Тестируйте репозитории с моками данных
7. Следите за производительностью операций с общими данными

## Пример использования

```dart
// Базовый класс общего репозитория
abstract class BaseRepository<T> {
  Future<T?> get(String id);
  Future<List<T>> getAll();
  Future<void> save(T item);
  Future<void> delete(String id);
  Future<void> clear();
}

// Интерфейс общего репозитория
abstract class SharedRepository<T> implements BaseRepository<T> {
  Future<T?> getFromCache(String id);
  Future<void> refresh();
  Stream<T?> watch(String id);
}

// Общий репозиторий пользователя для всех фич
class UserRepository implements SharedRepository<UserModel> {
  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;
  final Map<String, UserModel> _cache = {};

  UserRepository({
    required UserRemoteDataSource remoteDataSource,
    required UserLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<UserModel?> get(String id) async {
    // Проверяем кэш
    if (_cache.containsKey(id)) {
      return _cache[id];
    }

    // Проверяем локальное хранилище
    final localUser = await _localDataSource.getUser(id);
    if (localUser != null) {
      _cache[id] = localUser;
      return localUser;
    }

    // Загружаем с сервера
    try {
      final remoteUser = await _remoteDataSource.getUser(id);
      if (remoteUser != null) {
        await _localDataSource.saveUser(remoteUser);
        _cache[id] = remoteUser;
        return remoteUser;
      }
    } catch (e) {
      throw RepositoryException('Failed to get user: $e');
    }

    return null;
  }

  @override
  Future<List<UserModel>> getAll() async {
    // Логика получения всех пользователей
    try {
      final users = await _remoteDataSource.getAllUsers();
      await _localDataSource.saveAllUsers(users);
      _cache.clear();
      users.forEach((user) => _cache[user.id] = user);
      return users;
    } catch (e) {
      throw RepositoryException('Failed to get all users: $e');
    }
  }

  @override
  Future<void> save(UserModel user) async {
    try {
      await _localDataSource.saveUser(user);
      await _remoteDataSource.saveUser(user);
      _cache[user.id] = user;
    } catch (e) {
      throw RepositoryException('Failed to save user: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _localDataSource.deleteUser(id);
      await _remoteDataSource.deleteUser(id);
      _cache.remove(id);
    } catch (e) {
      throw RepositoryException('Failed to delete user: $e');
    }
  }

  @override
  Future<void> clear() async {
    await _localDataSource.clear();
    _cache.clear();
  }

  @override
  Future<UserModel?> getFromCache(String id) async {
    return _cache[id];
  }

  @override
  Future<void> refresh() async {
    _cache.clear();
    await _localDataSource.clear();
  }

  @override
  Stream<UserModel?> watch(String id) {
    // Реализация наблюдения за изменениями пользователя
    return Stream.fromFuture(get(id)).asBroadcastStream();
  }
}

// Кастомное исключение для репозиториев
class RepositoryException implements Exception {
  final String message;
  
  const RepositoryException(this.message);
  
  @override
  String toString() => 'RepositoryException: $message';
}