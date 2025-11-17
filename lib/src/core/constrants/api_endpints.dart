/// 🌐 API ЭНДПОИНТЫ И СЕТЕВЫЕ КОНСТАНТЫ
///
/// Содержит URL, заголовки и статус коды HTTP
/// ВНИМАНИЕ: Замените базовые URL на актуальные для вашего проекта
abstract class ApiEndpoints {
  // ================================
  // 🎯 БАЗОВЫЕ URL ДЛЯ РАЗНЫХ ОКРУЖЕНИЙ
  // ================================

  // TODO: 🚨 ЗАМЕНИТЬ НА РЕАЛЬНЫЕ URL ВАШЕГО ПРОЕКТА

  /// Базовый URL для development окружения
  static const String devBaseUrl = 'https://dev-api.yourapp.com';

  /// Базовый URL для staging окружения
  static const String stagingBaseUrl = 'https://staging-api.yourapp.com';

  /// Базовый URL для production окружения
  static const String prodBaseUrl = 'https://api.yourapp.com';

  /// Текущий базовый URL приложения

  /// TODO: 🎯 ВЫБРАТЬ НУЖНОЕ ОКРУЖЕНИЕ (dev/staging/prod)
  static String get baseUrl => devBaseUrl;

  // ================================
  // 🔐 ЭНДПОИНТЫ АУТЕНТИФИКАЦИИ
  // ================================

  // TODO: 📝 НАСТРОИТЬ ЭНДПОИНТЫ ПОД ВАШУ API СТРУКТУРУ

  /// Эндпоинт для входа в систему
  static const String login = '/auth/login';

  /// Эндпоинт для регистрации пользователя
  static const String register = '/auth/register';

  /// Эндпоинт для выхода из системы
  static const String logout = '/auth/logout';

  /// Эндпоинт для обновления токена
  static const String refreshToken = '/auth/refresh';

  /// Эндпоинт для восстановления пароля
  static const String forgotPassword = '/auth/forgot-password';

  /// Эндпоинт для сброса пароля
  static const String resetPassword = '/auth/reset-password';

  // ================================
  // 👤 ЭНДПОИНТЫ ПОЛЬЗОВАТЕЛЯ
  // ================================

  /// Эндпоинт для получения профиля пользователя
  static const String userProfile = '/users/profile';

  /// Эндпоинт для обновления профиля пользователя
  static const String updateProfile = '/users/profile';

  /// Эндпоинт для изменения пароля
  static const String changePassword = '/users/change-password';

  // ================================
  // 🗂️ УНИВЕРСАЛЬНЫЕ CRUD ЭНДПОИНТЫ
  // ================================

  /// Генератор эндпоинта для получения ресурса по ID
  static String resourceById(String resource, String id) => '/$resource/$id';

  /// Генератор эндпоинта для получения списка ресурсов
  static String resourceList(String resource) => '/$resource';

  /// Генератор эндпоинта для создания ресурса
  static String resourceCreate(String resource) => '/$resource';

  /// Генератор эндпоинта для обновления ресурса
  static String resourceUpdate(String resource, String id) => '/$resource/$id';

  /// Генератор эндпоинта для удаления ресурса
  static String resourceDelete(String resource, String id) => '/$resource/$id';
}

/// 📨 ЗАГОЛОВКИ HTTP ЗАПРОСОВ
abstract class ApiHeaders {
  /// Заголовок типа контента
  static const String contentType = 'Content-Type';

  /// Заголовок авторизации
  static const String authorization = 'Authorization';

  /// Заголовок Accept
  static const String accept = 'Accept';

  /// Заголовок User-Agent
  static const String userAgent = 'User-Agent';

  /// Значение для JSON контента
  static const String jsonContentType = 'application/json';

  /// Значение для multipart/form-data
  static const String multipartContentType = 'multipart/form-data';
}

/// 📊 HTTP СТАТУС КОДЫ
abstract class HttpStatusCodes {
  /// Успешный запрос
  static const int success = 200;

  /// Ресурс создан
  static const int created = 201;

  /// Нет содержимого
  static const int noContent = 204;

  /// Неверный запрос
  static const int badRequest = 400;

  /// Неавторизован
  static const int unauthorized = 401;

  /// Запрещено
  static const int forbidden = 403;

  /// Не найдено
  static const int notFound = 404;

  /// Внутренняя ошибка сервера
  static const int internalServerError = 500;

  /// Сервис недоступен
  static const int serviceUnavailable = 503;
}
