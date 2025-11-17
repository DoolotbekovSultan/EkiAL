// ================================
// 🎯 СИСТЕМА ОБРАБОТКИ ОШИБОК ПРИЛОЖЕНИЯ
// ================================

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// 🎯 БАЗОВЫЙ КЛАСС ДЛЯ ВСЕХ ОШИБОК ПРИЛОЖЕНИЯ
///
/// Использует Freezed для:
/// - Pattern matching
/// - Неизменяемости
/// - Автоматического copyWith
///
/// Все Failure содержат:
/// - message: Человеко-читаемое сообщение
/// - code: Машинно-читаемый код ошибки
///
/// Пример использования:
/// ```dart
/// try {
///   await api.getUser();
/// } on DioException catch (e) {
///   throw Failure.fromDioException(e);
/// }
///
/// // Pattern matching
/// failure.when(
///   network: (message, code) => showNetworkError(message),
///   server: (message, code, statusCode) => showServerError(message),
///   auth: (message, code) => navigateToLogin(),
/// );
/// ```
@freezed
class Failure with _$Failure {
  const Failure._();

  // ================================
  // 🏗️ ОСНОВНЫЕ КОНСТРУКТОРЫ
  // ================================

  /// 📡 ОБЩИЕ СЕТЕВЫЕ ОШИБКИ
  const factory Failure.network({
    @Default('Ошибка сети') String message,
    @Default('NETWORK_ERROR') String code,
  }) = NetworkFailure;

  /// ⏰ ТАЙМАУТ СОЕДИНЕНИЯ
  const factory Failure.timeout({
    @Default('Превышено время ожидания') String message,
    @Default('TIMEOUT_ERROR') String code,
  }) = TimeoutFailure;

  /// 🖥️ ОШИБКИ СЕРВЕРА (5xx)
  const factory Failure.server({
    @Default('Ошибка сервера') String message,
    @Default('SERVER_ERROR') String code,
    int? statusCode,
  }) = ServerFailure;

  /// 👤 ОШИБКИ КЛИЕНТА (4xx)
  const factory Failure.client({
    @Default('Ошибка клиента') String message,
    @Default('CLIENT_ERROR') String code,
    int? statusCode,
  }) = ClientFailure;

  /// 🔐 ОШИБКИ АУТЕНТИФИКАЦИИ И АВТОРИЗАЦИИ
  const factory Failure.auth({
    @Default('Ошибка доступа') String message,
    @Default('AUTH_ERROR') String code,
  }) = AuthFailure;

  /// 💾 ОШИБКИ ЛОКАЛЬНОГО ХРАНИЛИЩА
  const factory Failure.localStorage({
    @Default('Ошибка локального хранилища') String message,
    @Default('LOCAL_STORAGE_ERROR') String code,
  }) = LocalStorageFailure;

  /// 🗄️ ОШИБКИ КЭША
  const factory Failure.cache({
    @Default('Ошибка кэша') String message,
    @Default('CACHE_ERROR') String code,
  }) = CacheFailure;

  /// 🗃️ ОШИБКИ БАЗЫ ДАННЫХ
  const factory Failure.database({
    @Default('Ошибка базы данных') String message,
    @Default('DATABASE_ERROR') String code,
  }) = DatabaseFailure;

  /// 📝 ОШИБКИ ВАЛИДАЦИИ
  const factory Failure.validation({
    @Default('Ошибка валидации') String message,
    @Default('VALIDATION_ERROR') String code,
  }) = ValidationFailure;

  /// ❓ НЕИЗВЕСТНАЯ ОШИБКА
  const factory Failure.unknown({
    @Default('Неизвестная ошибка') String message,
    @Default('UNKNOWN_ERROR') String code,
  }) = UnknownFailure;

  // ================================
  // 🏗️ СПЕЦИАЛИЗИРОВАННЫЕ КОНСТРУКТОРЫ
  // ================================

  /// 🌐 ОТСУТСТВИЕ ИНТЕРНЕТА
  const factory Failure.networkNoInternet() = NetworkNoInternetFailure;

  /// 🌐 НЕДЕЙСТВИТЕЛЬНЫЙ СЕРТИФИКАТ
  const factory Failure.networkBadCertificate() = NetworkBadCertificateFailure;

  /// 🌐 ОТМЕНЕННЫЙ ЗАПРОС
  const factory Failure.networkCancelled() = NetworkCancelledFailure;

  /// 🖥️ НЕВЕРНЫЙ ЗАПРОС (400)
  const factory Failure.serverBadRequest({String? message}) =
      ServerBadRequestFailure;

  /// 🖥️ РЕСУРС НЕ НАЙДЕН (404)
  const factory Failure.serverNotFound({String? message}) =
      ServerNotFoundFailure;

  /// 🖥️ ОШИБКИ ВАЛИДАЦИИ СЕРВЕРА (422)
  const factory Failure.serverValidationError({
    String? message,
    Map<String, List<String>>? errors,
  }) = ServerValidationFailure;

