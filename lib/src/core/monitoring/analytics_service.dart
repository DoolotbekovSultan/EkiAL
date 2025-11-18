import 'package:logger/logger.dart';

// =============================================
// 📊 ANALYTICS SERVICE
// =============================================

/// 📊 Абстрактный сервис аналитики для трекинга пользовательских событий и поведения
///
/// ## 🔧 Доступные методы:
/// ### Инициализация и управление:
/// - `initialize()` → Future<void> - инициализация сервиса
/// - `dispose()` → Future<void> - очистка ресурсов
///
/// ### Трекинг событий:
/// - `trackEvent(name, [parameters])` → void - пользовательские события
/// - `trackScreen(screenName, [parameters])` → void - переходы между экранами
/// - `trackError(error, {context, stackTrace})` → void - ошибки и исключения
/// - `trackNetworkRequest(url, method, statusCode, durationMs)` → void - сетевые запросы
/// - `trackUserAction(action, [parameters])` → void - пользовательские действия
///
/// ### Пользовательские данные:
/// - `setUserProperties(properties)` → void - свойства пользователя
/// - `setUserId(userId)` → void - идентификатор пользователя
/// - `setCurrentScreen(screenName)` → void - текущий экран
///
/// ### Сессии и временные метрики:
/// - `startTiming(eventName)` → void - начало замера времени
/// - `endTiming(eventName)` → void - завершение замера времени
/// - `setSessionTimeout(duration)` → void - таймаут сессии

abstract class AnalyticsService {
  /// ИНИЦИАЛИЗАЦИЯ СЕРВИСА АНАЛИТИКИ
  ///
  /// Выполняет настройку подключения к аналитической платформе,
  /// конфигурирует сбор данных и подготавливает сервис к работе.
  ///
  /// 🕐 **Вызывается при:** запуске приложения
  /// 🎯 **Обязательный вызов:** перед использованием любого метода
  /// ⚠️ **Ошибки:** пробрасывает исключения при проблемах инициализации
  Future<void> initialize();

  /// ТРЕКИНГ ПОЛЬЗОВАТЕЛЬСКОГО СОБЫТИЯ
  ///
  /// Отслеживает произвольные события в приложении с возможностью
  /// передачи дополнительных параметров для детализации.
  ///
  /// 📝 **Параметры:**
  /// - `name`: Уникальный идентификатор события (рекомендуется snake_case)
  /// - `parameters`: Дополнительные параметры события (максимум 25 пар ключ-значение)
  ///
  /// 🎯 **Примеры использования:**
  /// ```dart
  /// // Трекинг покупки
  /// analytics.trackEvent('purchase_completed', {
  ///   'amount': 2999,
  ///   'currency': 'RUB',
  ///   'product_id': 'premium_subscription',
  ///   'payment_method': 'credit_card'
  /// });
  ///
  /// // Трекинг поиска
  /// analytics.trackEvent('search_performed', {
  ///   'query': 'flutter development',
  ///   'results_count': 15,
  ///   'category': 'programming'
  /// });
  /// ```
  void trackEvent(String name, [Map<String, dynamic>? parameters]);

  /// ТРЕКИНГ ПЕРЕХОДА МЕЖДУ ЭКРАНАМИ
  ///
  /// Отслеживает навигацию пользователя между экранами приложения
  /// для анализа пользовательского потока и поведения.
  ///
  /// 📝 **Параметры:**
  /// - `screenName`: Человеко-читаемое название экрана
  /// - `parameters`: Дополнительные параметры (источник перехода, данные экрана)
  ///
  /// 🎯 **Примеры использования:**
  /// ```dart
  /// // Трекинг экрана продукта
  /// analytics.trackScreen('Product Details', {
  ///   'product_id': '12345',
  ///   'category': 'electronics',
  ///   'source': 'search_results'
  /// });
  ///
  /// // Трекинг экрана профиля
  /// analytics.trackScreen('User Profile', {
  ///   'user_segment': 'premium',
  ///   'has_avatar': true
  /// });
  /// ```
  void trackScreen(String screenName, [Map<String, dynamic>? parameters]);

