// ================================
// 📱 DEVICE UTILS
// ================================

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Утилиты для работы с устройством и платформой
///
/// Предоставляет методы для:
/// - Определения типа устройства и платформы
/// - Проверки версий ОС и приложения
/// - Работы с размерами экрана и ориентацией
/// - Управления клавиатурой и вибрацией
/// - Получения информации о устройстве
///
/// Все методы безопасны и обрабатывают исключения
class DeviceUtils {
  // ================================
  // 🖥️ ИНФОРМАЦИЯ О ПЛАТФОРМЕ
  // ================================

  /// Проверяет запущено ли приложение на iOS
  ///
  /// Пример использования:
  /// ```dart
  /// if (DeviceUtils.isIOS) {
  ///   // Используем Cupertino widgets
  /// }
  /// ```
  static bool get isIOS => Platform.isIOS;

  /// Проверяет запущено ли приложение на Android
  static bool get isAndroid => Platform.isAndroid;

  /// Проверяет запущено ли приложение на macOS
  static bool get isMacOS => Platform.isMacOS;

  /// Проверяет запущено ли приложение на Windows
  static bool get isWindows => Platform.isWindows;

  /// Проверяет запущено ли приложение на Linux
  static bool get isLinux => Platform.isLinux;

  /// Проверяет запущено ли приложение в вебе
  static bool get isWeb => kIsWeb;

  /// Проверяет запущено ли приложение в режиме разработки
  static bool get isDebugMode => kDebugMode;

  /// Проверяет запущено ли приложение в режиме релиза
  static bool get isReleaseMode => kReleaseMode;

  /// Возвращает целевую платформу для MaterialApp
  static TargetPlatform get platform {
    if (isWeb) {
      return TargetPlatform.android; // Или определять по user agent
    }
    return defaultTargetPlatform;
  }

  // ================================
  // 📱 ТИП УСТРОЙСТВА И ЭКРАН
  // ================================

  /// Проверяет является ли устройство телефоном
  ///
  /// Пример использования:
  /// ```dart
  /// if (DeviceUtils.isPhone(context)) {
  ///   return MobileLayout();
  /// } else {
  ///   return DesktopLayout();
  /// }
  /// ```
  static bool isPhone(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final shortestSide = mediaQuery.size.shortestSide;
    return shortestSide < 600;
  }

  /// Проверяет является ли устройство планшетом
  static bool isTablet(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final shortestSide = mediaQuery.size.shortestSide;
    return shortestSide >= 600;
  }

  /// Проверяет является ли устройство десктопом
  static bool isDesktop(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final shortestSide = mediaQuery.size.shortestSide;
    return shortestSide >= 900;
  }

