// ================================
// ⚡ BASE EVENT
// ================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_event.freezed.dart';

/// Базовый класс для всех событий BLoC
///
/// СОДЕРЖАНИЕ КЛАССА:
///
/// 🎯 ОСНОВНЫЕ СОБЫТИЯ:
/// - [initial] - инициализация
/// - [load] - загрузка данных
/// - [refresh] - обновление данных
/// - [reset] - сброс состояния
///
/// 🔧 УТИЛИТНЫЕ МЕТОДЫ:
/// - [isInitial] - проверка инициализации
/// - [isLoad] - проверка загрузки
/// - [isRefresh] - проверка обновления
/// - [isReset] - проверка сброса
///
/// 📝 ПАРАМЕТРЫ ТИПА:
/// - [T] - тип данных события (опционально)
///
/// Пример использования:
/// ```dart
/// @freezed
/// class UserEvent with _$UserEvent, BaseEvent {
///   const factory UserEvent.initial() = _Initial;
///   const factory UserEvent.load() = _Load;
///   const factory UserEvent.refresh() = _Refresh;
///   const factory UserEvent.reset() = _Reset;
///   const factory UserEvent.loadUser(String userId) = _LoadUser;
///   const factory UserEvent.updateUser(User user) = _UpdateUser;
/// }
/// ```

@freezed
abstract class BaseEvent with _$BaseEvent {
  const BaseEvent._();

  // ================================
  // 🏗️ БАЗОВЫЕ СОБЫТИЯ
  // ================================

  /// Инициализация BLoC
  const factory BaseEvent.initial() = _Initial;

  /// Загрузка данных
  const factory BaseEvent.load() = _Load;

  /// Обновление данных
  const factory BaseEvent.refresh() = _Refresh;

  /// Сброс состояния
  const factory BaseEvent.reset() = _Reset;

  // ================================
  // 🔧 GETTERS И СВОЙСТВА
  // ================================

  /// Проверяет является ли событие инициализацией
  bool get isInitial => this is _Initial;

  /// Проверяет является ли событие загрузкой
  bool get isLoad => this is _Load;

  /// Проверяет является ли событие обновлением
  bool get isRefresh => this is _Refresh;

  /// Проверяет является ли событие сбросом
  bool get isReset => this is _Reset;

  /// Проверяет является ли событие базовым (не кастомным)
  bool get isBaseEvent => isInitial || isLoad || isRefresh || isReset;

  // ================================
  // ⚡ УТИЛИТНЫЕ МЕТОДЫ
  // ================================

  /// Преобразует событие в строку для логирования
  String toLogString() {
    return map(
      initial: (_) => '🚀 Initial',
      load: (_) => '📥 Load',
      refresh: (_) => '🔄 Refresh',
      reset: (_) => '🔄 Reset',
    );
  }

  /// Создает копию события (для Freezed автоматически)
  BaseEvent get copy => map(
    initial: (_) => const BaseEvent.initial(),
    load: (_) => const BaseEvent.load(),
    refresh: (_) => const BaseEvent.refresh(),
    reset: (_) => const BaseEvent.reset(),
  );
}

/// Миксин для добавления базовых событий к кастомным
mixin BaseEventMixin {
  /// Создает событие инициализации
  BaseEvent get initial => const BaseEvent.initial();

  /// Создает событие загрузки
  BaseEvent get load => const BaseEvent.load();

  /// Создает событие обновления
  BaseEvent get refresh => const BaseEvent.refresh();

  /// Создает событие сброса
  BaseEvent get reset => const BaseEvent.reset();
}

/// Расширение для работы с событиями
extension BaseEventExtensions on BaseEvent {
  /// Проверяет нужно ли загружать данные
  bool get shouldLoadData => isLoad || isRefresh || isInitial;

  /// Проверяет нужно ли сбрасывать состояние
  bool get shouldResetState => isReset;

  /// Проверяет нужно ли показывать индикатор загрузки
  bool get shouldShowLoading => isLoad || isRefresh;

  /// Возвращает тип события для аналитики
  String get analyticsType {
    return map(
      initial: (_) => 'initial',
      load: (_) => 'load',
      refresh: (_) => 'refresh',
      reset: (_) => 'reset',
    );
  }
}
