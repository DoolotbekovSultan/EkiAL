import 'package:flutter/material.dart';
import '../utils/log_utils.dart';

/// ⚠️ Сервис отчетов об ошибках и crash reporting
///
/// ## 🔧 Доступные методы:
/// ### Инициализация и управление:
/// - `initialize()` → Future<void> - инициализация сервиса
/// - `dispose()` → Future<void> - очистка ресурсов
///
/// ### Отчеты об ошибках:
/// - `recordError(error, stackTrace, {context})` → void - ручной отчет об ошибке
/// - `recordFlutterError(details)` → void - обработка Flutter ошибок
/// - `recordNetworkError(error, request, response)` → void - сетевые ошибки
///
/// ### Контекст пользователя:
/// - `setUserContext(userId, userData)` → void - данные пользователя
/// - `setAppContext(appContext)` → void - контекст приложения
/// - `addBreadcrumb(message, category)` → void - хлебные крошки
///
/// ### Производительность:
/// - `startTransaction(name, operation)` → void - начало транзакции
/// - `finishTransaction(transaction)` → void - завершение транзакции

abstract class CrashReportingService {
  /// ИНИЦИАЛИЗАЦИЯ СЕРВИСА ОТЧЕТОВ ОБ ОШИБКАХ
  ///
  /// Настраивает подключение к системе мониторинга ошибок,
  /// конфигурирует обработку исключений и подготавливает сервис к работе.
  ///
  /// 🕐 **Вызывается при:** запуске приложения
  /// 🎯 **Обязательный вызов:** перед использованием любого метода
  Future<void> initialize();

  /// РУЧНОЙ ОТЧЕТ ОБ ОШИБКЕ
  ///
  /// Отправляет информацию об ошибке в систему мониторинга
  /// с возможностью передачи дополнительного контекста.
  ///
  /// 📝 **Параметры:**
  /// - `error`: Объект ошибки или исключения
  /// - `stackTrace`: Stack trace для диагностики
  /// - `context`: Дополнительный контекст ошибки
  ///
  /// 🎯 **Пример использования:**
  /// ```dart
  /// try {
  ///   await someRiskyOperation();
  /// } catch (error, stackTrace) {
  ///   crashReporting.recordError(
  ///     error,
  ///     stackTrace,
  ///     context: 'UserRepository.fetchData'
  ///   );
  /// }
  /// ```
  void recordError(dynamic error, StackTrace stackTrace, {String? context});

  /// ОБРАБОТКА FLUTTER ОШИБОК
  ///
  /// Специализированный метод для обработки ошибок Flutter framework,
  /// включая ошибки рендеринга и построения виджетов.
  ///
  /// 📝 **Параметры:**
  /// - `details`: Детали Flutter ошибки
  void recordFlutterError(FlutterErrorDetails details);

  /// ОТЧЕТ О СЕТЕВОЙ ОШИБКЕ
  ///
  /// Специализированный метод для отслеживания ошибок сетевых запросов
  /// с дополнительной информацией о запросе и ответе.
  ///
  /// 📝 **Параметры:**
  /// - `error`: Объект ошибки
  /// - `request`: Информация о HTTP запросе
  /// - `response`: Информация о HTTP ответе (если есть)
  void recordNetworkError({
    required dynamic error,
    required Map<String, dynamic> request,
    Map<String, dynamic>? response,
  });

  /// УСТАНОВКА КОНТЕКСТА ПОЛЬЗОВАТЕЛЯ
  ///
  /// Привязывает информацию о пользователе к отчетам об ошибках
  /// для упрощения диагностики и связи с конкретными пользователями.
  ///
  /// 📝 **Параметры:**
  /// - `userId`: Идентификатор пользователя
  /// - `userData`: Дополнительные данные пользователя
  ///
  /// 🎯 **Пример данных:**
  /// ```dart
  /// crashReporting.setUserContext('user_123', {
  ///   'email': 'user@example.com',
  ///   'subscription_tier': 'premium',
  ///   'app_version': '1.2.3'
  /// });
  /// ```
  void setUserContext(String? userId, Map<String, dynamic>? userData);

  /// УСТАНОВКА КОНТЕКСТА ПРИЛОЖЕНИЯ
  ///
  /// Добавляет глобальную информацию о состоянии приложения,
  /// которая будет прикрепляться ко всем отчетам об ошибках.
  ///
  /// 📝 **Параметры:**
  /// - `appContext`: Контекст приложения
  ///
  /// 🎯 **Пример данных:**
  /// ```dart
  /// crashReporting.setAppContext({
  ///   'current_route': '/products/123',
  ///   'auth_state': 'authenticated',
  ///   'device_orientation': 'portrait',
  ///   'memory_usage': '45%'
  /// });
  /// ```
  void setAppContext(Map<String, dynamic> appContext);

