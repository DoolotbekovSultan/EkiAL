// ================================
// 🖼️ IMAGE UTILS
// ================================

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:io';

/// Утилиты для работы с изображениями
///
/// СОДЕРЖАНИЕ ФАЙЛА:
///
/// 🌐 ЗАГРУЗКА И КЭШИРОВАНИЕ:
/// - loadNetworkImage() - загрузка из сети с кэшированием
/// - loadNetworkImageWidget() - виджет для загрузки
/// - precacheImages() - предзагрузка изображений
///
/// 🎨 ОБРАБОТКА И ТРАНСФОРМАЦИИ:
/// - createCircleAvatar() - круглая аватарка
/// - createRoundedImage() - скругленное изображение
/// - resizeImage() - изменение размера
///
/// ⚡ УТИЛИТЫ ДЛЯ ВИДЖЕТОВ:
/// - placeholderWidget() - заглушка при загрузке
/// - errorWidget() - виджет ошибки
/// - loadingWidget() - индикатор загрузки
///
/// 📱 РАБОТА С ФАЙЛАМИ:
/// - loadFileImage() - загрузка из файла
/// - getImageSize() - получение размеров
///
/// 🎯 СПЕЦИАЛИЗИРОВАННЫЕ МЕТОДЫ:
/// - createUserAvatar() - аватар пользователя
/// - createProductImage() - изображение товара
/// - createCategoryIcon() - иконка категории

class ImageUtils {
  // ================================
  // 🌐 ЗАГРУЗКА И КЭШИРОВАНИЕ
  // ================================

  /// Загружает изображение из сети с кэшированием
  ///
  /// Пример использования:
  /// ```dart
  /// final imageProvider = ImageUtils.loadNetworkImage('https://example.com/image.jpg');
  /// Image(image: imageProvider);
  /// ```
  static ImageProvider loadNetworkImage(String url) {
    return CachedNetworkImageProvider(url);
  }