  /// Возвращает размер экрана как enum
  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 600) return ScreenSize.small;
    if (width < 900) return ScreenSize.medium;
    if (width < 1200) return ScreenSize.large;
    return ScreenSize.xlarge;
  }

  /// Проверяет текущую ориентацию устройства
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// Проверяет находится ли устройство в альбомной ориентации
  static bool isLandscape(BuildContext context) {
    return getOrientation(context) == Orientation.landscape;
  }

  /// Проверяет находится ли устройство в портретной ориентации
  static bool isPortrait(BuildContext context) {
    return getOrientation(context) == Orientation.portrait;
  }

  /// Возвращает высоту статус бара
  static double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// Возвращает высоту нижней панели (для iPhone с "чёлкой")
  static double bottomBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  /// Возвращает безопасную зону для контента
  static EdgeInsets safeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  // ================================
  // 🔧 СИСТЕМНЫЕ ВОЗМОЖНОСТИ
  // ================================

  /// Скрывает клавиатуру
  ///
  /// Пример использования:
  /// ```dart
  /// onTap: () {
  ///   DeviceUtils.hideKeyboard(context);
  /// }
  /// ```
  static void hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
    }
  }

  /// Показывает клавиатуру для указанного фокуса
  static void showKeyboard(FocusNode focusNode) {
    focusNode.requestFocus();
  }

  /// Проверяет включена ли темная тема
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Проверяет включен ли режим высокой контрастности
  static bool isHighContrast(BuildContext context) {
    return MediaQuery.of(context).highContrast;
  }

  /// Проверяет включен ли режим уменьшения анимации
  static bool isReducedMotion(BuildContext context) {
    return MediaQuery.of(context).disableAnimations;
  }

  /// Проверяет включен ли режим увеличения текста
  static bool isTextScaled(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor != 1.0;
  }

  // ================================
  // 📊 ИНФОРМАЦИЯ О ВЕРСИЯХ
  // ================================

  /// Возвращает версию операционной системы
  ///
  /// Пример использования:
  /// ```dart
  /// final osVersion = await DeviceUtils.getOSVersion();
  /// print('Android $osVersion');
  /// ```
  static Future<String> getOSVersion() async {
    try {
      if (isAndroid) {
        return Platform.version;
      } else if (isIOS) {
        // Для iOS можно использовать device_info_plus пакет
        return 'iOS ${Platform.operatingSystemVersion}';
      }
      return Platform.operatingSystemVersion;
    } catch (e) {
      return 'Unknown';
    }
  }

  /// Проверяет поддерживается ли минимальная версия ОС
  static Future<bool> isOSVersionSupported(String minVersion) async {
    try {
      final currentVersion = await getOSVersion();
      // Простая проверка - в реальном приложении нужно парсить версии
      return _compareVersions(currentVersion, minVersion) >= 0;
    } catch (e) {
      return true; // В случае ошибки предполагаем поддержку
    }
  }

  // ================================
  // ⚡ СИСТЕМНЫЕ ФУНКЦИИ
  // ================================

  /// Вызывает вибрацию устройства (только Android/iOS)
  ///
  /// Пример использования:
  /// ```dart
  /// onPressed: () {
  ///   DeviceUtils.vibrate();
  ///   // Действие кнопки
  /// }
  /// ```
  static void vibrate({Duration duration = const Duration(milliseconds: 50)}) {
    try {
      if (isAndroid || isIOS) {
        HapticFeedback.lightImpact();
      }
    } catch (e) {
      // Игнорируем ошибки вибрации
    }
  }

  /// Вызывает тяжелую вибрацию (только Android/iOS)
  static void vibrateHeavy() {
    try {
      if (isAndroid || isIOS) {
        HapticFeedback.heavyImpact();
      }
    } catch (e) {
      // Игнорируем ошибки вибрации
    }
  }

  /// Копирует текст в буфер обмена
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  /// Читает текст из буфера обмена
  static Future<String?> pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text;
  }

  // ================================
  // 🔧 ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ
  // ================================

  /// Сравнивает две версии в формате semver
  static int _compareVersions(String version1, String version2) {
    final v1 = version1.split('.').map(int.parse).toList();
    final v2 = version2.split('.').map(int.parse).toList();

    for (var i = 0; i < v1.length; i++) {
      if (v2.length <= i) return 1;
      if (v1[i] > v2[i]) return 1;
      if (v1[i] < v2[i]) return -1;
    }

    return v1.length == v2.length ? 0 : -1;
  }

  /// Выполняет действие с проверкой платформы
  static T? platformSpecific<T>({
    T? android,
    T? ios,
    T? web,
    T? macOS,
    T? windows,
    T? linux,
    T? orElse,
  }) {
    if (isAndroid && android != null) return android;
    if (isIOS && ios != null) return ios;
    if (isWeb && web != null) return web;
    if (isMacOS && macOS != null) return macOS;
    if (isWindows && windows != null) return windows;
    if (isLinux && linux != null) return linux;
    return orElse;
  }
}

/// Размеры экрана для адаптивного дизайна
enum ScreenSize {
  small, // < 600px - телефоны
  medium, // 600-899px - планшеты
  large, // 900-1199px - маленькие десктопы
  xlarge, // >= 1200px - большие десктопы
}

/// Расширения для BuildContext для удобного доступа к DeviceUtils
extension DeviceUtilsExtension on BuildContext {
  /// Проверяет является ли устройство телефоном
  bool get isPhone => DeviceUtils.isPhone(this);

  /// Проверяет является ли устройство планшетом
  bool get isTablet => DeviceUtils.isTablet(this);

  /// Проверяет является ли устройство десктопом
  bool get isDesktop => DeviceUtils.isDesktop(this);

  /// Возвращает размер экрана
  ScreenSize get screenSize => DeviceUtils.getScreenSize(this);

  /// Проверяет включена ли темная тема
  bool get isDarkMode => DeviceUtils.isDarkMode(this);

  /// Скрывает клавиатуру
  void hideKeyboard() => DeviceUtils.hideKeyboard(this);
}
