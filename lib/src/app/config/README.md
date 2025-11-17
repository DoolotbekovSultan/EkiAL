# config/

## Назначение
Папка `config` содержит конфигурации для разных окружений приложения, настройки и параметры, которые могут меняться в зависимости от среды выполнения.

## Структура
**config/** - ⚙️ Конфигурации окружений
- app_config.dart - 🎯 Базовая конфигурация
- dev_config.dart - 🛠️ Development
- staging_config.dart - 🧪 Staging
- prod_config.dart - 🚀 Production
- config_reader.dart - 📖 Утилита чтения

## Описание файлов

### app_config.dart
Базовый абстрактный класс конфигурации приложения.

Содержит:
- абстрактные геттеры для общих параметров
- базовую реализацию общих методов
- интерфейс для всех конфигураций окружений

### dev_config.dart
Конфигурация для development окружения.

Содержит:
- настройки для локальной разработки
- URL для dev серверов
- debug-флаги и инструменты
- тестовые данные и моки

### staging_config.dart
Конфигурация для staging окружения.

Содержит:
- настройки для тестового сервера
- URL для staging API
- промежуточные настройки
- инструменты для QA тестирования

### prod_config.dart
Конфигурация для production окружения.

Содержит:
- настройки для продакшн серверов
- production URL и endpoints
- оптимизированные параметры
- настройки безопасности

### config_reader.dart
Утилита для чтения и управления конфигурациями.

Содержит:
- логику выбора конфигурации по окружению
- методы для валидации конфигураций
- утилиты для работы с конфигурациями

## Преимущества

- Легкое переключение между окружениями
- Централизованное управление настройками
- Безопасность конфигурационных данных
- Валидация параметров при запуске
- Поддержка разных сценариев развертывания

## Best Practices

1. Храните чувствительные данные в защищенных хранилищах
2. Используйте разные конфигурации для каждого окружения
3. Валидируйте конфигурации при инициализации
4. Минимизируйте дублирование кода между конфигурациями
5. Используйте константы вместо хардкода значений
6. Настройте автоматическое определение окружения
7. Логируйте используемую конфигурацию при запуске
8. Тестируйте конфигурации для всех окружений

## Примеры использования

```dart
// Базовый класс конфигурации
abstract class AppConfig {
  String get baseUrl;
  String get apiKey;
  bool get isDebug;
  String get environmentName;
  int get apiTimeout;
  bool get enableAnalytics;
  
  factory AppConfig() => _getConfig();
  
  static AppConfig _getConfig() {
    const env = String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
    
    switch (env) {
      case 'prod':
        return ProdConfig();
      case 'staging':
        return StagingConfig();
      case 'dev':
      default:
        return DevConfig();
    }
  }
}
// Development конфигурация
class DevConfig implements AppConfig {
  @override
  String get baseUrl => 'https://dev.api.example.com';
  
  @override
  String get apiKey => 'dev_api_key_123';
  
  @override
  bool get isDebug => true;
  
  @override
  String get environmentName => 'Development';
  
  @override
  int get apiTimeout => 30000;
  
  @override
  bool get enableAnalytics => false;
  
  // Development-specific properties
  bool get enableDebugTools => true;
  bool get useMockData => true;
  String get logLevel => 'verbose';
}
// Production конфигурация
class ProdConfig implements AppConfig {
  @override
  String get baseUrl => 'https://api.example.com';
  
  @override
  String get apiKey => const String.fromEnvironment('PROD_API_KEY');
  
  @override
  bool get isDebug => false;
  
  @override
  String get environmentName => 'Production';
  
  @override
  int get apiTimeout => 15000;
  
  @override
  bool get enableAnalytics => true;
  
  // Production-specific properties
  bool get enablePerformanceMonitoring => true;
  bool get enableCrashReporting => true;
  String get logLevel => 'warning';
}
// Использование конфигурации в приложении
class ApiClient {
  final AppConfig config;
  
  ApiClient(this.config);
  
  Future<Response> makeRequest() async {
    final dio = Dio(BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: Duration(milliseconds: config.apiTimeout),
      headers: {
        'Authorization': 'Bearer ${config.apiKey}',
        'X-Environment': config.environmentName,
      },
    ));
    
    return await dio.get('/endpoint');
  }
}

// В main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализация с правильной конфигурацией
  final config = AppConfig();
  print('Starting app with environment: ${config.environmentName}');
  
  runApp(MyApp(config: config));
}
// Утилита для работы с конфигурациями
class ConfigReader {
  static bool validateConfig(AppConfig config) {
    final errors = <String>[];
    
    if (config.baseUrl.isEmpty) {
      errors.add('Base URL cannot be empty');
    }
    
    if (config.apiKey.isEmpty) {
      errors.add('API key cannot be empty');
    }
    
    if (config.apiTimeout <= 0) {
      errors.add('API timeout must be positive');
    }
    
    if (errors.isNotEmpty) {
      throw ConfigValidationException(errors);
    }
    
    return true;
  }
  
  static void logConfig(AppConfig config) {
    Logger.info('''
    App Configuration:
    - Environment: ${config.environmentName}
    - Base URL: ${config.baseUrl}
    - Debug: ${config.isDebug}
    - Analytics: ${config.enableAnalytics}
    - Timeout: ${config.apiTimeout}ms
    ''');
  }
}