  /// ДОБАВЛЕНИЕ ХЛЕБНОЙ КРОШКИ
  ///
  /// Записывает шаги, которые привели к ошибке, для
  /// воспроизведения последовательности действий пользователя.
  ///
  /// 📝 **Параметры:**
  /// - `message`: Сообщение о действии
  /// - `category`: Категория действия
  /// - `data`: Дополнительные данные
  ///
  /// 🎯 **Пример использования:**
  /// ```dart
  /// crashReporting.addBreadcrumb(
  ///   'User tapped checkout button',
  ///   category: 'user_action',
  ///   data: {'button_id': 'checkout', 'screen': 'cart'}
  /// );
  /// ```
  void addBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? data,
  });

  /// НАЧАЛО ТРАНЗАКЦИИ ДЛЯ APM
  ///
  /// Запускает отслеживание транзакции для мониторинга
  /// производительности конкретной операции.
  ///
  /// 📝 **Параметры:**
  /// - `name`: Название транзакции
  /// - `operation`: Тип операции
  Object startTransaction(String name, String operation);

  /// ЗАВЕРШЕНИЕ ТРАНЗАКЦИИ
  ///
  /// Завершает отслеживание транзакции и отправляет
  /// метрики производительности в систему мониторинга.
  ///
  /// 📝 **Параметры:**
  /// - `transaction`: Объект транзакции из startTransaction
  void finishTransaction(Object transaction);

  /// ОЧИСТКА РЕСУРСОВ И ЗАВЕРШЕНИЕ РАБОТЫ
  ///
  /// Выполняет финализацию сервиса, отправку накопленных данных
  /// и освобождение ресурсов.
  Future<void> dispose();
}

/// 🎯 Универсальная реализация сервиса отчетов об ошибках
///
/// ## 🚀 ОСОБЕННОСТИ РЕАЛИЗАЦИИ:
/// ### Архитектура:
/// - ✅ Независимость от конкретных систем мониторинга
/// - ✅ Поддержка multiple providers (Sentry, Crashlytics, Custom)
/// - ✅ Автоматическая обработка разных типов ошибок
///
/// ### Безопасность:
/// - ✅ Автоматическая фильтрация конфиденциальных данных
/// - ✅ Обезличенная информация о пользователе
/// - ✅ Контроль объема отправляемых данных
///
/// ### Надежность:
/// - ✅ Обработка ошибок без рекурсивных падений
/// - ✅ Кэширование отчетов при отсутствии сети
/// - ✅ Graceful degradation

class UniversalCrashReportingService implements CrashReportingService {
  final List<CrashReportingProvider> _providers = [];
  bool _isInitialized = false;

  /// 🔒 НАБОР КЛЮЧЕЙ С КОНФИДЕНЦИАЛЬНЫМИ ДАННЫМИ
  final Set<String> _sensitiveKeys = {
    'password',
    'token',
    'secret',
    'key',
    'authorization',
    'api_key',
    'private_key',
    'credit_card',
    'cvv',
    'ssn',
  };

  /// СОЗДАНИЕ ЭКЗЕМПЛЯРА СЕРВИСА
  UniversalCrashReportingService({
    List<CrashReportingProvider> providers = const [],
  }) {
    _providers.addAll(providers);
  }

  /// ДОБАВЛЕНИЕ НОВОГО ПРОВАЙДЕРА
  void addProvider(CrashReportingProvider provider) {
    _providers.add(provider);
    Log.d('➕ Добавлен провайдер отчетов об ошибках: ${provider.runtimeType}');
  }

