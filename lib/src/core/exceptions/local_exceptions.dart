/// Локальные исключения приложения
///
/// ## 🔧 Доступные классы:
/// ### Исключения хранилища:
/// - `LocalStorageException` - базовый класс локальных ошибок
/// - `DatabaseException` - ошибки базы данных
/// - `CacheException` - ошибки кэширования
/// - `FileSystemException` - ошибки файловой системы
///
/// ### Специфичные исключения:
/// - `KeyNotFoundException` - ключ не найден в хранилище
/// - `StorageFullException` - переполнение хранилища
/// - `DataCorruptionException` - повреждение данных
library;

import 'app_exceptions.dart';

/// Базовый класс для всех локальных исключений
class LocalStorageException extends AppException {
  /// Тип хранилища (SharedPreferences, Hive, SQLite и т.д.)
  final String storageType;

  /// Операция которая вызвала ошибку
  final String operation;

  /// Создает локальное исключение
  const LocalStorageException(
    String message,
    this.storageType,
    this.operation, [
    StackTrace? stackTrace,
  ]) : super(message, stackTrace);

  @override
  String toString() =>
      'LocalStorageException ($storageType.$operation): $message';
}

/// Исключение для ошибок базы данных
class DatabaseException extends LocalStorageException {
  /// SQL запрос который вызвал ошибку (если применимо)
  final String? query;

  /// Код ошибки SQL (если применимо)
  final int? errorCode;

  /// Создает исключение базы данных
  const DatabaseException(
    String message,
    this.query,
    this.errorCode, [
    StackTrace? stackTrace,
  ]) : super(message, 'Database', 'query', stackTrace);

  @override
  String toString() {
    final code = errorCode != null ? ' [code: $errorCode]' : '';
    final q = query != null ? ' Query: $query' : '';
    return 'DatabaseException:$code $message$q';
  }
}

/// Исключение для ошибок кэширования
class CacheException extends LocalStorageException {
  /// Ключ кэша который вызвал ошибку
  final String? cacheKey;

  /// Тип кэша (memory, disk, network)
  final String cacheType;

  /// Создает исключение кэширования
  const CacheException(
    String message,
    this.cacheKey,
    this.cacheType, [
    StackTrace? stackTrace,
  ]) : super(message, 'Cache', 'read/write', stackTrace);

  @override
  String toString() {
    final key = cacheKey != null ? ' key: $cacheKey' : '';
    return 'CacheException ($cacheType): $message$key';
  }
}

/// Исключение для ошибок файловой системы
class FileSystemException extends LocalStorageException {
  /// Путь к файлу который вызвал ошибку
  final String? filePath;

  /// Операция с файлом (read, write, delete)
  final String fileOperation;

  /// Создает исключение файловой системы
  const FileSystemException(
    String message,
    this.filePath,
    this.fileOperation, [
    StackTrace? stackTrace,
  ]) : super(message, 'FileSystem', fileOperation, stackTrace);

  @override
  String toString() {
    final path = filePath != null ? ' path: $filePath' : '';
    return 'FileSystemException ($fileOperation): $message$path';
  }
}

// ================================
// 🔍 СПЕЦИФИЧНЫЕ ЛОКАЛЬНЫЕ ИСКЛЮЧЕНИЯ
// ================================

/// Исключение когда ключ не найден в хранилище
class KeyNotFoundException extends LocalStorageException {
  /// Ключ который не был найден
  final String key;

  /// Создает исключение "ключ не найден"
  const KeyNotFoundException(
    this.key,
    String storageType, [
    StackTrace? stackTrace,
  ]) : super(
         'Ключ "$key" не найден в хранилище',
         storageType,
         'read',
         stackTrace,
       );

  @override
  String toString() => 'KeyNotFoundException ($storageType): $message';
}

/// Исключение когда хранилище переполнено
class StorageFullException extends LocalStorageException {
  /// Доступное место в байтах
  final int availableSpace;

  /// Требуемое место в байтах
  final int requiredSpace;

  /// Создает исключение "хранилище переполнено"
  StorageFullException(
    this.availableSpace,
    this.requiredSpace,
    String storageType, [
    StackTrace? stackTrace,
  ]) : super(
         _createMessage(availableSpace, requiredSpace),
         storageType,
         'write',
         stackTrace,
       );

  static String _createMessage(int availableSpace, int requiredSpace) {
    return 'Недостаточно места в хранилище. Доступно: ${_formatBytes(availableSpace)}, Требуется: ${_formatBytes(requiredSpace)}';
  }

  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  String toString() => 'StorageFullException ($storageType): $message';
}

/// Исключение когда данные повреждены или имеют неверный формат
class DataCorruptionException extends LocalStorageException {
  /// Ожидаемый формат данных
  final String expectedFormat;

  /// Фактический формат данных
  final String actualFormat;

  /// Создает исключение "данные повреждены"
  const DataCorruptionException(
    this.expectedFormat,
    this.actualFormat,
    String storageType, [
    StackTrace? stackTrace,
  ]) : super(
         'Данные повреждены. Ожидался формат: $expectedFormat, получен: $actualFormat',
         storageType,
         'read',
         stackTrace,
       );

  @override
  String toString() => 'DataCorruptionException ($storageType): $message';
}

/// Утилиты для работы с локальными исключениями
class LocalExceptionUtils {
  /// Проверяет является ли исключение локальной ошибкой
  static bool isLocalException(dynamic exception) {
    return exception is LocalStorageException ||
        exception is DatabaseException ||
        exception is CacheException ||
        exception is FileSystemException;
  }

  /// Проверяет является ли исключение ошибкой "не найден"
  static bool isNotFoundException(dynamic exception) {
    return exception is KeyNotFoundException;
  }

  /// Проверяет является ли исключение ошибкой переполнения
  static bool isStorageFullException(dynamic exception) {
    return exception is StorageFullException;
  }
}
