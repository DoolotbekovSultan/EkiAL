import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'app_exceptions.dart';

/// Глобальный обработчик исключений приложения
///
/// ## 🔧 Доступные методы:
/// ### Обработка исключений:
/// - `handle(exception, stackTrace)` - основная обработка
/// - `handleFlutterError(details)` - обработка Flutter ошибок
/// - `handlePlatformError(error)` - обработка платформенных ошибок
///
/// ### Логирование:
/// - `logException(exception, stackTrace)` - логирование исключений
/// - `logError(message, error)` - логирование ошибок
///
/// ### Преобразование в сообщения:
/// - `getUserMessage(exception)` - сообщение для пользователя
/// - `getDebugMessage(exception)` - сообщение для разработчика

/// Глобальный обработчик исключений
///
/// Обеспечивает централизованную обработку всех исключений в приложении.
/// Логирует ошибки, преобразует исключения в понятные сообщения для пользователя.
///
/// Пример использования:
/// ```dart
/// ExceptionHandler.handle(error, stackTrace);
/// ```
class ExceptionHandler {
  static final Logger _logger = Logger();

  /// Обрабатывает исключение и логирует его
  ///
  /// [exception] - обрабатываемое исключение
  /// [stackTrace] - стек вызовов для отладки
  /// [context] - дополнительный контекст (опционально)
  ///
  /// Пример использования:
  /// ```dart
  /// try {
  ///   // код который может выбросить исключение
  /// } catch (error, stackTrace) {
  ///   ExceptionHandler.handle(error, stackTrace);
  /// }
  /// ```
  static void handle(
    dynamic exception,
    StackTrace stackTrace, [
    String? context,
  ]) {
    logException(exception, stackTrace, context);

    // Можно добавить отправку в сервис аналитики
    // Analytics.trackError(exception, stackTrace, context);
  }

  /// Обрабатывает Flutter framework ошибки
  ///
  /// Используется для обработки ошибок самого Flutter framework.
  ///
  /// Пример использования в main.dart:
  /// ```dart
  /// FlutterError.onError = ExceptionHandler.handleFlutterError;
  /// ```
  static void handleFlutterError(FlutterErrorDetails details) {
    _logger.e(
      'Flutter Error: ${details.exception}',
      error: details.exception,
      stackTrace: details.stack,
    );

    // Отправляем в сервис аналитики
    // Analytics.trackFlutterError(details);
  }

  /// Обрабатывает платформенные ошибки (Android/iOS)
  ///
  /// Используется для обработки нативных ошибок платформ.
  ///
  /// Пример использования в main.dart:
  /// ```dart
  /// PlatformDispatcher.instance.onError = ExceptionHandler.handlePlatformError;
  /// ```
  static bool handlePlatformError(Object error, StackTrace stackTrace) {
    _logger.e('Platform Error: $error', error: error, stackTrace: stackTrace);

    // Возвращаем true чтобы предотвратить краш приложения
    return true;
  }

  /// Логирует исключение с дополнительным контекстом
  ///
  /// [exception] - исключение для логирования
  /// [stackTrace] - стек вызовов
  /// [context] - дополнительный контекст ошибки
  static void logException(
    dynamic exception,
    StackTrace stackTrace, [
    String? context,
  ]) {
    final message = context != null ? '[$context] $exception' : '$exception';

    if (exception is AppException) {
      _logger.w(message, error: exception, stackTrace: stackTrace);
    } else {
      _logger.e(message, error: exception, stackTrace: stackTrace);
    }
  }

  /// Логирует ошибку с сообщением
  ///
  /// [message] - описание ошибки
  /// [error] - объект ошибки (опционально)
  static void logError(String message, [dynamic error]) {
    if (error != null) {
      _logger.e(message, error: error);
    } else {
      _logger.e(message);
    }
  }

  /// Преобразует исключение в понятное сообщение для пользователя
  ///
  /// [exception] - исключение для преобразования
  ///
  /// Возвращает понятное сообщение для отображения пользователю
  ///
  /// Пример использования:
  /// ```dart
  /// final userMessage = ExceptionHandler.getUserMessage(exception);
  /// context.showSnackBar(userMessage);
  /// ```
  static String getUserMessage(dynamic exception) {
    if (exception is AppException) {
      return exception.message;
    } else if (exception is FormatException) {
      return 'Ошибка формата данных';
    } else if (exception is ArgumentError) {
      return 'Неверные параметры запроса';
    } else if (exception is StateError) {
      return 'Некорректное состояние приложения';
    } else {
      return 'Произошла непредвиденная ошибка';
    }
  }

  /// Преобразует исключение в отладочное сообщение
  ///
  /// [exception] - исключение для преобразования
  ///
  /// Возвращает детальное сообщение для разработчика
  static String getDebugMessage(dynamic exception) {
    return exception.toString();
  }
}

/// Утилиты для глобальной настройки обработки ошибок
class ErrorHandlerSetup {
  /// Настраивает глобальные обработчики ошибок
  ///
  /// Должен вызываться в main() до runApp()
  ///
  /// Пример использования:
  /// ```dart
  /// void main() {
  ///   ErrorHandlerSetup.initialize();
  ///   runApp(MyApp());
  /// }
  /// ```
  static void initialize() {
    // Обработка Flutter errors
    FlutterError.onError = ExceptionHandler.handleFlutterError;

    // Обработка Dart errors через runZonedGuarded
    // runZonedGuarded(() {
    //   runApp(MyApp());
    // }, (error, stackTrace) {
    //   ExceptionHandler.handle(error, stackTrace, 'Zoned Error');
    // });
  }
}