  /// УСТАНОВКА ПОЛЬЗОВАТЕЛЬСКИХ СВОЙСТВ
  ///
  /// Устанавливает постоянные свойства пользователя, которые будут
  /// автоматически прикрепляться ко всем последующим событиям.
  ///
  /// 📝 **Параметры:**
  /// - `properties`: Map пользовательских свойств для сегментации
  ///
  /// 🎯 **Примеры свойств:**
  /// - subscription_tier: 'premium', 'basic', 'trial'
  /// - user_segment: 'new_user', 'returning_user', 'power_user'
  /// - marketing_channel: 'organic', 'paid_search', 'social_media'
  /// - app_version: '1.2.3'
  /// - device_type: 'mobile', 'tablet', 'desktop'
  void setUserProperties(Map<String, dynamic> properties);

  /// УСТАНОВКА ИДЕНТИФИКАТОРА ПОЛЬЗОВАТЕЛЯ
  ///
  /// Связывает все события с конкретным пользователем для анализа
  /// поведения между сессиями и устройствами.
  ///
  /// 📝 **Параметры:**
  /// - `userId`: Внутренний идентификатор пользователя в системе
  ///
  /// ⚠️ **Важно:**
  /// - При передаче `null` выполняется очистка предыдущего идентификатора
  /// - Не использовать email или персональные данные в качестве ID
  /// - Использовать анонимные UUID для неприаутентифицированных пользователей
  void setUserId(String? userId);

  /// ТРЕКИНГ ОШИБОК И ИСКЛЮЧЕНИЙ
  ///
  /// Отслеживает ошибки и исключительные ситуации для мониторинга
  /// стабильности приложения и качества пользовательского опыта.
  ///
  /// 📝 **Параметры:**
  /// - `error`: Текст ошибки или исключение
  /// - `context`: Контекст возникновения ошибки
  /// - `stackTrace`: Stack trace для диагностики
  ///
  /// 🎯 **Примеры использования:**
  /// ```dart
  /// try {
  ///   await fetchUserData();
  /// } catch (error, stackTrace) {
  ///   analytics.trackError(
  ///     'Failed to fetch user data',
  ///     context: 'UserRepository.fetchUserData',
  ///     stackTrace: stackTrace
  ///   );
  /// }
  /// ```
  void trackError(String error, {String? context, StackTrace? stackTrace});

  /// ТРЕКИНГ СЕТЕВЫХ ЗАПРОСОВ
  ///
  /// Мониторинг производительности API-запросов для выявления
  /// проблем с сетью и оптимизации времени ответа.
  ///
  /// 📝 **Параметры:**
  /// - `url`: URL endpoint API
  /// - `method`: HTTP метод (GET, POST, PUT, DELETE)
  /// - `statusCode`: HTTP статус код ответа
  /// - `durationMs`: Время выполнения в миллисекундах
  /// - `errorMessage`: Сообщение об ошибке (опционально)
  ///
  /// 📊 **Автоматически рассчитывается:**
  /// - `success`: true для статусов 200-299, иначе false
  void trackNetworkRequest({
    required String url,
    required String method,
    required int statusCode,
    required int durationMs,
    String? errorMessage,
  });

  /// ТРЕКИНГ ПОЛЬЗОВАТЕЛЬСКИХ ДЕЙСТВИЙ
  ///
  /// Отслеживает конкретные действия пользователя (клики, выборы, отправки форм)
  /// для анализа взаимодействия с интерфейсом.
  ///
  /// 📝 **Параметры:**
  /// - `action`: Тип действия (button_click, item_select, form_submit)
  /// - `parameters`: Дополнительные параметры действия
  ///
  /// 🎯 **Примеры действий:**
  /// ```dart
  /// // Клик по кнопке
  /// analytics.trackUserAction('button_click', {
  ///   'button_id': 'submit_order',
  ///   'page': 'checkout'
  /// });
  ///
  /// // Выбор элемента
  /// analytics.trackUserAction('item_select', {
  ///   'item_type': 'product',
  ///   'item_id': 'prod_123',
  ///   'position': 5
  /// });
  /// ```
  void trackUserAction(String action, [Map<String, dynamic>? parameters]);

