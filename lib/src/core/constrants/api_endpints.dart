// ================================
// 🌐 API ENDPOINTS - ЭНДПОИНТЫ И СЕТЕВЫЕ КОНСТАНТЫ
// ================================

import 'package:eki_al/src/core/network/api_constants.dart';

/// 🌐 API ЭНДПОИНТЫ И СЕТЕВЫЕ КОНСТАНТЫ
///
/// ## 📖 ОПИСАНИЕ:
/// Содержит относительные пути API, HTTP заголовки и статус коды.
/// Базовый URL берется из `AppConfig` через `ApiConstants.baseUrl`,
/// чтобы избежать дублирования настроек окружений.
///
/// ## 📁 СТРУКТУРА:
/// - `ApiEndpoints` - относительные пути к API методам
/// - `ApiHeaders` - HTTP заголовки и их значения
/// - `HttpStatusCodes` - стандартные статус коды HTTP
///
/// ## 🎯 ИСПОЛЬЗОВАНИЕ:
/// ```dart
/// final loginUrl = ApiEndpoints.login;
/// final profileUrl = ApiEndpoints.userProfile;
/// final userUrl = ApiEndpoints.resourceById('users', '123');
/// headers[ApiHeaders.authorization] = 'Bearer $token';
/// if (statusCode == HttpStatusCodes.success) { ... }
/// ```
abstract class ApiEndpoints {
  /// Текущий базовый URL приложения
  static String get baseUrl => ApiConstants.baseUrl;

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
///
/// ## 📖 ОПИСАНИЕ:
/// Стандартные HTTP заголовки и их значения для использования в сетевых запросах.
///
/// ## 🎯 ИСПОЛЬЗОВАНИЕ:
/// ```dart
/// headers[ApiHeaders.authorization] = 'Bearer $token';
/// headers[ApiHeaders.contentType] = ApiHeaders.jsonContentType;
/// ```
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
///
/// ## 📖 ОПИСАНИЕ:
/// Стандартные HTTP статус коды для проверки ответов сервера.
///
/// ## 🎯 ИСПОЛЬЗОВАНИЕ:
/// ```dart
/// if (response.statusCode == HttpStatusCodes.success) {
///   // обработка успешного ответа
/// } else if (response.statusCode == HttpStatusCodes.unauthorized) {
///   // обработка ошибки авторизации
/// }
/// ```
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
