// ================================
// ⏰ DEBOUNCER
// ================================

import 'dart:async';

/// Утилита для отложенного выполнения операций (debounce)
///
/// Предотвращает частые вызовы функций путем задержки выполнения
/// до тех пор, пока не пройдет указанное время без новых вызовов.
///
/// Используется для:
/// - Поиска при вводе текста
/// - Обработки скролла и ресайза
/// - Автосохранения форм
/// - Фильтрации частых событий
///
/// Пример использования:
/// ```dart
/// final debouncer = Debouncer(milliseconds: 500);
///
/// onTextChanged(String text) {
///   debouncer.run(() {
///     performSearch(text);
///   });
/// }
/// ```
class Debouncer {
  // ================================
  // ⚙️ СВОЙСТВА И КОНСТРУКТОР
  // ================================

  final Duration duration;
  Timer? _timer;

  /// Создает Debouncer с указанной задержкой
  ///
  /// Параметры:
  /// - [milliseconds] - задержка в миллисекундах (по умолчанию 500)
  /// - [seconds] - задержка в секундах
  /// - [duration] - объект Duration для точной настройки
  ///
  /// Примеры создания:
  /// ```dart
  /// final debouncer1 = Debouncer(milliseconds: 300);
  /// final debouncer2 = Debouncer(seconds: 1);
  /// final debouncer3 = Debouncer(duration: Duration(milliseconds: 200));
  /// ```
  Debouncer({int milliseconds = 500, int? seconds, Duration? duration})
    : duration =
          duration ??
          (seconds != null
              ? Duration(seconds: seconds)
              : Duration(milliseconds: milliseconds));

  // ================================
  // 🎯 ОСНОВНЫЕ МЕТОДЫ
  // ================================

  /// Выполняет функцию после завершения задержки
  ///
  /// Если метод вызывается повторно до истечения задержки,
  /// предыдущий таймер сбрасывается и начинается новый отсчет.
  ///
  /// Пример использования:
  /// ```dart
  /// debouncer.run(() {
  ///   print('Выполнено после задержки');
  /// });
  /// ```
  void run(void Function() action) {
    _cancel();
    _timer = Timer(duration, action);
  }

  /// Выполняет асинхронную функцию после завершения задержки
  ///
  /// Возвращает Future, который завершится после выполнения функции.
  ///
  /// Пример использования:
  /// ```dart
  /// final result = await debouncer.runAsync(() async {
  ///   return await fetchData();
  /// });
  /// ```
  Future<T> runAsync<T>(Future<T> Function() action) async {
    _cancel();

    final completer = Completer<T>();

    _timer = Timer(duration, () async {
      try {
        final result = await action();
        if (!completer.isCompleted) {
          completer.complete(result);
        }
      } catch (error, stackTrace) {
        if (!completer.isCompleted) {
          completer.completeError(error, stackTrace);
        }
      }
    });

    return completer.future;
  }

  /// Немедленно выполняет функцию без задержки
  ///
  /// Отменяет текущий ожидающий таймер и сразу выполняет действие.
  ///
  /// Пример использования:
  /// ```dart
  /// // При принудительном сохранении
  /// debouncer.runImmediately(() {
  ///   saveForm();
  /// });
  /// ```
  void runImmediately(void Function() action) {
    _cancel();
    action();
  }

  // ================================
  // ⚡ РАСШИРЕННЫЕ ВОЗМОЖНОСТИ
  // ================================

  /// Выполняет функцию с накоплением параметров
  ///
  /// При многократном вызове с разными параметрами,
  /// выполняется один раз с последним переданным параметром.
  ///
  /// Пример использования:
  /// ```dart
  /// final debouncer = Debouncer(milliseconds: 300);
  /// String lastQuery = '';
  ///
  /// onSearchChanged(String query) {
  ///   lastQuery = query;
  ///   debouncer.runWithLastParam(() {
  ///     search(lastQuery);
  ///   });
  /// }
  /// ```
  void runWithLastParam(void Function() action) {
    _cancel();
    _timer = Timer(duration, action);
  }

  /// Выполняет функцию с агрегацией вызовов
  ///
  /// Собирает все вызовы в течение задержки и выполняет
  /// функцию один раз с количеством пропущенных вызовов.
  ///
  /// Пример использования:
  /// ```dart
  /// final debouncer = Debouncer(milliseconds: 100);
  /// int callCount = 0;
  ///
  /// onScroll() {
  ///   debouncer.runAggregated((skippedCalls) {
  ///     print('Выполнено после $skippedCalls пропущенных вызовов');
  ///     callCount = 0;
  ///   });
  ///   callCount++;
  /// }
  /// ```
  void runAggregated(void Function(int skippedCalls) action) {
    _callCount++;
    _cancel();

    _timer = Timer(duration, () {
      final skipped = _callCount - 1;
      _callCount = 0;
      action(skipped);
    });
  }

