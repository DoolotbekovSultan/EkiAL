// ================================
// 🎯 INJECTOR - ОСНОВНОЙ DI КОНТЕЙНЕР
// ================================

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/log_utils.dart';
import '../auth/auth_service.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../network/interceptors/retry_interceptor.dart';
import 'network_module.dart';

// Импорт сгенерированного файла
import 'injector.config.dart';

/// Глобальный DI контейнер приложения
///
/// Использует GetIt + Injectable для управления зависимостями
///
/// Примеры использования:
/// ```dart
/// // Получение зависимостей
/// final dio = getIt<Dio>();
/// final repository = getIt<UserRepository>();
///
/// // Безопасное получение
/// final service = getIt.tryGet<MyService>();
///
/// // Проверка регистрации
/// if (getIt.isRegistered<AuthService>()) {
///   final auth = getIt<AuthService>();
/// }
/// ```
final GetIt getIt = GetIt.instance;

/// Инициализация Dependency Injection системы
///
/// Должен вызываться в main() перед runApp()
///
/// Пример:
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await configureDependencies(environment: Environment.dev);
///   runApp(MyApp());
/// }
/// ```
@injectableInit
Future<void> configureDependencies({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
  // ================================
  // 🏗️ ИНИЦИАЛИЗАЦИЯ DI СИСТЕМЫ
  // ================================

  Log.i('🎯 Инициализация DI контейнера', error: 'Окружение: $environment');

  try {
    // Инициализация автогенерируемых зависимостей
    Log.d('🔧 Запуск кодогенерации Injectable...');

    await getIt.init(
      environment: environment,
      environmentFilter: environmentFilter,
    );

    // Ручная регистрация асинхронных зависимостей
    await _registerManualDependencies();

    // Валидация зарегистрированных зависимостей
    _validateCoreDependencies();

    // Настройка интерцепторов для Dio
    await _configureNetworkInterceptors();

    Log.i('✅ DI контейнер успешно инициализирован');
  } catch (e, stackTrace) {
    Log.e('💥 Ошибка инициализации DI', error: e, stackTrace: stackTrace);
    rethrow;
  }
}

// ================================
// 🔧 РУЧНАЯ РЕГИСТРАЦИЯ ЗАВИСИМОСТЕЙ
// ================================

/// Регистрация зависимостей, требующих ручной настройки
Future<void> _registerManualDependencies() async {
  Log.d('🔧 Регистрация ручных зависимостей...');

  // 🚨 ЗАКОМЕНТИРОВАНО ЭТО - injectable уже зарегистрировал SharedPreferences
  // final sharedPreferences = await SharedPreferences.getInstance();
  // getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  Log.d('✅ SharedPreferences зарегистрирован');
}

// ================================
// 🌐 НАСТРОЙКА СЕТЕВЫХ ИНТЕРЦЕПТОРОВ
// ================================

/// Настройка интерцепторов для Dio клиента
Future<void> _configureNetworkInterceptors() async {
  Log.d('🔧 Настройка сетевых интерцепторов...');

  try {
    final dio = getIt<Dio>();

    // Получаем фабрики для создания интерцепторов
    final retryInterceptorFactory = getIt.tryGet<RetryInterceptorFactory>();
    final authInterceptorFactory = getIt.tryGet<AuthInterceptorFactory>();

    // Создаем RetryInterceptor
    RetryInterceptor? retryInterceptor;
    if (retryInterceptorFactory != null) {
      retryInterceptor = retryInterceptorFactory.create();
      Log.d('✅ RetryInterceptor создан');
    } else {
      Log.w('⚠️ RetryInterceptorFactory не найден в DI');
    }

    // Создаем AuthInterceptor (требует AuthService)
    AuthInterceptor? authInterceptor;
    if (authInterceptorFactory != null) {
      // Проверяем наличие AuthService
      final authService = getIt.tryGet<AuthService>();
      if (authService != null) {
        authInterceptor = authInterceptorFactory.create(
          getToken: () => authService.getToken(),
          refreshToken: () => authService.refreshToken(),
          onTokenExpired: () => authService.onTokenExpired(),
        );
        Log.d('✅ AuthInterceptor создан с AuthService');
      } else {
        Log.w('⚠️ AuthService не найден, AuthInterceptor не будет добавлен');
        Log.w(
          '💡 Для использования AuthInterceptor зарегистрируйте AuthService в DI',
        );
      }
    } else {
      Log.w('⚠️ AuthInterceptorFactory не найден в DI');
    }

    // Настраиваем интерцепторы через DioInterceptorConfigurator
    DioInterceptorConfigurator.configureInterceptors(
      dio,
      retryInterceptor: retryInterceptor,
      authInterceptor: authInterceptor,
    );

    Log.i('✅ Сетевые интерцепторы настроены');
  } catch (e, stackTrace) {
    Log.e(
      '❌ Ошибка настройки сетевых интерцепторов',
      error: e,
      stackTrace: stackTrace,
    );
    // Не прерываем инициализацию, приложение может работать без интерцепторов
  }
}

// ================================
// ✅ ВАЛИДАЦИЯ ЗАВИСИМОСТЕЙ
// ================================

/// Проверка что все основные зависимости зарегистрированы
void _validateCoreDependencies() {
  final coreDependencies = <Type>[
    Dio,
    Connectivity,
    SharedPreferences,
  ]; // Убрал Log из списка

  final missingDependencies = <Type>[];

  for (final type in coreDependencies) {
    if (!getIt.isRegistered(type: type)) {
      missingDependencies.add(type);
    }
  }

  if (missingDependencies.isNotEmpty) {
    final error = '❌ Отсутствуют зависимости: $missingDependencies';
    Log.e(error);
    throw Exception(error);
  }

  // Логируем успешную регистрацию
  Log.i(
    '✅ Проверка зависимостей завершена',
    error:
        '''
• Dio: ${getIt.isRegistered<Dio>() ? '✅' : '❌'}
• Connectivity: ${getIt.isRegistered<Connectivity>() ? '✅' : '❌'}
• SharedPreferences: ${getIt.isRegistered<SharedPreferences>() ? '✅' : '❌'}
• Log: ${getIt.isRegistered<Log>() ? '✅' : '❌'}
''',
  );
}

// ================================
// 🎯 УТИЛИТЫ ДЛЯ РАБОТЫ С DI
// ================================

/// Расширения для безопасной работы с GetIt
extension GetItExtensions on GetIt {
  /// 🔒 Безопасное получение зависимости (возвращает null если не зарегистрирована)
  T? tryGet<T extends Object>({
    String? instanceName,
    Object? param1,
    Object? param2,
  }) {
    try {
      if (isRegistered<T>(instanceName: instanceName)) {
        return get<T>(
          instanceName: instanceName,
          param1: param1,
          param2: param2,
        );
      }
      return null;
    } catch (e, stackTrace) {
      Log.w(
        '⚠️ Ошибка при получении зависимости $T',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// 🔄 Получение зависимости или значения по умолчанию
  T getOrDefault<T extends Object>(T defaultValue, {String? instanceName}) {
    return tryGet<T>(instanceName: instanceName) ?? defaultValue;
  }

  /// 🧪 Проверка регистрации зависимости с логированием
  bool isRegisteredWithLog<T extends Object>({String? instanceName}) {
    final isRegistered = this.isRegistered<T>(instanceName: instanceName);
    if (!isRegistered) {
      Log.w('⚠️ Зависимость $T не зарегистрирована');
    }
    return isRegistered;
  }
}

// ================================
// 🚀 SERVICE LOCATOR WRAPPER
// ================================

/// Упрощенный интерфейс для работы с DI
class DI {
  /// 📦 Получение зависимости
  static T get<T extends Object>({
    String? instanceName,
    Object? param1,
    Object? param2,
  }) {
    Log.t(
      '📦 Получение зависимости: $T',
      error: instanceName != null ? 'Имя: $instanceName' : null,
    );
    return getIt.get<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
    );
  }

  /// 🔒 Безопасное получение зависимости
  static T? tryGet<T extends Object>({
    String? instanceName,
    Object? param1,
    Object? param2,
  }) {
    return getIt.tryGet<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
    );
  }

  /// ✅ Проверка регистрации
  static bool has<T extends Object>({String? instanceName}) {
    return getIt.isRegistered<T>(instanceName: instanceName);
  }

  /// ✅ Проверка регистрации по Type
  static bool hasType(Type type, {String? instanceName}) {
    return getIt.isRegistered(type: type, instanceName: instanceName);
  }

  /// 🏷️ Регистрация синглтона
  static void registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    bool signalsReady = false,
    Future<void> Function(T)? dispose,
  }) {
    getIt.registerSingleton<T>(
      instance,
      instanceName: instanceName,
      signalsReady: signalsReady,
      dispose: dispose,
    );
    Log.d('✅ Зарегистрирован синглтон: $T');
  }

  /// 🏭 Регистрация фабрики
  static void registerFactory<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
  }) {
    getIt.registerFactory<T>(factoryFunc, instanceName: instanceName);
    Log.d('✅ Зарегистрирована фабрика: $T');
  }

  /// 🦥 Регистрация ленивого синглтона
  static void registerLazySingleton<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
    Future<void> Function(T)? dispose,
  }) {
    getIt.registerLazySingleton<T>(
      factoryFunc,
      instanceName: instanceName,
      dispose: dispose,
    );
    Log.d('✅ Зарегистрирован ленивый синглтон: $T');
  }
}

