// ================================
// 🎛️ BASE BLOC
// ================================

import 'package:flutter_bloc/flutter_bloc.dart';
import '../exceptions/failure.dart';
import '../utils/log_utils.dart';

/// Базовый класс для всех BLoC компонентов приложения
///
/// СОДЕРЖАНИЕ КЛАССА:
///
/// 🎯 ОСНОВНЫЕ МЕТОДЫ:
/// - [onEvent] - обработка событий
/// - [onChange] - отслеживание изменений состояния
/// - [onError] - обработка ошибок
///
/// 🔧 ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ:
/// - [logEvent] - логирование событий
/// - [logState] - логирование изменений состояния
/// - [handleError] - обработка ошибок
///
/// ⚡ УТИЛИТНЫЕ МЕТОДЫ:
/// - [executeWithErrorHandling] - выполнение с обработкой ошибок
/// - [withLoading] - обновление с индикатором загрузки
///
/// 📝 ПАРАМЕТРЫ ТИПА:
/// - [Event] - тип событий
/// - [State] - тип состояния
///
/// Пример использования:
/// ```dart
/// class UserBloc extends BaseBloc<UserEvent, UserState> {
///   UserBloc() : super(UserState.initial());
///
///   @override
///   Stream<UserState> mapEventToState(UserEvent event) async* {
///     yield* event.map(
///       loadUser: (event) => _loadUser(event.userId),
///       updateUser: (event) => _updateUser(event.user),
///     );
///   }
/// }
/// ```

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(State initialState) : super(initialState) {
    Log.i(
      '🎛️ BLoC $runtimeType инициализирован',
      error: 'Начальное состояние: $initialState',
    );
  }

  // ================================
  // 🎯 ОСНОВНЫЕ МЕТОДЫ
  // ================================

  @override
  void onEvent(Event event) {
    logEvent(event);
    super.onEvent(event);
  }

  @override
  void onChange(Change<State> change) {
    logState(change);
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    handleError(error, stackTrace);
    super.onError(error, stackTrace);
  }

  // ================================
  // 🔧 ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ
  // ================================

  /// Логирует получение события
  ///
  /// Пример использования:
  /// ```dart
  /// // Автоматически вызывается при получении события
  /// ```
  void logEvent(Event event) {
    Log.bloc(runtimeType.toString(), '📥 $event');
  }

  /// Логирует изменение состояния
  ///
  /// Пример использования:
  /// ```dart
  /// // Автоматически вызывается при изменении состояния
  /// ```
  void logState(Change<State> change) {
    Log.bloc(
      runtimeType.toString(),
      '📤 ${change.currentState} → ${change.nextState}',
      state: 'Изменение состояния',
    );
  }

  /// Обрабатывает ошибки в BLoC
  ///
  /// Параметры:
  /// - [error] - пойманная ошибка
  /// - [stackTrace] - стек вызовов
  ///
  /// Пример использования:
  /// ```dart
  /// // Автоматически вызывается при возникновении ошибки
  /// ```
  void handleError(Object error, StackTrace stackTrace) {
    if (error is Failure) {
      Log.e(
        'Ошибка в $runtimeType: ${error.userMessage}',
        error: error,
        stackTrace: stackTrace,
      );
    } else {
      Log.e(
        'Неизвестная ошибка в $runtimeType',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Освобождает ресурсы BLoC
  ///
  /// Пример использования:
  /// ```dart
  /// @override
  /// void dispose() {
  ///   userBloc.close();
  ///   super.dispose();
  /// }
  /// ```
  @override
  Future<void> close() {
    Log.i('🎛️ BLoC $runtimeType закрыт');
    return super.close();
  }

  // ================================
  // ⚡ УТИЛИТНЫЕ МЕТОДЫ
  // ================================

  /// Создает поток состояния с обработкой ошибок
  ///
  /// Параметры:
  /// - [action] - асинхронное действие для выполнения
  /// - [onSuccess] - колбэк при успешном выполнении
  /// - [onError] - колбэк при ошибке
  ///
  /// Возвращает [Stream] с состояниями
  ///
  /// Пример использования:
  /// ```dart
  /// Stream<UserState> _loadUser(String userId) async* {
  ///   yield* executeWithErrorHandling(
  ///     () => userRepository.getById(userId),
  ///     onSuccess: (user) => UserState.loaded(user),
  ///     onError: (failure) => UserState.error(failure),
  ///   );
  /// }
  /// ```
  Stream<State> executeWithErrorHandling<T>(
    Future<T> Function() action, {
    required State Function(T data) onSuccess,
    required State Function(Failure failure) onError,
  }) async* {
    try {
      final result = await action();
      yield onSuccess(result);
    } catch (e, s) {
      final failure = _convertToFailure(e, s);
      yield onError(failure);
    }
  }

  /// Обновляет состояние с индикатором загрузки
  ///
  /// Параметры:
  /// - [action] - асинхронное действие
  /// - [updateLoading] - функция обновления состояния загрузки
  ///
  /// Возвращает [Stream] с состояниями
  ///
  /// Пример использования:
  /// ```dart
  /// Stream<UserState> _loadUser(String userId) async* {
  ///   yield* withLoading(
  ///     () => userRepository.getById(userId),
  ///     updateLoading: (isLoading) => state.copyWith(isLoading: isLoading),
  ///   );
  /// }
  /// ```
  Stream<State> withLoading(
    Future<void> Function() action, {
    required State Function(bool isLoading) updateLoading,
  }) async* {
    yield updateLoading(true);
    try {
      await action();
    } finally {
      yield updateLoading(false);
    }
  }

  /// Преобразует исключение в [Failure]
  Failure _convertToFailure(Object error, StackTrace stackTrace) {
    if (error is Failure) {
      return error;
    } else {
      return Failure.unknown(message: error.toString());
    }
  }
}
