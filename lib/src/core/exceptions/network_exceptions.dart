import 'app_exceptions.dart';

/// Сетевые исключения приложения
///
/// ## 🔧 Доступные классы:
/// ### Базовые сетевые исключения:
/// - `NetworkException` - базовый класс сетевых ошибок
/// - `SocketException` - ошибки сокетов
/// - `HttpException` - HTTP исключения
/// - `TimeoutException` - таймауты запросов
///
/// ### Специфичные HTTP исключения:
/// - `BadRequestException` - 400 Bad Request
/// - `UnauthorizedException` - 401 Unauthorized
/// - `ForbiddenException` - 403 Forbidden
/// - `NotFoundException` - 404 Not Found
/// - `InternalServerException` - 500 Internal Server Error

/// Базовый класс для всех сетевых исключений
class NetworkException extends AppException {
  /// Код статуса HTTP (если применимо)
  final int? statusCode;

  /// URL запроса (если применимо)
  final String? url;

  /// Создает сетевое исключение
  const NetworkException(
    String message,
    this.statusCode,
    this.url, [
    StackTrace? stackTrace,
  ]) : super(message, stackTrace);

  @override
  String toString() {
    final status = statusCode != null ? ' ($statusCode)' : '';
    return 'NetworkException$status: $message';
  }
}

/// Исключение для ошибок сокетов (отсутствие интернета)
class SocketException extends NetworkException {
  /// Создает исключение сокета
  const SocketException([String? message, String? url, StackTrace? stackTrace])
    : super(
        message ?? 'Отсутствует подключение к интернету',
        null,
        url,
        stackTrace,
      );

  @override
  String toString() => 'SocketException: $message';
}

/// Исключение для HTTP ошибок
class HttpException extends NetworkException {
  /// Создает HTTP исключение
  const HttpException(
    super.message,
    super.statusCode,
    super.url, [
    super.stackTrace,
  ]);

  @override
  String toString() => 'HttpException ($statusCode): $message';
}

/// Исключение для таймаутов сетевых запросов
class TimeoutException extends NetworkException {
  /// Длительность таймаута
  final Duration? timeout;

  /// Создает исключение таймаута
  const TimeoutException([
    String? message,
    this.timeout,
    String? url,
    StackTrace? stackTrace,
  ]) : super(message ?? 'Время запроса истекло', null, url, stackTrace);

  @override
  String toString() {
    final time = timeout != null ? ' (${timeout!.inSeconds}с)' : '';
    return 'TimeoutException$time: $message';
  }
}

// ================================
// 🔢 HTTP STATUS CODE EXCEPTIONS
// ================================

/// Исключение для 400 Bad Request
class BadRequestException extends HttpException {
  /// Создает исключение 400 Bad Request
  const BadRequestException([
    String? message,
    String? url,
    StackTrace? stackTrace,
  ]) : super(message ?? 'Неверный запрос', 400, url, stackTrace);
}

/// Исключение для 401 Unauthorized
class UnauthorizedException extends HttpException {
  /// Создает исключение 401 Unauthorized
  const UnauthorizedException([
    String? message,
    String? url,
    StackTrace? stackTrace,
  ]) : super(message ?? 'Требуется авторизация', 401, url, stackTrace);
}

/// Исключение для 403 Forbidden
class ForbiddenException extends HttpException {
  /// Создает исключение 403 Forbidden
  const ForbiddenException([
    String? message,
    String? url,
    StackTrace? stackTrace,
  ]) : super(message ?? 'Доступ запрещен', 403, url, stackTrace);
}

/// Исключение для 404 Not Found
class NotFoundException extends HttpException {
  /// Создает исключение 404 Not Found
  const NotFoundException([
    String? message,
    String? url,
    StackTrace? stackTrace,
  ]) : super(message ?? 'Ресурс не найден', 404, url, stackTrace);
}

/// Исключение для 500 Internal Server Error
class InternalServerException extends HttpException {
  /// Создает исключение 500 Internal Server Error
  const InternalServerException([
    String? message,
    String? url,
    StackTrace? stackTrace,
  ]) : super(message ?? 'Внутренняя ошибка сервера', 500, url, stackTrace);
}

/// Утилиты для работы с сетевыми исключениями
class NetworkExceptionUtils {
  /// Создает сетевое исключение на основе кода статуса
  static HttpException fromStatusCode(
    int statusCode,
    String message, [
    String? url,
  ]) {
    switch (statusCode) {
      case 400:
        return BadRequestException(message, url);
      case 401:
        return UnauthorizedException(message, url);
      case 403:
        return ForbiddenException(message, url);
      case 404:
        return NotFoundException(message, url);
      case 500:
        return InternalServerException(message, url);
      default:
        return HttpException(message, statusCode, url);
    }
  }

  /// Проверяет является ли исключение сетевой ошибкой
  static bool isNetworkException(dynamic exception) {
    return exception is NetworkException ||
        exception is SocketException ||
        exception is HttpException ||
        exception is TimeoutException;
  }

  /// Проверяет является ли исключение ошибкой таймаута
  static bool isTimeoutException(dynamic exception) {
    return exception is TimeoutException;
  }

  /// Проверяет является ли исключение ошибкой отсутствия интернета
  static bool isSocketException(dynamic exception) {
    return exception is SocketException;
  }
}