  /// 🖥️ СЛИШКОМ МНОГО ЗАПРОСОВ (429)
  const factory Failure.serverTooManyRequests() = ServerTooManyRequestsFailure;

  /// 🖥️ ВНУТРЕННЯЯ ОШИБКА СЕРВЕРА (5xx)
  const factory Failure.serverInternalError({
    String? message,
    required int statusCode,
  }) = ServerInternalErrorFailure;

  /// 👤 НЕВЕРНЫЙ ЗАПРОС КЛИЕНТА (400)
  const factory Failure.clientBadRequest({String? message}) =
      ClientBadRequestFailure;

  /// 👤 НЕАВТОРИЗОВАН (401)
  const factory Failure.clientUnauthorized() = ClientUnauthorizedFailure;

  /// 👤 ЗАПРЕЩЕНО (403)
  const factory Failure.clientForbidden() = ClientForbiddenFailure;

  /// 👤 НЕ НАЙДЕНО (404)
  const factory Failure.clientNotFound({String? message}) =
      ClientNotFoundFailure;

  /// 👤 ОШИБКИ ВАЛИДАЦИИ КЛИЕНТА (422)
  const factory Failure.clientValidationError({
    String? message,
    Map<String, List<String>>? errors,
  }) = ClientValidationFailure;

  /// 🔐 НЕАВТОРИЗОВАН
  const factory Failure.authUnauthorized() = AuthUnauthorizedFailure;

  /// 🔐 ЗАПРЕЩЕНО
  const factory Failure.authForbidden() = AuthForbiddenFailure;

  /// 🔐 ИСТЕК СРОК ДЕЙСТВИЯ
  const factory Failure.authExpired() = AuthExpiredFailure;
}

// ================================
// 🛠️ УТИЛИТЫ ДЛЯ РАБОТЫ С FAILURE
// ================================

/// 🎯 РАСШИРЕНИЯ ДЛЯ УДОБНОЙ РАБОТЫ С FAILURE
extension FailureUtils on Failure {
  // ================================
  // 📊 ИНФОРМАЦИЯ ОБ ОШИБКЕ
  // ================================

  /// 📝 Возвращает понятное сообщение для пользователя
  String get userMessage => when(
    network: (message, _) => message,
    timeout: (message, _) => message,
    server: (message, _, __) => message,
    client: (message, _, __) => message,
    auth: (message, _) => message,
    localStorage: (message, _) => message,
    cache: (message, _) => message,
    database: (message, _) => message,
    validation: (message, _) => message,
    unknown: (message, _) => message,
    networkNoInternet: () => 'Отсутствует подключение к интернету',
    networkBadCertificate: () => 'Недействительный сертификат',
    networkCancelled: () => 'Запрос отменен',
    serverBadRequest: (message) => message ?? 'Неверный запрос',
    serverNotFound: (message) => message ?? 'Ресурс не найден',
    serverValidationError: (message, _) => message ?? 'Ошибка валидации',
    serverTooManyRequests: () => 'Слишком много запросов',
    serverInternalError: (message, _) => message ?? 'Внутренняя ошибка сервера',
    clientBadRequest: (message) => message ?? 'Неверный запрос',
    clientUnauthorized: () => 'Неавторизован',
    clientForbidden: () => 'Доступ запрещен',
    clientNotFound: (message) => message ?? 'Ресурс не найден',
    clientValidationError: (message, _) => message ?? 'Ошибка валидации',
    authUnauthorized: () => 'Требуется авторизация',
    authForbidden: () => 'Доступ запрещен',
    authExpired: () => 'Сессия истекла',
  );

  /// 🔢 Возвращает код ошибки для аналитики
  String get errorCode => when(
    network: (_, code) => code,
    timeout: (_, code) => code,
    server: (_, code, __) => code,
    client: (_, code, __) => code,
    auth: (_, code) => code,
    localStorage: (_, code) => code,
    cache: (_, code) => code,
    database: (_, code) => code,
    validation: (_, code) => code,
    unknown: (_, code) => code,
    networkNoInternet: () => 'NO_INTERNET',
    networkBadCertificate: () => 'BAD_CERTIFICATE',
    networkCancelled: () => 'CANCELLED',
    serverBadRequest: (_) => 'BAD_REQUEST',
    serverNotFound: (_) => 'NOT_FOUND',
    serverValidationError: (_, __) => 'VALIDATION_ERROR',
    serverTooManyRequests: () => 'TOO_MANY_REQUESTS',
    serverInternalError: (_, __) => 'INTERNAL_SERVER_ERROR',
    clientBadRequest: (_) => 'BAD_REQUEST',
    clientUnauthorized: () => 'UNAUTHORIZED',
    clientForbidden: () => 'FORBIDDEN',
    clientNotFound: (_) => 'NOT_FOUND',
    clientValidationError: (_, __) => 'VALIDATION_ERROR',
    authUnauthorized: () => 'UNAUTHORIZED',
    authForbidden: () => 'FORBIDDEN',
    authExpired: () => 'TOKEN_EXPIRED',
  );