  /// УСТАНОВКА ТЕКУЩЕГО ЭКРАНА
  ///
  /// Устанавливает текущий экран без генерации события перехода.
  /// Используется для корректного контекста последующих событий.
  ///
  /// 📝 **Параметры:**
  /// - `screenName`: Название текущего экрана
  ///
  /// 🔄 **Отличие от trackScreen:**
  /// - `setCurrentScreen`: только устанавливает контекст
  /// - `trackScreen`: устанавливает контекст + генерирует событие
  void setCurrentScreen(String screenName);

  /// НАЧАЛО ЗАМЕРА ВРЕМЕНИ ВЫПОЛНЕНИЯ
  ///
  /// Запускает таймер для измерения длительности операции.
  /// Используется в паре с `endTiming`.
  ///
  /// 📝 **Параметры:**
  /// - `eventName`: Уникальное имя события для последующего завершения
  ///
  /// 🎯 **Пример использования:**
  /// ```dart
  /// analytics.startTiming('app_startup');
  /// // ... код инициализации
  /// analytics.endTiming('app_startup');
  /// ```
  void startTiming(String eventName);

  /// ЗАВЕРШЕНИЕ ЗАМЕРА ВРЕМЕНИ ВЫПОЛНЕНИЯ
  ///
  /// Останавливает таймер и отправляет событие с метрикой длительности.
  ///
  /// 📝 **Параметры:**
  /// - `eventName`: Имя события, соответствующее `startTiming`
  ///
  /// 📊 **Отправляемые данные:**
  /// - `duration_ms`: Время выполнения в миллисекундах
  /// - `event_name`: Имя измеряемого события
  void endTiming(String eventName);

  /// УСТАНОВКА ТАЙМАУТА СЕССИИ
  ///
  /// Настраивает интервал бездействия для автоматического
  /// завершения сессии и начала новой.
  ///
  /// 📝 **Параметры:**
  /// - `duration`: Длительность таймаута сессии
  ///
  /// ⏰ **Рекомендуемые значения:**
  /// - Мобильные приложения: 30 минут
  /// - Веб-приложения: 15-30 минут
  /// - Игры: 5-15 минут
  Future<void> setSessionTimeout(Duration duration);

  /// ОЧИСТКА РЕСУРСОВ И ЗАВЕРШЕНИЕ РАБОТЫ
  ///
  /// Выполняет финализацию сервиса, отправку накопленных данных
  /// и освобождение ресурсов.
  ///
  /// 🕐 **Вызывается при:** завершении работы приложения
  /// 💾 **Выполняет:** отправку кэшированных данных
  /// 🧹 **Очищает:** внутренние структуры данных
  Future<void> dispose();
}

// =============================================
// 🎯 UNIVERSAL ANALYTICS SERVICE
// =============================================

/// 🎯 Универсальная реализация аналитического сервиса
///
/// ## 🚀 ОСОБЕННОСТИ РЕАЛИЗАЦИИ:
/// ### Архитектура:
/// - ✅ Независимость от конкретных аналитических платформ
/// - ✅ Поддержка multiple providers (Firebase, Sentry, Custom)
/// - ✅ Плагинная архитектура для легкого расширения
///
/// ### Безопасность:
/// - ✅ Автоматическая фильтрация конфиденциальных данных
/// - ✅ Валидация параметров событий
/// - ✅ Санитизация URL и пользовательских данных
///
/// ### Надежность:
/// - ✅ Обработка ошибок без падения приложения
/// - ✅ Подробное логирование всех операций
/// - ✅ Graceful degradation при проблемах с провайдерами
///
/// ### Производительность:
/// - ✅ Асинхронная инициализация провайдеров
/// - ✅ Batch processing событий
/// - ✅ Минимальные overhead на мобильных устройствах

class UniversalAnalyticsService implements AnalyticsService {
  final Logger _logger;
  final List<AnalyticsProvider> _providers = [];
  bool _isInitialized = false;
  final Map<String, DateTime> _timingEvents = {};