  /// Создает виджет для загрузки изображения из сети с кэшированием
  ///
  /// Пример использования:
  /// ```dart
  /// ImageUtils.loadNetworkImageWidget(
  ///   'https://example.com/image.jpg',
  ///   width: 100,
  ///   height: 100,
  ///   fit: BoxFit.cover,
  /// )
  /// ```
  static Widget loadNetworkImageWidget(
    String url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => placeholder ?? _defaultLoadingWidget(),
      errorWidget: (context, url, error) =>
          errorWidget ?? _defaultErrorWidget(),
    );
  }

  /// Предзагружает изображения для быстрого доступа
  static Future<void> precacheImages(
    List<String> urls,
    BuildContext context,
  ) async {
    for (final url in urls) {
      final provider = loadNetworkImage(url);
      await precacheImage(provider, context);
    }
  }

  // ================================
  // 🎨 ОБРАБОТКА И ТРАНСФОРМАЦИИ
  // ================================

  /// Создает круглый аватар из изображения
  ///
  /// Пример использования:
  /// ```dart
  /// ImageUtils.createCircleAvatar(
  ///   imageUrl: 'https://example.com/avatar.jpg',
  ///   radius: 40,
  ///   backgroundColor: Colors.grey[300],
  /// )
  /// ```
  static Widget createCircleAvatar({
    String? imageUrl,
    Widget? child,
    double radius = 20,
    Color? backgroundColor,
    File? imageFile,
  }) {
    if (imageUrl != null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        backgroundImage: loadNetworkImage(imageUrl),
        child: child,
      );
    } else if (imageFile != null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        backgroundImage: FileImage(imageFile),
        child: child,
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? Colors.grey[300],
        child: child ?? const Icon(Icons.person, color: Colors.white),
      );
    }
  }

  /// Создает скругленное изображение
  static Widget createRoundedImage({
    required String imageUrl,
    double borderRadius = 8.0,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: loadNetworkImageWidget(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }

  /// Создает изображение с градиентным оверлеем
  static Widget createImageWithOverlay({
    required String imageUrl,
    List<Color> gradientColors = const [Colors.transparent, Colors.black54],
    Alignment begin = Alignment.topCenter,
    Alignment end = Alignment.bottomCenter,
    double borderRadius = 0,
  }) {
    return Stack(
      children: [
        createRoundedImage(imageUrl: imageUrl, borderRadius: borderRadius),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: LinearGradient(
                begin: begin,
                end: end,
                colors: gradientColors,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ================================
  // ⚡ УТИЛИТЫ ДЛЯ ВИДЖЕТОВ
  // ================================

  /// Виджет-заглушка при загрузке изображения
  static Widget placeholderWidget({
    double? width,
    double? height,
    Color color = Colors.grey,
    IconData icon = Icons.image,
  }) {
    return Container(
      width: width,
      height: height,
      color: color.withOpacity(0.1),
      child: Icon(
        icon,
        color: color.withOpacity(0.3),
        size: _calculateIconSize(width, height),
      ),
    );
  }

  /// Виджет ошибки загрузки изображения
  static Widget errorWidget({
    double? width,
    double? height,
    Color color = Colors.grey,
  }) {
    return Container(
      width: width,
      height: height,
      color: color.withOpacity(0.1),
      child: Icon(
        Icons.broken_image,
        color: color.withOpacity(0.3),
        size: _calculateIconSize(width, height),
      ),
    );
  }

  /// Индикатор загрузки изображения
  static Widget loadingWidget({
    double? width,
    double? height,
    Color color = Colors.blue,
  }) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.withOpacity(0.1),
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ),
    );
  }

  // ================================
  // 📱 РАБОТА С ФАЙЛАМИ
  // ================================

  /// Загружает изображение из файла
  static ImageProvider loadFileImage(String filePath) {
    return FileImage(File(filePath));
  }

  /// Создает виджет для изображения из файла
  static Widget loadFileImageWidget(
    String filePath, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image(
      image: loadFileImage(filePath),
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget(width: width, height: height),
    );
  }

  // ================================
  // 🎯 СПЕЦИАЛИЗИРОВАННЫЕ МЕТОДЫ
  // ================================

  /// Создает аватар пользователя с инициалами
  static Widget createUserAvatar({
    String? imageUrl,
    String? userName,
    double size = 40,
    Color backgroundColor = Colors.blue,
    Color textColor = Colors.white,
  }) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return createCircleAvatar(imageUrl: imageUrl, radius: size / 2);
    } else if (userName != null && userName.isNotEmpty) {
      final initials = _getInitials(userName);
      return CircleAvatar(
        radius: size / 2,
        backgroundColor: backgroundColor,
        child: Text(
          initials,
          style: TextStyle(
            color: textColor,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return createCircleAvatar(radius: size / 2);
    }
  }

  /// Создает изображение товара с placeholder
  static Widget createProductImage({
    required String imageUrl,
    double width = 80,
    double height = 80,
    double borderRadius = 8,
  }) {
    return createRoundedImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      borderRadius: borderRadius,
    );
  }

  /// Создает иконку категории
  static Widget createCategoryIcon({
    required String imageUrl,
    double size = 50,
    Color backgroundColor = Colors.white,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: loadNetworkImageWidget(imageUrl, fit: BoxFit.contain),
      ),
    );
  }

  // ================================
  // 🔧 ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ
  // ================================

  static Widget _defaultLoadingWidget() {
    return loadingWidget();
  }

  static Widget _defaultErrorWidget() {
    return errorWidget();
  }

  static double _calculateIconSize(double? width, double? height) {
    final minSize = (width ?? height ?? 40) * 0.3;
    return minSize.clamp(16, 32).toDouble();
  }

  static String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    }
    return '?';
  }
}

/// Расширения для удобной работы с изображениями
extension ImageUtilsExtension on String {
  /// Быстрое создание виджета изображения из URL
  Widget toNetworkImage({
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return ImageUtils.loadNetworkImageWidget(
      this,
      width: width,
      height: height,
      fit: fit,
    );
  }

  /// Создание круглого аватара из URL
  Widget toCircleAvatar({double radius = 20}) {
    return ImageUtils.createCircleAvatar(imageUrl: this, radius: radius);
  }
}

extension ImageFileExtension on File {
  /// Быстрое создание виджета изображения из файла
  Widget toImageWidget({
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return ImageUtils.loadFileImageWidget(
      path,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