// ================================
// 🧪 ТЕСТОВЫЕ УТИЛИТЫ
// ================================

/// Утилиты для тестирования DI
class DITestUtils {
  /// 🧹 Сброс DI контейнера (для тестов)
  static void reset() {
    Log.i('🧹 Сброс DI контейнера');
    getIt.reset();
  }

  /// 🎭 Регистрация mock зависимостей
  static void registerMocks(Map<Type, Object> mocks) {
    for (final entry in mocks.entries) {
      getIt.registerSingleton(entry.value);
    }
    Log.i('🎭 Зарегистрированы mock зависимости: ${mocks.keys}');
  }

  /// ✅ Тестирование разрешения зависимостей
  static void testDependencyResolution(List<Type> dependencies) {
    Log.i('🧪 Тестирование разрешения зависимостей...');

    for (final type in dependencies) {
      try {
        final instance = getIt.get<Object>(instanceName: type.toString());
        Log.d('✅ $type → ${instance.runtimeType}');
      } catch (e) {
        Log.e('❌ $type → Ошибка: $e');
      }
    }
  }
}

// ================================
// 🎯 КОНФИГУРАЦИЯ ОКРУЖЕНИЙ
// ================================

/// Кастомные окружения для DI
class Environments {
  static const dev = 'dev';
  static const staging = 'staging';
  static const prod = 'prod';
  static const test = 'test';
}

/// Аннотации для окружений
const dev = Environment(Environments.dev);
const staging = Environment(Environments.staging);
const prod = Environment(Environments.prod);
const test = Environment(Environments.test);