  // ================================
  // 🔍 ПРОВЕРКИ ТИПА ОШИБКИ
  // ================================

  /// 🌐 Проверяет является ли ошибка сетевой
  bool get isNetworkError =>
      this is NetworkFailure ||
      this is TimeoutFailure ||
      this is NetworkNoInternetFailure ||
      this is NetworkBadCertificateFailure ||
      this is NetworkCancelledFailure;

  /// 🖥️ Проверяет является ли ошибка серверной
  bool get isServerError =>
      this is ServerFailure ||
      this is ServerBadRequestFailure ||
      this is ServerNotFoundFailure ||
      this is ServerValidationFailure ||
      this is ServerTooManyRequestsFailure ||
      this is ServerInternalErrorFailure;

  /// 👤 Проверяет является ли ошибка клиентской
  bool get isClientError =>
      this is ClientFailure ||
      this is ClientBadRequestFailure ||
      this is ClientUnauthorizedFailure ||
      this is ClientForbiddenFailure ||
      this is ClientNotFoundFailure ||
      this is ClientValidationFailure;

  /// 🔐 Проверяет является ли ошибка связанной с аутентификацией
  bool get isAuthenticationError =>
      this is AuthFailure ||
      this is AuthUnauthorizedFailure ||
      this is AuthForbiddenFailure ||
      this is AuthExpiredFailure;

  /// 💾 Проверяет является ли ошибка локальной (хранилище/кэш/БД)
  bool get isLocalError =>
      this is LocalStorageFailure ||
      this is CacheFailure ||
      this is DatabaseFailure;

  /// 📝 Проверяет является ли ошибка ошибкой валидации
  bool get isValidationError =>
      this is ValidationFailure ||
      this is ServerValidationFailure ||
      this is ClientValidationFailure;
}

// ================================
// 🏗️ ФАБРИКИ ДЛЯ СОЗДАНИЯ FAILURE
// ================================

/// 🛠️ УТИЛИТЫ ДЛЯ СОЗДАНИЯ FAILURE ИЗ РАЗЛИЧНЫХ ИСТОЧНИКОВ
extension FailureFactories on Failure {
  /// 🔄 Создает Failure из DioException
  static Failure fromDioException(DioException error) {
    final statusCode = error.response?.statusCode;
    final message = error.message ?? 'Неизвестная сетевая ошибка';

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.timeout();

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return const Failure.networkNoInternet();

      case DioExceptionType.badCertificate:
        return const Failure.networkBadCertificate();

      case DioExceptionType.badResponse:
        return _mapHttpErrorToFailure(
          statusCode,
          message,
          error.response?.data,
        );

      case DioExceptionType.cancel:
        return const Failure.networkCancelled();
    }
  }

  /// 🗺️ Преобразует HTTP ошибку в Failure
  static Failure _mapHttpErrorToFailure(
    int? statusCode,
    String message,
    dynamic responseData,
  ) {
    final errorMessage = _extractErrorMessage(responseData) ?? message;

    switch (statusCode) {
      case 400:
        return Failure.clientBadRequest(message: errorMessage);

      case 401:
        return const Failure.authUnauthorized();

      case 403:
        return const Failure.authForbidden();

      case 404:
        return Failure.clientNotFound(message: errorMessage);

      case 422:
        return Failure.clientValidationError(
          message: errorMessage,
          errors: _extractValidationErrors(responseData),
        );

      case 429:
        return const Failure.serverTooManyRequests();

      case 500:
      case 502:
      case 503:
        return Failure.serverInternalError(
          message: errorMessage,
          statusCode: statusCode!,
        );

      default:
        if (statusCode != null && statusCode >= 500) {
          return Failure.serverInternalError(
            message: errorMessage,
            statusCode: statusCode,
          );
        } else if (statusCode != null && statusCode >= 400) {
          return Failure.client(message: errorMessage, statusCode: statusCode);
        } else {
          return Failure.unknown(message: errorMessage);
        }
    }
  }

  /// 📝 Извлекает сообщение об ошибке из ответа сервера
  static String? _extractErrorMessage(dynamic responseData) {
    if (responseData is Map) {
      return responseData['message']?.toString() ??
          responseData['error']?.toString() ??
          responseData['detail']?.toString() ??
          responseData['title']?.toString();
    } else if (responseData is String) {
      return responseData;
    }
    return null;
  }

  /// 📋 Извлекает ошибки валидации из ответа сервера
  static Map<String, List<String>>? _extractValidationErrors(
    dynamic responseData,
  ) {
    if (responseData is Map && responseData['errors'] is Map) {
      final errors = <String, List<String>>{};
      for (final entry in (responseData['errors'] as Map).entries) {
        if (entry.value is List) {
          errors[entry.key] = List<String>.from(entry.value);
        } else if (entry.value is String) {
          errors[entry.key] = [entry.value];
        }
      }
      return errors;
    }
    return null;
  }
}
