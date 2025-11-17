// ================================
// 📋 API CONSTANTS - КОНСТАНТЫ СЕТЕВОГО СЛОЯ
// ================================

/// 🎯 КОНСТАНТЫ ДЛЯ СЕТЕВЫХ ЗАПРОСОВ
///
/// Содержит настройки для HTTP клиента, URL, таймауты
class ApiConstants {
  // ================================
  // 🌐 БАЗОВЫЕ URL
  // ================================

  /// Базовый URL для development окружения
  static const String devBaseUrl = 'https://api.dev.eki-al.com';

  /// Базовый URL для production окружения
  static const String prodBaseUrl = 'https://api.prod.eki-al.com';

  /// Базовый URL для staging окружения
  static const String stagingBaseUrl = 'https://api.staging.eki-al.com';

  /// Получение базового URL в зависимости от окружения
  static String get baseUrl {
    return const String.fromEnvironment('BASE_URL', defaultValue: devBaseUrl);
  }

  // ================================
  // ⏰ ТАЙМАУТЫ
  // ================================

  /// Таймаут установки соединения
  static const Duration connectTimeout = Duration(seconds: 30);

  /// Таймаут получения ответа
  static const Duration receiveTimeout = Duration(seconds: 30);

  /// Таймаут отправки данных
  static const Duration sendTimeout = Duration(seconds: 30);

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

  /// Включение логирования запросов (только для dev)
  static const bool enableRequestLogging = true;

  /// Включение логирования ответов (только для dev)
  static const bool enableResponseLogging = true;

  /// Максимальный размер файла для загрузки (10 MB)
  static const int maxFileSizeBytes = 10 * 1024 * 1024;

  /// Таймаут для медленного соединения
  static const Duration slowConnectionTimeout = Duration(seconds: 60);
}
