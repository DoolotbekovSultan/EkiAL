// ================================
// 📝 LOGGING INTERCEPTOR - ИНТЕРЦЕПТОР ЛОГИРОВАНИЯ
// ================================

import 'package:dio/dio.dart';

import '../api_constants.dart';
import '../../utils/log_utils.dart';

/// 🎯 ПЕРЕХВАТЧИК ДЛЯ ЛОГИРОВАНИЯ СЕТЕВЫХ ОПЕРАЦИЙ
///
/// Содержит:
/// - Запись всех исходящих запросов
/// - Логирование входящих ответов
/// - Форматирование логов для удобства чтения
/// - Фильтрацию конфиденциальных данных
///
/// Особенности:
/// - В production логирует только ошибки
/// - В development логирует все операции
/// - Фильтрует пароли и токены в логах
class LoggingInterceptor extends Interceptor {
  final Map<String, DateTime> _requestTimestamps = {};
  final Set<String> _sensitiveFields = {'password', 'token', 'authorization'};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!ApiConstants.enableRequestLogging) {
      handler.next(options);
      return;
    }

    _requestTimestamps[options.uri.toString()] = DateTime.now();

    final filteredHeaders = _filterSensitiveData(options.headers);
    final filteredData = _filterSensitiveData(options.data);

    Log.network(
      method: options.method,
      url: options.uri.toString(),
      requestBody: filteredData,
    );

    Log.t('📋 Заголовки запроса: $filteredHeaders');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!ApiConstants.enableResponseLogging) {
      handler.next(response);
      return;
    }

    final requestTime =
        _requestTimestamps[response.requestOptions.uri.toString()];
    final duration = requestTime != null
        ? DateTime.now().difference(requestTime)
        : null;

    final filteredData = _filterSensitiveData(response.data);

    Log.network(
      method: response.requestOptions.method,
      url: response.requestOptions.uri.toString(),
      statusCode: response.statusCode,
      responseTime: duration,
      responseBody: filteredData,
    );

    _requestTimestamps.remove(response.requestOptions.uri.toString());
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Всегда логируем ошибки независимо от настроек
    final requestTime = _requestTimestamps[err.requestOptions.uri.toString()];
    final duration = requestTime != null
        ? DateTime.now().difference(requestTime)
        : null;

    final filteredData = _filterSensitiveData(err.response?.data);

    Log.network(
      method: err.requestOptions.method,
      url: err.requestOptions.uri.toString(),
      statusCode: err.response?.statusCode,
      responseTime: duration,
      error: err.message,
      responseBody: filteredData,
    );

    _requestTimestamps.remove(err.requestOptions.uri.toString());
    handler.next(err);
  }

  /// Фильтрует конфиденциальные данные в логах
  dynamic _filterSensitiveData(dynamic data) {
    if (data is Map) {
      final filtered = Map<String, dynamic>.from(data);
      for (final key in filtered.keys) {
        if (_isSensitiveField(key.toString())) {
          filtered[key] = '***FILTERED***';
        } else if (filtered[key] is Map) {
          filtered[key] = _filterSensitiveData(filtered[key]);
        }
      }
      return filtered;
    } else if (data is String) {
      // Простая проверка на наличие конфиденциальных данных в строке
      if (_containsSensitiveData(data)) {
        return '***FILTERED_CONTENT***';
      }
    }
    return data;
  }

  /// Проверяет является ли поле конфиденциальным
  bool _isSensitiveField(String fieldName) {
    final lowerField = fieldName.toLowerCase();
    return _sensitiveFields.any((sensitive) => lowerField.contains(sensitive));
  }

  /// Проверяет содержит ли строка конфиденциальные данные
  bool _containsSensitiveData(String content) {
    final lowerContent = content.toLowerCase();
    return _sensitiveFields.any(
      (sensitive) => lowerContent.contains(sensitive),
    );
  }
}
