// ================================
// 📨 BASE RESPONSE
// ================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';

/// Базовый класс для всех API ответов с Freezed
///
/// СОДЕРЖАНИЕ КЛАССА:
///
/// 🎯 ВАРИАНТЫ ОТВЕТОВ:
/// - [success] - успешный ответ с данными
/// - [error] - ответ с ошибкой
/// - [loading] - состояние загрузки (для клиента)
/// - [empty] - пустой ответ
///
/// 🔧 GETTERS:
/// - [isSuccess] - флаг успешного ответа
/// - [isError] - флаг ошибки
/// - [isLoading] - флаг загрузки
/// - [isEmpty] - флаг пустого ответа
/// - [data] - данные (только для success)
/// - [errorMessage] - сообщение об ошибке (только для error)
///
/// ⚡ МЕТОДЫ:
/// - [mapToState] - преобразование в BaseState
/// - [fold] - обработка всех вариантов
/// - [getDataOrThrow] - получение данных или исключение
///
/// 📝 ПАРАМЕТРЫ ТИПА:
/// - [T] - тип данных ответа
///
/// Пример использования:
/// ```dart
/// final response = await api.getUser();
/// return response.mapToState(
///   onSuccess: (user) => UserState.success(user),
///   onError: (message) => UserState.error(Failure.server(message: message)),
/// );
/// ```

@freezed
abstract class BaseResponse<T> with _$BaseResponse<T> {
  const BaseResponse._();

  // ================================
  // 🏗️ ВАРИАНТЫ ОТВЕТОВ
  // ================================

  /// Успешный ответ с данными
  const factory BaseResponse.success({
    required T data,
    String? message,
    @Default(200) int statusCode,
  }) = _Success<T>;

  /// Ответ с ошибкой
  const factory BaseResponse.error({
    required String message,
    @Default(500) int statusCode,
    dynamic errorData,
  }) = _Error<T>;

  /// Состояние загрузки (для клиентской обработки)
  const factory BaseResponse.loading() = _Loading<T>;

  /// Пустой ответ (данные отсутствуют)
  const factory BaseResponse.empty() = _Empty<T>;

  // ================================
  // 🔧 GETTERS И СВОЙСТВА
  // ================================

  /// Флаг успешного ответа
  bool get isSuccess => this is _Success<T>;

  /// Флаг ответа с ошибкой
  bool get isError => this is _Error<T>;

  /// Флаг состояния загрузки
  bool get isLoading => this is _Loading<T>;

  /// Флаг пустого ответа
  bool get isEmpty => this is _Empty<T>;

  /// Данные ответа (только для успешного ответа)
  T? get data => mapOrNull(success: (response) => response.data);

  /// Сообщение об ошибке (только для ответа с ошибкой)
  String? get errorMessage => mapOrNull(error: (response) => response.message);

  /// Код статуса ответа
  int? get statusCode => mapOrNull(
    success: (response) => response.statusCode,
    error: (response) => response.statusCode,
  );

  // ================================
  // ⚡ УТИЛИТНЫЕ МЕТОДЫ
  // ================================

  /// Преобразует ответ в состояние BLoC
  ///
  /// Пример использования:
  /// ```dart
  /// final state = response.mapToState(
  ///   onSuccess: (user) => UserState.success(user),
  ///   onError: (message) => UserState.error(Failure.server(message: message)),
  /// );
  /// ```
  R mapToState<R>({
    required R Function(T data) onSuccess,
    required R Function(String message) onError,
    required R Function() onLoading,
    required R Function() onEmpty,
  }) {
    return map(
      success: (response) => onSuccess(response.data),
      error: (response) => onError(response.message),
      loading: (_) => onLoading(),
      empty: (_) => onEmpty(),
    );
  }

  /// Обрабатывает ответ с колбэками (pattern matching)
  R fold<R>({
    required R Function(T data, String? message) onSuccess,
    required R Function(String message, int statusCode) onError,
    required R Function() onLoading,
    required R Function() onEmpty,
  }) {
    return map(
      success: (response) => onSuccess(response.data, response.message),
      error: (response) => onError(response.message, response.statusCode),
      loading: (_) => onLoading(),
      empty: (_) => onEmpty(),
    );
  }

  /// Получает данные или бросает исключение
  ///
  /// Пример использования:
  /// ```dart
  /// try {
  ///   final user = response.getDataOrThrow();
  /// } catch (e) {
  ///   // Обработка ошибки
  /// }
  /// ```
  T getDataOrThrow() {
    return map(
      success: (response) => response.data,
      error: (response) => throw ApiException(
        message: response.message,
        statusCode: response.statusCode,
      ),
      loading: (_) => throw StateError('Response is still loading'),
      empty: (_) => throw StateError('Response is empty'),
    );
  }

  /// Получает данные или значение по умолчанию
  T getDataOrDefault(T defaultValue) {
    return data ?? defaultValue;
  }

  /// Преобразует данные ответа в новый тип
  BaseResponse<R> mapData<R>(R Function(T data) mapper) {
    return map(
      success: (response) => BaseResponse<R>.success(
        data: mapper(response.data),
        message: response.message,
        statusCode: response.statusCode,
      ),
      error: (response) => BaseResponse<R>.error(
        message: response.message,
        statusCode: response.statusCode,
        errorData: response.errorData,
      ),
      loading: (_) => BaseResponse<R>.loading(),
      empty: (_) => BaseResponse<R>.empty(),
    );
  }
}

/// Исключение для API ошибок
class ApiException implements Exception {
  final String message;
  final int statusCode;

  const ApiException({required this.message, required this.statusCode});

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

/// Расширение для Future с BaseResponse
extension BaseResponseFutureExtensions<T> on Future<BaseResponse<T>> {
  /// Обрабатывает Future ответ и преобразует в состояние
  Future<R> mapToState<R>({
    required R Function(T data) onSuccess,
    required R Function(String message) onError,
    required R Function() onLoading,
    required R Function() onEmpty,
  }) async {
    final response = await this;
    return response.mapToState(
      onSuccess: onSuccess,
      onError: onError,
      onLoading: onLoading,
      onEmpty: onEmpty,
    );
  }

  /// Получает данные или null в случае ошибки
  Future<T?> getDataOrNull() async {
    try {
      final response = await this;
      return response.getDataOrDefault(null as T);
    } catch (e) {
      return null;
    }
  }
}