  int _callCount = 0;

  // ================================
  // 🛑 УПРАВЛЕНИЕ СОСТОЯНИЕМ
  // ================================

  /// Отменяет текущий ожидающий вызов
  ///
  /// Пример использования:
  /// ```dart
  /// // При размонтировании виджета
  /// @override
  /// void dispose() {
  ///   debouncer.cancel();
  ///   super.dispose();
  /// }
  /// ```
  void cancel() {
    _cancel();
  }

  /// Проверяет есть ли ожидающий вызов
  bool get isPending => _timer?.isActive ?? false;

  /// Возвращает оставшееся время до выполнения
  Duration? get remaining {
    if (_timer?.isActive ?? false) {
      return duration - _elapsedTime;
    }
    return null;
  }

  Duration get _elapsedTime {
    if (_timer == null) return Duration.zero;

    // Таймер не предоставляет время напрямую, поэтому оцениваем
    // что прошло примерно 0 времени при активном таймере
    return _timer!.isActive ? Duration.zero : duration;
  }

  // ================================
  // 🔧 ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ
  // ================================

  void _cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Освобождает ресурсы
  void dispose() {
    _cancel();
  }
}

// ================================
// 🎯 THROTTLER
// ================================

/// Утилита для ограничения частоты вызовов (throttle)
///
/// Гарантирует что функция не будет вызываться чаще,
/// чем указанный интервал времени.
///
/// Используется для:
/// - Обработки непрерывных событий (скролл, drag)
/// - Предотвращения спама в UI
/// - Ограничения API запросов
class Throttler {
  final Duration duration;
  Timer? _timer;
  DateTime? _lastRun;

  /// Создает Throttler с указанным интервалом
  Throttler({int milliseconds = 500, int? seconds, Duration? duration})
    : duration =
          duration ??
          (seconds != null
              ? Duration(seconds: seconds)
              : Duration(milliseconds: milliseconds));

  /// Выполняет функцию с ограничением частоты
  ///
  /// Если с последнего выполнения прошло меньше времени чем [duration],
  /// вызов игнорируется.
  ///
  /// Пример использования:
  /// ```dart
  /// final throttler = Throttler(milliseconds: 100);
  ///
  /// onScroll() {
  ///   throttler.run(() {
  ///     updateScrollPosition();
  ///   });
  /// }
  /// ```
  void run(void Function() action) {
    final now = DateTime.now();

    if (_lastRun == null || now.difference(_lastRun!) >= duration) {
      _lastRun = now;
      action();
    }
  }

  /// Выполняет асинхронную функцию с ограничением частоты
  Future<T> runAsync<T>(Future<T> Function() action) async {
    final now = DateTime.now();

    if (_lastRun == null || now.difference(_lastRun!) >= duration) {
      _lastRun = now;
      return await action();
    }

    // Возвращаем Future который никогда не завершится
    // или можно выбросить исключение в зависимости от use case
    return Future<T>.value() as T;
  }

  /// Сбрасывает историю вызовов
  void reset() {
    _lastRun = null;
    _timer?.cancel();
    _timer = null;
  }

  /// Освобождает ресурсы
  void dispose() {
    _timer?.cancel();
  }
}

// ================================
// 🔄 RETRY HELPER
// ================================

/// Утилита для повторных попыток выполнения с экспоненциальной задержкой
class RetryHelper {
  final int maxRetries;
  final Duration initialDelay;
  final double backoffFactor;

  RetryHelper({
    this.maxRetries = 3,
    this.initialDelay = const Duration(seconds: 1),
    this.backoffFactor = 2.0,
  });

  /// Выполняет функцию с повторными попытками при ошибках
  ///
  /// Пример использования:
  /// ```dart
  /// final result = await RetryHelper().executeWithRetry(
  ///   () => api.call(),
  ///   retryIf: (error) => error is NetworkError,
  /// );
  /// ```
  Future<T> executeWithRetry<T>(
    Future<T> Function() action, {
    bool Function(dynamic error)? retryIf,
  }) async {
    int attempt = 0;

    while (true) {
      try {
        return await action();
      } catch (error) {
        attempt++;

        if (attempt > maxRetries || (retryIf != null && !retryIf(error))) {
          rethrow;
        }

        final delay = _calculateDelay(attempt);
        await Future.delayed(delay);
      }
    }
  }

  Duration _calculateDelay(int attempt) {
    return Duration(
      milliseconds:
          (initialDelay.inMilliseconds * pow(backoffFactor, attempt - 1))
              .round(),
    );
  }
}

// Вспомогательная функция для степени
num pow(num x, num exponent) {
  return x.pow(exponent.toInt());
}

extension NumPow on num {
  num pow(int exponent) {
    var result = 1.0;
    for (var i = 0; i < exponent; i++) {
      result *= this;
    }
    return result;
  }
}
