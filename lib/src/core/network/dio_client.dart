// ================================
// 🎯 DIO CLIENT - ОСНОВНОЙ HTTP КЛИЕНТ
// ================================

import 'package:dio/dio.dart';
import 'package:eki_al/src/core/network/interceptors/logging_interceptor.dart';

import 'api_constants.dart';
import '../utils/log_utils.dart';

class DioClient {
  final Dio _dio;

  DioClient() : _dio = Dio(_createOptions()) {
    _addInterceptors();
    Log.i(
      '🌐 DioClient инициализирован',
      error: 'Base URL: ${_dio.options.baseUrl}',
    );
  }

  static BaseOptions _createOptions() {
    return BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      sendTimeout: ApiConstants.sendTimeout,
      headers: ApiConstants.defaultHeaders,
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
      validateStatus: (status) => status != null && status < 600,
    );
  }

  void _addInterceptors() {
    _dio.interceptors.addAll([
      LoggingInterceptor(), // Наш кастомный интерцептор
      LogInterceptor(
        request: ApiConstants.enableRequestLogging,
        requestHeader: ApiConstants.enableRequestLogging,
        requestBody: ApiConstants.enableRequestLogging,
        responseHeader: ApiConstants.enableResponseLogging,
        responseBody: ApiConstants.enableResponseLogging,
        error: true,
        logPrint: (object) => Log.d('🌐 Dio: $object'),
      ),
    ]);
    Log.d('🔧 Добавлено интерцепторов: ${_dio.interceptors.length}');
  }

  // ================================
  // 🎯 ОСНОВНЫЕ HTTP МЕТОДЫ
  // ================================

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    final url = _buildUrl(path, queryParameters);
    Log.network(method: 'GET', url: url);

    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    final url = _buildUrl(path, queryParameters);
    Log.network(method: 'POST', url: url, requestBody: data);

    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    final url = _buildUrl(path, queryParameters);
    Log.network(method: 'PUT', url: url, requestBody: data);

    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    final url = _buildUrl(path, queryParameters);
    Log.network(method: 'DELETE', url: url);

    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    final url = _buildUrl(path, queryParameters);
    Log.network(method: 'PATCH', url: url, requestBody: data);

    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // ================================
  // 🔧 ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ
  // ================================

  /// Строит полный URL с query параметрами для логирования
  String _buildUrl(String path, Map<String, dynamic>? queryParameters) {
    final baseUrl = _dio.options.baseUrl;
    if (queryParameters == null || queryParameters.isEmpty) {
      return '$baseUrl$path';
    }

    final queryString = Uri(queryParameters: queryParameters).query;
    return '$baseUrl$path?$queryString';
  }

  Future<Response> download(
    String urlPath,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    final url = _buildUrl(urlPath, queryParameters);
    Log.network(method: 'DOWNLOAD', url: url);

    return _dio.download(
      urlPath,
      savePath,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> postFormData<T>(
    String path, {
    required FormData data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    final url = _buildUrl(path, queryParameters);
    Log.network(method: 'POST_FORM', url: url);

    final formOptions = options ?? Options();
    formOptions.headers ??= {};
    formOptions.headers!.addAll(ApiConstants.multipartHeaders);

    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: formOptions,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // ================================
  // 🛠️ УТИЛИТЫ
  // ================================

  Dio get dio => _dio;

  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
    Log.i('🌐 Базовый URL изменен', error: baseUrl);
  }

  void setAuthToken(String token) {
    _dio.options.headers[ApiConstants.authHeaderKey] =
        '${ApiConstants.bearerPrefix} $token';
    Log.d('🔐 Токен авторизации установлен');
  }

  void clearAuthToken() {
    _dio.options.headers.remove(ApiConstants.authHeaderKey);
    Log.d('🔐 Токен авторизации очищен');
  }

  Map<String, dynamic> get config {
    return {
      'baseUrl': _dio.options.baseUrl,
      'connectTimeout': _dio.options.connectTimeout?.inSeconds,
      'receiveTimeout': _dio.options.receiveTimeout?.inSeconds,
      'headers': _dio.options.headers,
    };
  }
}
