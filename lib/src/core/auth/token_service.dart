// ================================
// 🔐 TOKEN SERVICE - СЕРВИС РАБОТЫ С ТОКЕНАМИ
// ================================

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/log_utils.dart';

/// Сервис для работы с токенами аутентификации
///
/// Отвечает за:
/// - Хранение access и refresh токенов
/// - Получение токенов из хранилища
/// - Обновление токенов
/// - Очистку токенов при выходе
@injectable
class TokenService {
  final SharedPreferences _prefs;

  // Ключи для хранения токенов
  static const String _accessTokenKey = 'auth_access_token';
  static const String _refreshTokenKey = 'auth_refresh_token';
  static const String _tokenExpiryKey = 'auth_token_expiry';

  TokenService({required SharedPreferences prefs}) : _prefs = prefs;

  /// Получает текущий access токен
  Future<String?> getAccessToken() async {
    try {
      final token = _prefs.getString(_accessTokenKey);
      if (token != null && token.isNotEmpty) {
        Log.d('🔐 Access токен получен из хранилища');
        return token;
      }
      Log.d('🔐 Access токен отсутствует');
      return null;
    } catch (e, stackTrace) {
      Log.e('❌ Ошибка получения access токена', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Получает refresh токен
  Future<String?> getRefreshToken() async {
    try {
      final token = _prefs.getString(_refreshTokenKey);
      if (token != null && token.isNotEmpty) {
        Log.d('🔐 Refresh токен получен из хранилища');
        return token;
      }
      Log.d('🔐 Refresh токен отсутствует');
      return null;
    } catch (e, stackTrace) {
      Log.e('❌ Ошибка получения refresh токена', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Сохраняет access токен
  Future<bool> saveAccessToken(String token, {Duration? expiry}) async {
    try {
      final success = await _prefs.setString(_accessTokenKey, token);
      if (success && expiry != null) {
        final expiryTime = DateTime.now().add(expiry).toIso8601String();
        await _prefs.setString(_tokenExpiryKey, expiryTime);
      }
      Log.d('✅ Access токен сохранен');
      return success;
    } catch (e, stackTrace) {
      Log.e('❌ Ошибка сохранения access токена', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Сохраняет refresh токен
  Future<bool> saveRefreshToken(String token) async {
    try {
      final success = await _prefs.setString(_refreshTokenKey, token);
      Log.d('✅ Refresh токен сохранен');
      return success;
    } catch (e, stackTrace) {
      Log.e('❌ Ошибка сохранения refresh токена', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Сохраняет оба токена
  Future<bool> saveTokens({
    required String accessToken,
    required String refreshToken,
    Duration? accessTokenExpiry,
  }) async {
    try {
      final accessSuccess = await saveAccessToken(accessToken, expiry: accessTokenExpiry);
      final refreshSuccess = await saveRefreshToken(refreshToken);
      return accessSuccess && refreshSuccess;
    } catch (e, stackTrace) {
      Log.e('❌ Ошибка сохранения токенов', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Проверяет, истек ли токен
  bool isTokenExpired() {
    try {
      final expiryString = _prefs.getString(_tokenExpiryKey);
      if (expiryString == null) return false;

      final expiry = DateTime.parse(expiryString);
      final isExpired = DateTime.now().isAfter(expiry);
      
      if (isExpired) {
        Log.w('⚠️ Access токен истек');
      }
      return isExpired;
    } catch (e) {
      Log.w('⚠️ Ошибка проверки срока действия токена: $e');
      return false;
    }
  }

  /// Очищает все токены
  Future<bool> clearTokens() async {
    try {
      final results = await Future.wait([
        _prefs.remove(_accessTokenKey),
        _prefs.remove(_refreshTokenKey),
        _prefs.remove(_tokenExpiryKey),
      ]);
      final success = results.every((result) => result);
      Log.d('✅ Токены очищены');
      return success;
    } catch (e, stackTrace) {
      Log.e('❌ Ошибка очистки токенов', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Проверяет наличие токенов
  bool hasTokens() {
    final hasAccess = _prefs.containsKey(_accessTokenKey);
    final hasRefresh = _prefs.containsKey(_refreshTokenKey);
    return hasAccess || hasRefresh;
  }
}

