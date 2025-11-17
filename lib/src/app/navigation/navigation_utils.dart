// ================================
// 🔧 NAVIGATION UTILS - УТИЛИТЫ ДЛЯ НАВИГАЦИИ
// ================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../core/utils/log_utils.dart';

/// 🎯 УТИЛИТЫ ДЛЯ РАБОТЫ С НАВИГАЦИЕЙ
class NavigationUtils {
  /// 🧭 БЕЗОПАСНАЯ НАВИГАЦИЯ С ОБРАБОТКОЙ ОШИБОК
  static Future<void> safeNavigate({
    required BuildContext context,
    required PageRouteInfo route,
    String? tag,
  }) async {
    try {
      Log.navigation(
        'NavigationUtils',
        'safeNavigate',
        arguments: {'route': route.routeName, 'tag': tag},
      );

      await context.pushRoute(route);

      Log.d('✅ Navigation successful: ${route.routeName}');
    } catch (error, stackTrace) {
      Log.e(
        '🚨 Navigation failed: ${route.routeName}',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
