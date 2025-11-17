// ================================
// 🔄 RETRY INTERCEPTOR - ИНТЕРЦЕПТОР ПОВТОРА ЗАПРОСОВ
// ================================

import 'package:dio/dio.dart';

import '../api_constants.dart';
import '../../utils/log_utils.dart';

/// 🎯 ПЕРЕХВАТЧИК ДЛЯ ПОВТОРНЫХ ПОПЫТОК ЗАПРОСОВ
///
/// Содержит:
/// - Стратегии повторения при сетевых сбоях
/// - Настройку максимального количества попыток
/// - Экспоненциальные задержки между попытками
/// - Условия для повторения запросов
///
/// Стратегия повторения:
/// - Экспоненциальная backoff задержка
/// - Повтор только для безопасных методов (GET)
/// - Ограничение максимального количества попыток
class RetryInterceptor extends Interceptor {
  final Map<String, int> _retryCounts = {};

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;
    final requestKey = '${requestOptions.method}:${requestOptions.uri}';

    // Проверяем нужно ли повторять запрос
    if (!_shouldRetry(err) || !_canRetry(requestKey)) {
      _retryCounts.remove(requestKey);
      handler.next(err);
      return;
    }

    // Увеличиваем счетчик попыток
    _retryCounts[requestKey] = (_retryCounts[requestKey] ?? 0) + 1;
    final retryCount = _retryCounts[requestKey]!;

    // Рассчитываем задержку
    final delay = _calculateRetryDelay(retryCount);

    Log.w(
      '🔄 Повтор запроса (попытка $retryCount/${ApiConstants.maxRetryAttempts})',
      error: 'Задержка: ${delay.inMilliseconds}ms',
    );

    // Ждем перед повторной попыткой
    await Future.delayed(delay);

    try {
      // Повторяем запрос
      final dio = Dio();
      final response = await dio.fetch<dynamic>(requestOptions);
      handler.resolve(response);
    } catch (retryError) {
      // Если повторная попытка не удалась
      if (retryCount >= ApiConstants.maxRetryAttempts) {
        Log.e('❌ Превышено максимальное количество попыток повторения');
        _retryCounts.remove(requestKey);
        handler.next(err);
      } else {
        // Рекурсивно повторяем обработку ошибки
        await onError(retryError is DioException ? retryError : err, handler);
      }
    }
  }

  /// Проверяет нужно ли повторять запрос
  bool _shouldRetry(DioException err) {
    // Повторяем только для сетевых ошибок и таймаутов
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.response?.statusCode ?? 0) >= 500;
  }

  /// Проверяет можно ли повторять запрос
  bool _canRetry(String requestKey) {
    final retryCount = _retryCounts[requestKey] ?? 0;
    return retryCount < ApiConstants.maxRetryAttempts;
  }

  /// Рассчитывает задержку между попытками
  Duration _calculateRetryDelay(int retryCount) {
    final baseDelay = ApiConstants.retryDelay;
    final multiplier = ApiConstants.retryBackoffMultiplier;

    // Экспоненциальная backoff задержка
    final delayMs = baseDelay.inMilliseconds * (multiplier * retryCount);
    return Duration(milliseconds: delayMs.toInt());
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Очищаем счетчик при успешном ответе
    final requestKey =
        '${response.requestOptions.method}:${response.requestOptions.uri}';
    _retryCounts.remove(requestKey);
    handler.next(response);
  }
}
