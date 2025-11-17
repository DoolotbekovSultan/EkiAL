# Presentation

## Назначение
Папка `presentation` содержит общие компоненты пользовательского интерфейса, которые используются несколькими фичами приложения. Эти виджеты, страницы и UI логика обеспечивают согласованный пользовательский опыт.

## Структура
**presentation/** - 🖥️ Слой представления
- shared_widgets.dart - 🧩 Базовые виджеты и UI компоненты

## Описание

### shared_widget.dart
Базовые UI компоненты. Содержит:
- Абстрактные классы для всех общих виджетов
- Базовые state management компоненты
- Общие layout и UI элементы
- Утилиты для работы с темой и стилями

## Основные компоненты

### BaseWidget
Абстрактный класс для всех общих виджетов, определяющий:
- Стандартные параметры и свойства
- Общие lifecycle методы
- Единые подходы к стилизации
- Базовую обработку ошибок

### SharedStateWidget
Базовый класс для виджетов с состоянием:
- Управление состоянием UI
- Стандартные паттерны state management
- Общие методы обновления состояния
- Интеграция с BLoC/Cubit

### PresentationService
Интерфейс для общих UI сервисов:
- Навигация между общими экранами
- Управление диалогами и snackbars
- Работа с темой и локализацией
- Общие UI утилиты

## Преимущества

- **Согласованный UI** - единый внешний вид между фичами
- **Переиспользуемость** - общие компоненты для всего приложения
- **Эффективность** - избежание дублирования UI кода
- **Поддерживаемость** - централизованное обновление стилей
- **Стандартизация** - единые подходы к построению интерфейса

## Best Practices

1. Создавайте переиспользуемые и независимые виджеты
2. Используйте константы для размеров и стилей
3. Инкапсулируйте сложную UI логику в отдельных виджетах
4. Документируйте параметры и поведение общих виджетов
5. Тестируйте UI компоненты изолированно
6. Следите за производительностью перерисовок
7. Используйте semantic widgets для доступности

## Пример использования

```dart
// Базовый класс общего виджета
abstract class BaseWidget extends StatelessWidget {
  final String? semanticLabel;
  final bool enabled;

  const BaseWidget({
    super.key,
    this.semanticLabel,
    this.enabled = true,
  });

  @protected
  Widget buildLayout(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      enabled: enabled,
      child: buildLayout(context),
    );
  }
}

// Базовый класс для виджетов с состоянием
abstract class SharedStateWidget<T extends StatefulWidget> extends State<T> {
  @protected
  void onInit() {}
  
  @protected
  void onDispose() {}

  @override
  void initState() {
    super.initState();
    onInit();
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }
}

// Общий кнопочный виджет для всех фич
class PrimaryButton extends BaseWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    super.semanticLabel,
    super.enabled,
  });

  @override
  Widget buildLayout(BuildContext context) {
    final theme = Theme.of(context);
    
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: isLoading 
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );
  }
}

// Общий виджет загрузки
class LoadingIndicator extends BaseWidget {
  final double size;
  final Color? color;

  const LoadingIndicator({
    super.key,
    this.size = 24,
    this.color,
    super.semanticLabel = 'Loading',
  });

  @override
  Widget buildLayout(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation(
          color ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

// Общий виджет ошибки
class ErrorWidget extends BaseWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    super.semanticLabel = 'Error',
  });

  @override
  Widget buildLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 64,
          color: Theme.of(context).colorScheme.error,
        ),
        const SizedBox(height: 16),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        if (onRetry != null) ...[
          const SizedBox(height: 16),
          PrimaryButton(
            text: 'Try Again',
            onPressed: onRetry,
          ),
        ],
      ],
    );
  }
}

// Общий сервис для UI операций
class PresentationService {
  final GlobalKey<NavigatorState> navigatorKey;

  const PresentationService(this.navigatorKey);

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError 
            ? Theme.of(navigatorKey.currentContext!).colorScheme.error
            : null,
      ),
    );
  }

  Future<T?> showDialog<T>(Widget dialog) {
    return showDialog<T>(
      context: navigatorKey.currentContext!,
      builder: (context) => dialog,
    );
  }
}