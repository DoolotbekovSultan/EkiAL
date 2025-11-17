# exceptions/

## Назначение
Папка `exceptions` содержит кастомные исключения и обработчики ошибок для единообразной обработки ошибок во всем приложении.

## Структура
**exceptions/** - ⚠️ Обработка ошибок
- app_exceptions.dart - 🎯 Базовые исключения
- failure.dart - ❌ Failure классы
- exception_handler.dart - 🛡️ Обработчик исключений
- network_exceptions.dart - 🌐 Сетевые исключения
- local_exceptions.dart - 💾 Локальные исключения

## Описание файлов

### app_exceptions.dart
Базовые классы исключений приложения.

Содержит:
- базовый класс AppException
- общие исключения приложения
- иерархию исключений

### failure.dart
Классы Failure для функциональной обработки ошибок.

Содержит:
- базовый класс Failure
- типизированные Failure классы
- преобразование исключений в Failure

### exception_handler.dart
Обработчик исключений.

Содержит:
- глобальную обработку исключений
- логирование ошибок
- преобразование исключений в пользовательские сообщения

### network_exceptions.dart
Сетевые исключения.

Содержит:
- исключения для сетевых запросов
- обработку HTTP статусов
- таймауты и ошибки соединения

### local_exceptions.dart
Локальные исключения.

Содержит:
- ошибки базы данных
- ошибки файловой системы
- ошибки кэширования

## Преимущества

- Единообразная обработка ошибок во всем приложении
- Разделение сетевых и бизнес-ошибок
- Упрощение тестирования error cases
- Понятные пользовательские сообщения об ошибках

## Best Practices

1. Используйте Failure для функциональной обработки ошибок
2. Преобразуйте исключения в Failure на уровне репозитория
3. Логируйте все исключения для отладки
4. Предоставляйте понятные сообщения для пользователя
5. Разделяйте технические и бизнес-исключения
6. Используйте глобальную обработку для непредвиденных ошибок

## Примеры использования

```dart
// Базовое исключение
class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const AppException(this.message, [this.stackTrace]);
}

// Сетевое исключение
class NetworkException extends AppException {
  const NetworkException(String message) : super(message);
}

// Failure класс
@freezed
class Failure with _$Failure {
  const factory Failure.networkError(String message) = NetworkError;
  const factory Failure.serverError(String message) = ServerError;
  const factory Failure.localStorageError(String message) = LocalStorageError;
  const factory Failure.validationError(String message) = ValidationError;
}

// Использование в репозитории
class UserRepositoryImpl implements UserRepository {
  @override
  Future<Either<Failure, User>> getUser(String id) async {
    try {
      final user = await remoteDataSource.getUser(id);
      return Right(user);
    } on NetworkException catch (e) {
      return Left(Failure.networkError(e.message));
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    }
  }
}

// Глобальная обработка ошибок
void main() {
  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stackTrace) {
    ExceptionHandler.handle(error, stackTrace);
  });
}

// Иерархия исключений
Exception
├── AppException
│   ├── NetworkException
│   │   ├── SocketException
│   │   ├── TimeoutException
│   │   └── HttpException
│   ├── LocalException
│   │   ├── DatabaseException
│   │   ├── FileSystemException
│   │   └── CacheException
│   └── BusinessException
│       ├── ValidationException
│       ├── AuthenticationException
│       └── AuthorizationException
└── Failure
    ├── NetworkError
    ├── ServerError
    ├── LocalStorageError
    └── ValidationError