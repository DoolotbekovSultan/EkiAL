// ================================
// 📋 API CONSTANTS - КОНСТАНТЫ СЕТЕВОГО СЛОЯ
// ================================

import '../config/app_config.dart';

/// 🎯 КОНСТАНТЫ ДЛЯ СЕТЕВЫХ ЗАПРОСОВ
///
/// ## 📖 ОПИСАНИЕ:
/// Содержит настройки для HTTP клиента, URL, таймауты, заголовки и статус коды.
/// Все значения динамически получаются из `AppConfig` для обеспечения
/// корректной работы в разных окружениях (dev, staging, prod).
///
/// ## 📁 СТРУКТУРА:
/// - Базовые настройки (baseUrl из AppConfig)
/// - Таймауты (connectTimeout, receiveTimeout, sendTimeout)
/// - Заголовки по умолчанию (defaultHeaders, multipartHeaders)
/// - Аутентификация (authHeaderKey, bearerPrefix, apiKeyHeader)
/// - Статус коды HTTP (successStatusCodes, authErrorStatusCodes, etc.)
/// - Настройки повтора запросов (maxRetryAttempts, retryDelay)
/// - Пути API (apiV1Path, authPath, usersPath, etc.)
/// - Дополнительные настройки (enableRequestLogging, maxFileSizeBytes)
///
/// ## 🎯 ИСПОЛЬЗОВАНИЕ:
/// ```dart
/// final dio = Dio(BaseOptions(
///   baseUrl: ApiConstants.baseUrl,
///   connectTimeout: ApiConstants.connectTimeout,
///   headers: ApiConstants.defaultHeaders,
/// ));
///
/// if (ApiConstants.successStatusCodes.contains(statusCode)) {
///   // обработка успешного ответа
/// }
/// ```
///
/// ## 🔗 СВЯЗАННЫЕ МОДУЛИ:
/// - `app/config/app_config.dart` - источник базового URL и настроек
/// - `core/constrants/api_endpints.dart` - использует baseUrl для эндпоинтов
/// - `core/network/dio_client.dart` - использует константы для настройки Dio
class ApiConstants {
  // ✅ Используем singleton AppConfig для единообразия
  static AppConfig get _config => AppConfig.current;

  // ================================
  // 🌐 БАЗОВЫЕ НАСТРОЙКИ
  // ================================

  /// Базовый URL зависит от активной конфигурации приложения
  static String get baseUrl => _config.baseUrl;

  // ================================
  // ⏰ ТАЙМАУТЫ
  // ================================

  /// Таймауты основаны на настройках AppConfig (указываются в миллисекундах)
  static Duration get connectTimeout =>
      Duration(milliseconds: _config.apiTimeout);

  static Duration get receiveTimeout =>
      Duration(milliseconds: _config.apiTimeout);

  static Duration get sendTimeout => Duration(milliseconds: _config.apiTimeout);

  // ================================
  // 📄 ЗАГОЛОВКИ ПО УМОЛЧАНИЮ
  // ================================

  /// Стандартные заголовки для всех запросов
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'User-Agent': 'EkiAl/1.0.0',
  };

  /// Заголовки для загрузки файлов
  static const Map<String, String> multipartHeaders = {
    'Content-Type': 'multipart/form-data',
    'Accept': 'application/json',
  };

  // ================================
  // 🔐 АУТЕНТИФИКАЦИЯ
  // ================================

  /// Ключ для токена авторизации в заголовках
  static const String authHeaderKey = 'Authorization';

  /// Префикс для Bearer токена
  static const String bearerPrefix = 'Bearer';

  /// Ключ для API ключа
  static const String apiKeyHeader = 'X-API-Key';

  // ================================
  // 📊 КОДЫ СТАТУСОВ HTTP
  // ================================

  /// Успешные статусы
  static const List<int> successStatusCodes = [200, 201, 202, 204];

  /// Статусы требующие повторной аутентификации
  static const List<int> authErrorStatusCodes = [401, 403];

  /// Статусы клиентских ошибок
  static const List<int> clientErrorStatusCodes = [400, 422];

  /// Статусы серверных ошибок
  static const List<int> serverErrorStatusCodes = [500, 502, 503];

  // ================================
  // 🔧 НАСТРОЙКИ ПОВТОРА ЗАПРОСОВ
  // ================================

  /// Максимальное количество попыток повтора
  static const int maxRetryAttempts = 3;

  /// Задержка между попытками повтора
  static const Duration retryDelay = Duration(milliseconds: 1000);

  /// Экспоненциальная задержка множитель
  static const double retryBackoffMultiplier = 2.0;

  // ================================
  // 📁 ПУТИ API
  // ================================

  /// Базовый путь для API v1
  static const String apiV1Path = '/api/v1';

  /// Путь для аутентификации
  static const String authPath = '$apiV1Path/auth';

  /// Путь для пользователей
  static const String usersPath = '$apiV1Path/users';

  /// Путь для продуктов
  static const String productsPath = '$apiV1Path/products';

  /// Путь для заказов
  static const String ordersPath = '$apiV1Path/orders';

  // ================================
  // 🛠️ ДОПОЛНИТЕЛЬНЫЕ НАСТРОЙКИ
  // ================================

  /// Включение логирования запросов/ответов (true в debug окружении)
  static bool get enableRequestLogging => _config.isDebug;

  static bool get enableResponseLogging => _config.isDebug;

  /// Максимальный размер файла для загрузки (10 MB)
  static const int maxFileSizeBytes = 10 * 1024 * 1024;

  /// Таймаут для медленного соединения
  static const Duration slowConnectionTimeout = Duration(seconds: 60);
}