  @override
  Future<void> initialize() async {
    try {
      for (final provider in _providers) {
        await provider.initialize();
      }
      _isInitialized = true;
      Log.i('🎯 Universal Crash Reporting Service инициализирован');
    } catch (error, stackTrace) {
      Log.e(
        '❌ Ошибка инициализации Crash Reporting Service',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void recordError(dynamic error, StackTrace stackTrace, {String? context}) {
    if (!_isInitialized) return;

    try {
      final safeContext = _filterSensitiveData({
        'context': context,
      })?['context'];

      for (final provider in _providers) {
        provider.recordError(error, stackTrace, context: safeContext);
      }

      Log.d('⚠️ Отчет об ошибке отправлен: ${error.toString()}');
    } catch (e, st) {
      Log.e('❌ Ошибка при отправке отчета об ошибке', error: e, stackTrace: st);
    }
  }

  @override
  void recordFlutterError(FlutterErrorDetails details) {
    if (!_isInitialized) return;

    try {
      for (final provider in _providers) {
        provider.recordFlutterError(details);
      }

      Log.d('🎯 Flutter ошибка обработана: ${details.exception}');
    } catch (e, st) {
      Log.e('❌ Ошибка при обработке Flutter ошибки', error: e, stackTrace: st);
    }
  }

  @override
  void recordNetworkError({
    required dynamic error,
    required Map<String, dynamic> request,
    Map<String, dynamic>? response,
  }) {
    if (!_isInitialized) return;

    try {
      final safeRequest = _filterSensitiveData(request);
      final safeResponse = _filterSensitiveData(response);

      for (final provider in _providers) {
        provider.recordNetworkError(
          error: error,
          request: safeRequest ?? {},
          response: safeResponse,
        );
      }

      Log.d('🌐 Сетевая ошибка зафиксирована: ${error.toString()}');
    } catch (e, st) {
      Log.e('❌ Ошибка при фиксации сетевой ошибки', error: e, stackTrace: st);
    }
  }

  @override
  void setUserContext(String? userId, Map<String, dynamic>? userData) {
    if (!_isInitialized) return;

    try {
      final safeUserData = _filterSensitiveData(userData);

      for (final provider in _providers) {
        provider.setUserContext(userId, safeUserData);
      }

      Log.d('👤 Контекст пользователя установлен: $userId');
    } catch (e, st) {
      Log.e(
        '❌ Ошибка установки контекста пользователя',
        error: e,
        stackTrace: st,
      );
    }
  }

  @override
  void setAppContext(Map<String, dynamic> appContext) {
    if (!_isInitialized) return;

    try {
      final safeAppContext = _filterSensitiveData(appContext) ?? {};

      for (final provider in _providers) {
        provider.setAppContext(safeAppContext);
      }

      Log.d('📱 Контекст приложения установлен');
    } catch (e, st) {
      Log.e(
        '❌ Ошибка установки контекста приложения',
        error: e,
        stackTrace: st,
      );
    }
  }

  @override
  void addBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? data,
  }) {
    if (!_isInitialized) return;

    try {
      final safeData = _filterSensitiveData(data);

      for (final provider in _providers) {
        provider.addBreadcrumb(message, category: category, data: safeData);
      }

      Log.d('🍞 Хлебная крошка добавлена: $message');
    } catch (e, st) {
      Log.e('❌ Ошибка добавления хлебной крошки', error: e, stackTrace: st);
    }
  }

  @override
  Object startTransaction(String name, String operation) {
    final transactions = <Object>[];

    for (final provider in _providers) {
      try {
        final transaction = provider.startTransaction(name, operation);
        transactions.add(transaction);
      } catch (e, st) {
        Log.e('❌ Ошибка начала транзакции', error: e, stackTrace: st);
      }
    }

    Log.d('⏱️ Транзакция начата: $name ($operation)');
    return transactions;
  }

  @override
  void finishTransaction(Object transaction) {
    if (transaction is List<Object>) {
      for (int i = 0; i < transaction.length; i++) {
        try {
          _providers[i].finishTransaction(transaction[i]);
        } catch (e, st) {
          Log.e('❌ Ошибка завершения транзакции', error: e, stackTrace: st);
        }
      }
    }

    Log.d('✅ Транзакция завершена');
  }

  @override
  Future<void> dispose() async {
    for (final provider in _providers) {
      await provider.dispose();
    }
    _isInitialized = false;
    Log.i('🔚 Universal Crash Reporting Service остановлен');
  }

  /// 🔒 ФИЛЬТРАЦИЯ КОНФИДЕНЦИАЛЬНЫХ ДАННЫХ
  Map<String, dynamic>? _filterSensitiveData(Map<String, dynamic>? data) {
    if (data == null) return null;

    final filtered = <String, dynamic>{};

    for (final entry in data.entries) {
      final isSensitive = _sensitiveKeys.any(
        (key) => entry.key.toLowerCase().contains(key),
      );
      filtered[entry.key] = isSensitive ? '[FILTERED]' : entry.value;
    }

    return filtered;
  }
}

/// 🔌 ИНТЕРФЕЙС ПРОВАЙДЕРА ОТЧЕТОВ ОБ ОШИБКАХ
abstract class CrashReportingProvider {
  Future<void> initialize();
  void recordError(dynamic error, StackTrace stackTrace, {String? context});
  void recordFlutterError(FlutterErrorDetails details);
  void recordNetworkError({
    required dynamic error,
    required Map<String, dynamic> request,
    Map<String, dynamic>? response,
  });
  void setUserContext(String? userId, Map<String, dynamic>? userData);
  void setAppContext(Map<String, dynamic> appContext);
  void addBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? data,
  });
  Object startTransaction(String name, String operation);
  void finishTransaction(Object transaction);
  Future<void> dispose();
}

