// ================================
// 📈 BASE STATE
// ================================

import 'package:freezed_annotation/freezed_annotation.dart';
import '../exceptions/failure.dart';

part 'base_state.freezed.dart';

/// Базовый класс для всех состояний BLoC с Freezed
///
/// СОДЕРЖАНИЕ КЛАССА:
///
/// 🎯 ОСНОВНЫЕ СОСТОЯНИЯ:
/// - [initial] - начальное состояние
/// - [loading] - состояние загрузки
/// - [success] - успешное выполнение с данными
/// - [error] - состояние ошибки
/// - [empty] - состояние без данных
///
/// 🔧 GETTERS:
/// - [isInitial] - флаг начального состояния
/// - [isLoading] - флаг загрузки
/// - [isSuccess] - флаг успеха
/// - [isError] - флаг ошибки
/// - [isEmpty] - флаг пустого состояния
/// - [data] - данные (только для success)
/// - [failure] - ошибка (только для error)
///
/// ⚡ МЕТОДЫ:
/// - [mapData] - трансформация данных
/// - [fold] - обработка всех состояний
/// - [whenOrNull] - условная обработка
///
/// 📝 ПАРАМЕТРЫ ТИПА:
/// - [T] - тип данных состояния
///
/// Пример использования:
/// ```dart
/// @freezed
/// class UserState with _$UserState, BaseState<User> {
///   const factory UserState.initial() = _Initial;
///   const factory UserState.loading() = _Loading;
///   const factory UserState.success(User user) = _Success;
///   const factory UserState.error(Failure failure) = _Error;
///   const factory UserState.empty() = _Empty;
/// }
/// ```

@freezed
abstract class BaseState<T> with _$BaseState<T> {
  const BaseState._();

  // ================================
  // 🏗️ КОНСТРУКТОРЫ СОСТОЯНИЙ
  // ================================

  /// Начальное состояние (еще не загружено)
  const factory BaseState.initial() = _Initial;

  /// Состояние загрузки (данные грузятся)
  const factory BaseState.loading() = _Loading;

  /// Успешное состояние с данными
  const factory BaseState.success(T data) = _Success;

  /// Состояние ошибки
  const factory BaseState.error(Failure failure) = _Error;

  /// Пустое состояние (данные загружены, но пустые)
  const factory BaseState.empty() = _Empty;

  // ================================
  // 🔧 GETTERS И СВОЙСТВА
  // ================================

  /// Флаг начального состояния
  bool get isInitial => this is _Initial<T>;

  /// Флаг состояния загрузки
  bool get isLoading => this is _Loading<T>;

  /// Флаг успешного состояния
  bool get isSuccess => this is _Success<T>;

  /// Флаг состояния ошибки
  bool get isError => this is _Error<T>;

  /// Флаг пустого состояния
  bool get isEmpty => this is _Empty<T>;

  /// Данные состояния (только для успешного состояния)
  T? get data => mapOrNull(success: (state) => state.data);

  /// Информация об ошибке (только для состояния ошибки)
  Failure? get failure => mapOrNull(error: (state) => state.failure);

  /// Проверяет есть ли данные (success с не-null данными)
  bool get hasData => isSuccess && data != null;

  // ================================
  // ⚡ УТИЛИТНЫЕ МЕТОДЫ
  // ================================

  /// Преобразует данные состояния в новый тип
  ///
  /// Пример использования:
  /// ```dart
  /// final userState = UserState.success(user);
  /// final userNameState = userState.mapData((user) => user.name);
  /// // userNameState: BaseState<String>.success('John')
  /// ```
  BaseState<R> mapData<R>(R Function(T data) mapper) {
    return map(
      initial: (_) => BaseState<R>.initial(),
      loading: (_) => BaseState<R>.loading(),
      success: (state) => BaseState<R>.success(mapper(state.data)),
      error: (state) => BaseState<R>.error(state.failure),
      empty: (_) => BaseState<R>.empty(),
    );
  }

  /// Обрабатывает состояние с колбэками (pattern matching)
  ///
  /// Пример использования:
  /// ```dart
  /// Widget build(UserState state) {
  ///   return state.fold(
  ///     onInitial: () => Placeholder(),
  ///     onLoading: () => LoadingIndicator(),
  ///     onSuccess: (user) => UserProfile(user: user),
  ///     onError: (failure) => ErrorWidget(failure),
  ///     onEmpty: () => EmptyStateWidget(),
  ///   );
  /// }
  /// ```
  R fold<R>({
    required R Function() onInitial,
    required R Function() onLoading,
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onError,
    required R Function() onEmpty,
  }) {
    return map(
      initial: (_) => onInitial(),
      loading: (_) => onLoading(),
      success: (state) => onSuccess(state.data),
      error: (state) => onError(state.failure),
      empty: (_) => onEmpty(),
    );
  }

  /// Обрабатывает состояние только если есть данные
  ///
  /// Пример использования:
  /// ```dart
  /// state.ifHasData((user) {
  ///   print('Пользователь: $user');
  /// });
  /// ```
  void ifHasData(void Function(T data) action) {
    if (isSuccess && data != null) {
      action(data as T);
    }
  }

  /// Получает данные или значение по умолчанию
  ///
  /// Пример использования:
  /// ```dart
  /// final userName = state.getDataOrDefault(User.empty()).name;
  /// ```
  T getDataOrDefault(T defaultValue) {
    return data ?? defaultValue;
  }

  /// Создает копию состояния с новыми данными (только для success)
  ///
  /// Пример использования:
  /// ```dart
  /// final updatedState = state.copyWithData((user) => user.copyWith(name: 'New Name'));
  /// ```
  BaseState<T> copyWithData(T Function(T data) updater) {
    return map(
      initial: (_) => this,
      loading: (_) => this,
      success: (state) => BaseState<T>.success(updater(state.data)),
      error: (_) => this,
      empty: (_) => this,
    );
  }

  /// Проверяет находится ли состояние в "загружаемом" статусе
  bool get isBusy => isLoading;

  /// Проверяет можно ли обновлять UI (не загрузка и не начальное)
  bool get canUpdateUI => !isLoading && !isInitial;
}