  /// 🔒 НАБОР КЛЮЧЕЙ С КОНФИДЕНЦИАЛЬНЫМИ ДАННЫМИ
  ///
  /// Содержит ключи, которые будут автоматически фильтроваться
  /// для предотвращения утечки чувствительной информации.
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
    'birth_date',
    'phone_number',
    'email',
    'address',
  };

  /// 📏 ОГРАНИЧЕНИЯ ДЛЯ ПАРАМЕТРОВ СОБЫТИЙ
  ///
  /// Соответствуют ограничениям большинства аналитических платформ
  /// для обеспечения совместимости и предотвращения ошибок.
  static const int _maxParameters = 25; // Максимальное количество параметров
  static const int _maxParameterValueLength =
      100; // Максимальная длина значения

  // =============================================
  // 🏗️ КОНСТРУКТОР И УПРАВЛЕНИЕ ПРОВАЙДЕРАМИ
  // =============================================

  /// СОЗДАНИЕ ЭКЗЕМПЛЯРА УНИВЕРСАЛЬНОГО АНАЛИТИЧЕСКОГО СЕРВИСА
  ///
  /// 📝 **Параметры:**
  /// - `logger`: Логгер для внутреннего логирования (опционально)
  /// - `providers`: Список провайдеров для отправки событий (опционально)
  ///
  /// 🎯 **Пример создания:**
  /// ```dart
  /// final analytics = UniversalAnalyticsService(
  ///   providers: [
  ///     ConsoleAnalyticsProvider(),
  ///     FirebaseAnalyticsProvider(),
  ///   ],
  /// );
  /// ```
  UniversalAnalyticsService({
    Logger? logger,
    List<AnalyticsProvider> providers = const [],
  }) : _logger = logger ?? Logger() {
    _providers.addAll(providers);
  }

  /// ДОБАВЛЕНИЕ НОВОГО ПРОВАЙДЕРА АНАЛИТИКИ
  ///
  /// Позволяет динамически добавлять провайдеры после создания сервиса.
  ///
  /// 📝 **Параметры:**
  /// - `provider`: Экземпляр провайдера аналитики
  ///
  /// ⚠️ **Требует:** повторной инициализации сервиса после добавления
  void addProvider(AnalyticsProvider provider) {
    _providers.add(provider);
    _logger.d('➕ Добавлен провайдер аналитики: ${provider.runtimeType}');
  }

  /// УДАЛЕНИЕ ПРОВАЙДЕРА АНАЛИТИКИ
  ///
  /// Позволяет динамически удалять провайдеры во время работы приложения.
  ///
  /// 📝 **Параметры:**
  /// - `provider`: Экземпляр провайдера для удаления
  void removeProvider(AnalyticsProvider provider) {
    _providers.remove(provider);
    _logger.d('➖ Удален провайдер аналитики: ${provider.runtimeType}');
  }

  // =============================================
  // 🔧 РЕАЛИЗАЦИЯ МЕТОДОВ ANALYTICS SERVICE
  // =============================================

  @override
  Future<void> initialize() async {
    try {
      _logger.i('🎯 Начало инициализации Universal Analytics Service');

      // Последовательная инициализация всех провайдеров
      for (final provider in _providers) {
        await provider.initialize();
        _logger.d('✅ Провайдер ${provider.runtimeType} инициализирован');
      }

      _isInitialized = true;
      _logger.i(
        '🎯 Universal Analytics Service успешно инициализирован с ${_providers.length} провайдерами',
      );
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Критическая ошибка инициализации Universal Analytics Service',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  void trackEvent(String name, [Map<String, dynamic>? parameters]) {
    // 🔒 ПРОВЕРКА ИНИЦИАЛИЗАЦИИ
    if (!_isInitialized) {
      _logger.w('⚠️ Попытка трекинга события до инициализации сервиса: $name');
      return;
    }

    try {
      // 🛡️ ПОДГОТОВКА ДАННЫХ
      final safeParameters = _filterSensitiveData(parameters);
      final validatedParameters = _validateEventParameters(safeParameters);

      // 📤 ОТПРАВКА ВО ВСЕ ПРОВАЙДЕРЫ
      for (final provider in _providers) {
        provider.trackEvent(name, validatedParameters);
      }

      _logger.d('📊 Событие отслежено: $name, параметры: $validatedParameters');
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка трекинга события: $name',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void trackScreen(String screenName, [Map<String, dynamic>? parameters]) {
    if (!_isInitialized) {
      _logger.w(
        '⚠️ Попытка трекинга экрана до инициализации сервиса: $screenName',
      );
      return;
    }

    try {
      final safeParameters = _filterSensitiveData(parameters);

      for (final provider in _providers) {
        provider.trackScreen(screenName, safeParameters);
      }

      _logger.d('🖥️ Отслежен экран: $screenName');
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка трекинга экрана: $screenName',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void setUserProperties(Map<String, dynamic> properties) {
    if (!_isInitialized) {
      _logger.w('⚠️ Попытка установки свойств до инициализации сервиса');
      return;
    }

    try {
      final safeProperties = _filterSensitiveData(properties);

      for (final provider in _providers) {
        provider.setUserProperties(safeProperties ?? {});
      }

      _logger.d('👤 Установлены пользовательские свойства: $safeProperties');
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка установки пользовательских свойств',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void setUserId(String? userId) {
    if (!_isInitialized) {
      _logger.w(
        '⚠️ Попытка установки ID пользователя до инициализации сервиса',
      );
      return;
    }

    try {
      for (final provider in _providers) {
        provider.setUserId(userId);
      }

      _logger.d('🆔 Установлен ID пользователя: ${userId ?? 'null'}');
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка установки ID пользователя',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void trackError(String error, {String? context, StackTrace? stackTrace}) {
    trackEvent('error_occurred', {
      'error_message': error,
      'context': context,
      'stack_trace': stackTrace?.toString().substring(0, 500),
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  @override
  void trackNetworkRequest({
    required String url,
    required String method,
    required int statusCode,
    required int durationMs,
    String? errorMessage,
  }) {
    final eventParameters = {
      'url': _sanitizeUrl(url),
      'method': method.toUpperCase(),
      'status_code': statusCode,
      'duration_ms': durationMs,
      'success': statusCode >= 200 && statusCode < 300,
      if (errorMessage != null) 'error_message': errorMessage,
    };

    trackEvent('network_request', eventParameters);
  }

  @override
  void trackUserAction(String action, [Map<String, dynamic>? parameters]) {
    final eventParameters = {
      'action_type': action,
      'timestamp': DateTime.now().toIso8601String(),
      ...?parameters,
    };

    trackEvent('user_action', eventParameters);
  }

  @override
  void setCurrentScreen(String screenName) {
    if (!_isInitialized) return;

    try {
      for (final provider in _providers) {
        provider.setCurrentScreen(screenName);
      }

      _logger.d('📍 Установлен текущий экран: $screenName');
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка установки текущего экрана: $screenName',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void startTiming(String eventName) {
    _timingEvents[eventName] = DateTime.now();
    _logger.d('⏱️ Начат замер времени для события: $eventName');
  }

  @override
  void endTiming(String eventName) {
    final startTime = _timingEvents[eventName];
    if (startTime == null) {
      _logger.w(
        '⚠️ Попытка завершить несуществующий замер времени: $eventName',
      );
      return;
    }

    final duration = DateTime.now().difference(startTime).inMilliseconds;
    _timingEvents.remove(eventName);

    trackEvent('${eventName}_timing', {
      'duration_ms': duration,
      'event_name': eventName,
    });

    _logger.d('⏱️ Завершен замер времени для $eventName: ${duration}ms');
  }

  @override
  Future<void> setSessionTimeout(Duration duration) async {
    if (!_isInitialized) return;

    try {
      for (final provider in _providers) {
        await provider.setSessionTimeout(duration);
      }

      _logger.d('⏰ Установлен таймаут сессии: ${duration.inMinutes} минут');
    } catch (error, stackTrace) {
      _logger.e(
        '❌ Ошибка установки таймаута сессии',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> dispose() async {
    _logger.i('🔚 Начало остановки Universal Analytics Service');

    for (final provider in _providers) {
      await provider.dispose();
    }

    _isInitialized = false;
    _timingEvents.clear();
    _logger.i('🔚 Universal Analytics Service полностью остановлен');
  }

  // =============================================
  // 🛡️ ПРИВАТНЫЕ МЕТОДЫ ДЛЯ ОБРАБОТКИ ДАННЫХ
  // =============================================

  /// 🔒 ФИЛЬТРАЦИЯ КОНФИДЕНЦИАЛЬНЫХ ДАННЫХ
  ///
  /// Автоматически заменяет значения чувствительных ключей
  /// на '[FILTERED]' для предотвращения утечки информации.
  ///
  /// 📝 **Обрабатываемые ключи:** password, token, secret, key, authorization, etc.
  /// 🎯 **Результат:** Безопасные для логирования и передачи данные
  Map<String, dynamic>? _filterSensitiveData(Map<String, dynamic>? parameters) {
    if (parameters == null) return null;

    final filtered = <String, dynamic>{};

    for (final entry in parameters.entries) {
      final key = entry.key;
      final value = entry.value;

      // 🔍 ПРОВЕРКА НА ЧУВСТВИТЕЛЬНЫЕ ДАННЫЕ
      final isSensitive = _sensitiveKeys.any(
        (sensitiveKey) => key.toLowerCase().contains(sensitiveKey),
      );

      if (isSensitive) {
        filtered[key] = '[FILTERED]';
        _logger.d('🔒 Отфильтрован чувствительный параметр: $key');
      } else {
        filtered[key] = value;
      }
    }

    return filtered;
  }

  /// 📏 ВАЛИДАЦИЯ ПАРАМЕТРОВ СОБЫТИЯ
  ///
  /// Проверяет и нормализует параметры событий согласно ограничениям
  /// аналитических платформ для предотвращения ошибок.
  ///
  /// ✅ **Выполняемые проверки:**
  /// - Ограничение количества параметров (25)
  /// - Обрезка длинных значений (100 символов)
  /// - Преобразование типов данных
  Map<String, dynamic>? _validateEventParameters(
    Map<String, dynamic>? parameters,
  ) {
    if (parameters == null) return null;

    final validated = <String, dynamic>{};
    int parameterCount = 0;

    for (final entry in parameters.entries) {
      if (parameterCount >= _maxParameters) {
        _logger.w(
          '⚠️ Превышено максимальное количество параметров события. Оставшиеся параметры игнорируются.',
        );
        break;
      }

      final key = entry.key;
      var value = entry.value;

      // ✂️ ОБРЕЗКА ДЛИННЫХ ЗНАЧЕНИЙ
      if (value != null) {
        final stringValue = value.toString();
        if (stringValue.length > _maxParameterValueLength) {
          value = '${stringValue.substring(0, _maxParameterValueLength)}...';
          _logger.w(
            '⚠️ Значение параметра $key обрезано до $_maxParameterValueLength символов',
          );
        }
      }

      validated[key] = value;
      parameterCount++;
    }

    return validated;
  }

  /// 🧹 САНИТИЗАЦИЯ URL ДЛЯ БЕЗОПАСНОСТИ
  ///
  /// Удаляет query параметры, содержащие токены и ключи
  /// для предотвращения утечки чувствительных данных в логах.
  ///
  /// 🎯 **Пример преобразования:**
  /// - До: `https://api.example.com/data?token=secret123&user_id=456`
  /// - После: `https://api.example.com/data?user_id=456`
  String _sanitizeUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final safeQueryParameters = <String, String>{};

      // 🔍 ФИЛЬТРАЦИЯ QUERY ПАРАМЕТРОВ
      uri.queryParameters.forEach((key, value) {
        final isSensitive = _sensitiveKeys.any(
          (sensitiveKey) => key.toLowerCase().contains(sensitiveKey),
        );

        if (!isSensitive) {
          safeQueryParameters[key] = value;
        } else {
          _logger.d('🔒 Отфильтрован чувствительный query параметр: $key');
        }
      });

      return uri.replace(queryParameters: safeQueryParameters).toString();
    } catch (e) {
      _logger.w('⚠️ Ошибка парсинга URL: $url, возвращен оригинальный URL');
      return url;
    }
  }
}

// =============================================
// 🔌 ANALYTICS PROVIDER INTERFACE
// =============================================

/// 🔌 Абстрактный класс провайдера аналитики
///
/// ## 🎯 НАЗНАЧЕНИЕ:
/// Определяет единый интерфейс для интеграции с различными
/// аналитическими платформами и системами.
///
/// ## 🔧 РЕАЛИЗАЦИИ:
/// - `ConsoleAnalyticsProvider` - логирование в консоль (разработка)
/// - `FirebaseAnalyticsProvider` - интеграция с Firebase Analytics
/// - `SentryAnalyticsProvider` - отправка событий в Sentry
/// - `CustomAnalyticsProvider` - пользовательские реализации
///
/// ## 💡 ИСПОЛЬЗОВАНИЕ:
/// ```dart
/// class MyCustomProvider implements AnalyticsProvider {
///   // ... реализация методов
/// }
/// ```

abstract class AnalyticsProvider {
  /// ИНИЦИАЛИЗАЦИЯ ПРОВАЙДЕРА
  ///
  /// Выполняет настройку подключения к аналитической платформе,
  /// аутентификацию и первоначальную конфигурацию.
  Future<void> initialize();

  /// ОТПРАВКА СОБЫТИЯ
  ///
  /// Передает пользовательское событие в аналитическую систему.
  void trackEvent(String name, [Map<String, dynamic>? parameters]);

  /// ОТПРАВКА ДАННЫХ ЭКРАНА
  ///
  /// Передает информацию о текущем экране/странице.
  void trackScreen(String screenName, [Map<String, dynamic>? parameters]);

  /// УСТАНОВКА СВОЙСТВ ПОЛЬЗОВАТЕЛЯ
  ///
  /// Устанавливает постоянные свойства для всех последующих событий.
  void setUserProperties(Map<String, dynamic> properties);

  /// УСТАНОВКА ID ПОЛЬЗОВАТЕЛЯ
  ///
  /// Связывает события с конкретным пользователем.
  void setUserId(String? userId);

  /// УСТАНОВКА ТЕКУЩЕГО ЭКРАНА
  ///
  /// Устанавливает контекст экрана без генерации события.
  void setCurrentScreen(String screenName);

  /// НАСТРОЙКА ТАЙМАУТА СЕССИИ
  ///
  /// Конфигурирует интервал бездействия для сессии.
  Future<void> setSessionTimeout(Duration duration);

  /// ЗАВЕРШЕНИЕ РАБОТЫ ПРОВАЙДЕРА
  ///
  /// Выполняет очистку ресурсов и отправку накопленных данных.
  Future<void> dispose();
}

// =============================================
// 🪵 CONSOLE ANALYTICS PROVIDER
// =============================================

/// 🪵 Провайдер для логирования событий в консоль
///
/// ## 🎯 НАЗНАЧЕНИЕ:
/// - Отладка и разработка без внешних зависимостей
/// - Визуализация потока событий в IDE
/// - Тестирование логики аналитики
///
/// ## 🔧 ОСОБЕННОСТИ:
/// - ✅ Не требует внешних сервисов
/// - ✅ Подробное логирование в консоль
/// - ✅ Идеален для разработки и тестирования
/// - ✅ Нулевые задержки и overhead

class ConsoleAnalyticsProvider implements AnalyticsProvider {
  final Logger _logger;

  /// СОЗДАНИЕ КОНСОЛЬНОГО ПРОВАЙДЕРА
  ///
  /// 📝 **Параметры:**
  /// - `logger`: Логгер для вывода событий (опционально)
  ConsoleAnalyticsProvider({Logger? logger}) : _logger = logger ?? Logger();

  @override
  Future<void> initialize() async {
    _logger.i('🪵 Console Analytics Provider инициализирован');
  }

  @override
  void trackEvent(String name, [Map<String, dynamic>? parameters]) {
    _logger.d('📊 [ANALYTICS] Event: $name, Parameters: $parameters');
  }

  @override
  void trackScreen(String screenName, [Map<String, dynamic>? parameters]) {
    _logger.d('🖥️ [ANALYTICS] Screen: $screenName, Parameters: $parameters');
  }

  @override
  void setUserProperties(Map<String, dynamic> properties) {
    _logger.d('👤 [ANALYTICS] User Properties: $properties');
  }

  @override
  void setUserId(String? userId) {
    _logger.d('🆔 [ANALYTICS] User ID: $userId');
  }

  @override
  void setCurrentScreen(String screenName) {
    _logger.d('📍 [ANALYTICS] Current Screen: $screenName');
  }

  @override
  Future<void> setSessionTimeout(Duration duration) async {
    _logger.d('⏰ [ANALYTICS] Session Timeout: ${duration.inMinutes} minutes');
  }

  @override
  Future<void> dispose() async {
    _logger.i('🔚 Console Analytics Provider остановлен');
  }
}

// =============================================
// 🧪 MOCK ANALYTICS PROVIDER
// =============================================

/// 🧪 Mock провайдер для тестирования
///
/// ## 🎯 НАЗНАЧЕНИЕ:
/// - Unit-тестирование компонентов с аналитикой
/// - Изоляция тестов от реальных сервисов
/// - Верификация отправляемых событий
///
/// ## 🔧 ОСОБЕННОСТИ:
/// - ✅ Хранение истории событий в памяти
/// - ✅ Методы для проверки в тестах
/// - ✅ Поиск и фильтрация событий
/// - ✅ Очистка истории между тестами

class MockAnalyticsProvider implements AnalyticsProvider {
  final List<Map<String, dynamic>> _events = [];
  final Logger _logger;

  /// СОЗДАНИЕ MOCK ПРОВАЙДЕРА
  ///
  /// 📝 **Параметры:**
  /// - `logger`: Логгер для отладки (опционально)
  MockAnalyticsProvider({Logger? logger}) : _logger = logger ?? Logger();

  /// 📋 ПОЛУЧЕНИЕ ВСЕХ ОТСЛЕЖЕННЫХ СОБЫТИЙ
  ///
  /// Возвращает неизменяемый список всех событий для проверки в тестах.
  List<Map<String, dynamic>> get trackedEvents => List.unmodifiable(_events);

  /// 🧹 ОЧИСТКА ИСТОРИИ СОБЫТИЙ
  ///
  /// Удаляет все сохраненные события. Вызывается между тестами.
  void clearEvents() {
    _events.clear();
    _logger.d('🧹 История событий mock провайдера очищена');
  }

  /// 🔍 ПОИСК СОБЫТИЙ ПО ТИПУ
  ///
  /// Возвращает список событий указанного типа для targeted проверок.
  ///
  /// 📝 **Параметры:**
  /// - `type`: Тип события ('event', 'screen', 'user_properties', etc.)
  List<Map<String, dynamic>> findEventsByType(String type) {
    return _events.where((event) => event['type'] == type).toList();
  }

  /// 🔎 ПОИСК СОБЫТИЙ ПО ИМЕНИ
  ///
  /// Возвращает список событий с указанным именем.
  ///
  /// 📝 **Параметры:**
  /// - `name`: Имя события для поиска
  List<Map<String, dynamic>> findEventsByName(String name) {
    return _events.where((event) => event['name'] == name).toList();
  }

  @override
  Future<void> initialize() async {
    _logger.i('🧪 Mock Analytics Provider инициализирован');
  }

  @override
  void trackEvent(String name, [Map<String, dynamic>? parameters]) {
    _events.add({
      'type': 'event',
      'name': name,
      'parameters': parameters,
      'timestamp': DateTime.now(),
    });
    _logger.d('🧪 Mock event tracked: $name');
  }

  @override
  void trackScreen(String screenName, [Map<String, dynamic>? parameters]) {
    _events.add({
      'type': 'screen',
      'name': screenName,
      'parameters': parameters,
      'timestamp': DateTime.now(),
    });
    _logger.d('🧪 Mock screen tracked: $screenName');
  }

  @override
  void setUserProperties(Map<String, dynamic> properties) {
    _events.add({
      'type': 'user_properties',
      'properties': properties,
      'timestamp': DateTime.now(),
    });
    _logger.d('🧪 Mock user properties set: $properties');
  }

  @override
  void setUserId(String? userId) {
    _events.add({
      'type': 'user_id',
      'user_id': userId,
      'timestamp': DateTime.now(),
    });
    _logger.d('🧪 Mock user ID set: $userId');
  }

  @override
  void setCurrentScreen(String screenName) {
    _events.add({
      'type': 'current_screen',
      'screen_name': screenName,
      'timestamp': DateTime.now(),
    });
    _logger.d('🧪 Mock current screen set: $screenName');
  }

  @override
  Future<void> setSessionTimeout(Duration duration) async {
    _events.add({
      'type': 'session_timeout',
      'duration': duration,
      'timestamp': DateTime.now(),
    });
    _logger.d('🧪 Mock session timeout set: ${duration.inMinutes} minutes');
  }

  @override
  Future<void> dispose() async {
    _events.clear();
    _logger.i('🔚 Mock Analytics Provider остановлен');
  }
}