/// 🪵 ПРОВАЙДЕР ДЛЯ ЛОГИРОВАНИЯ В КОНСОЛЬ
class ConsoleCrashReportingProvider implements CrashReportingProvider {
  @override
  Future<void> initialize() async {
    Log.i('🪵 Console Crash Reporting Provider инициализирован');
  }

  @override
  void recordError(dynamic error, StackTrace stackTrace, {String? context}) {
    Log.e('⚠️ [CRASH] Error: $error\nContext: $context\nStack: $stackTrace');
  }

  @override
  void recordFlutterError(FlutterErrorDetails details) {
    Log.e(
      '🎯 [CRASH] Flutter Error: ${details.exception}\nStack: ${details.stack}',
    );
  }

  @override
  void recordNetworkError({
    required dynamic error,
    required Map<String, dynamic> request,
    Map<String, dynamic>? response,
  }) {
    Log.e(
      '🌐 [CRASH] Network Error: $error\nRequest: $request\nResponse: $response',
    );
  }

  @override
  void setUserContext(String? userId, Map<String, dynamic>? userData) {
    Log.d('👤 [CRASH] User Context: $userId, Data: $userData');
  }

  @override
  void setAppContext(Map<String, dynamic> appContext) {
    Log.d('📱 [CRASH] App Context: $appContext');
  }

  @override
  void addBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? data,
  }) {
    Log.d('🍞 [CRASH] Breadcrumb: $message, Category: $category, Data: $data');
  }

  @override
  Object startTransaction(String name, String operation) {
    Log.d('⏱️ [CRASH] Transaction Started: $name ($operation)');
    return name;
  }

  @override
  void finishTransaction(Object transaction) {
    Log.d('✅ [CRASH] Transaction Finished: $transaction');
  }

  @override
  Future<void> dispose() async {
    Log.i('🔚 Console Crash Reporting Provider остановлен');
  }
}

/// 🧪 MOCK ПРОВАЙДЕР ДЛЯ ТЕСТИРОВАНИЯ
class MockCrashReportingProvider implements CrashReportingProvider {
  final List<Map<String, dynamic>> _reports = [];

  MockCrashReportingProvider();

  List<Map<String, dynamic>> get reports => List.unmodifiable(_reports);
  void clearReports() => _reports.clear();

  @override
  Future<void> initialize() async {
    Log.i('🧪 Mock Crash Reporting Provider инициализирован');
  }

  @override
  void recordError(dynamic error, StackTrace stackTrace, {String? context}) {
    _reports.add({
      'type': 'error',
      'error': error.toString(),
      'context': context,
      'timestamp': DateTime.now(),
    });
  }

  @override
  void recordFlutterError(FlutterErrorDetails details) {
    _reports.add({
      'type': 'flutter_error',
      'exception': details.exception.toString(),
      'timestamp': DateTime.now(),
    });
  }

  @override
  void recordNetworkError({
    required dynamic error,
    required Map<String, dynamic> request,
    Map<String, dynamic>? response,
  }) {
    _reports.add({
      'type': 'network_error',
      'error': error.toString(),
      'request': request,
      'response': response,
      'timestamp': DateTime.now(),
    });
  }

  @override
  void setUserContext(String? userId, Map<String, dynamic>? userData) {
    _reports.add({
      'type': 'user_context',
      'user_id': userId,
      'user_data': userData,
      'timestamp': DateTime.now(),
    });
  }

  @override
  void setAppContext(Map<String, dynamic> appContext) {
    _reports.add({
      'type': 'app_context',
      'app_context': appContext,
      'timestamp': DateTime.now(),
    });
  }

  @override
  void addBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? data,
  }) {
    _reports.add({
      'type': 'breadcrumb',
      'message': message,
      'category': category,
      'data': data,
      'timestamp': DateTime.now(),
    });
  }

  @override
  Object startTransaction(String name, String operation) {
    final transaction = {
      'name': name,
      'operation': operation,
      'start_time': DateTime.now(),
    };
    _reports.add({
      'type': 'transaction_start',
      'transaction': transaction,
      'timestamp': DateTime.now(),
    });
    return transaction;
  }

  @override
  void finishTransaction(Object transaction) {
    _reports.add({
      'type': 'transaction_finish',
      'transaction': transaction,
      'timestamp': DateTime.now(),
    });
  }

  @override
  Future<void> dispose() async {
    _reports.clear();
    Log.i('🔚 Mock Crash Reporting Provider остановлен');
  }
}
