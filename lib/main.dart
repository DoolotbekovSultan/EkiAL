// ================================
// 🚀 MAIN - ТОЧКА ВХОДА
// ================================

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/core/di/injector.dart';
import 'src/core/utils/log_utils.dart';

void main() async {
  // Инициализация Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация логирования
  Log.initialize(level: Level.debug);

  try {
    Log.i('🚀 Запуск приложения Eki Al');

    // Инициализация Dependency Injection
    Log.d('🔧 Инициализация DI контейнера...');
    await configureDependencies(environment: Environment.dev);

    // Проверка зависимостей
    _validateDependencies();

    Log.i('✅ Все системы инициализированы, запуск приложения...');

    // Запуск приложения
    runApp(const MyApp());
  } catch (e, stackTrace) {
    Log.e(
      '💥 Критическая ошибка запуска приложения',
      error: e,
      stackTrace: stackTrace,
    );

    // В критических случаях можно показать ошибку пользователю
    runApp(CrashApp(error: e));
  }
}

/// Проверка что все критические зависимости зарегистрированы
void _validateDependencies() {
  final criticalDeps = <Type>[Dio, SharedPreferences, Connectivity];

  for (final dep in criticalDeps) {
    if (!_isDependencyRegistered(dep)) {
      Log.w('⚠️ Зависимость $dep не зарегистрирована');
    }
  }

  Log.i('✅ Проверка критических зависимостей завершена');
}

/// Вспомогательный метод для проверки регистрации зависимости
bool _isDependencyRegistered(Type type) {
  try {
    // Используем reflection-подобный подход через GetIt
    return getIt.isRegistered(type: type);
  } catch (e) {
    Log.w('⚠️ Ошибка при проверке зависимости $type: $e');
    return false;
  }
}

/// Приложение для отображения ошибки запуска
class CrashApp extends StatelessWidget {
  final Object error;

  const CrashApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '💥 Ошибка запуска',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Пожалуйста, перезапустите приложение',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),
                Text(
                  'Код ошибки: ${error.toString()}',
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Основное приложение
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Log.i('🎨 Построение основного приложения');

    return MaterialApp(
      title: 'Eki Al',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Log.navigation('main', 'home_page');

    return Scaffold(
      appBar: AppBar(title: const Text('Eki Al - Готов к разработке! 🚀')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '🎯 Инфраструктура готова',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildFeatureItem('DI контейнер настроен ✅'),
              _buildFeatureItem('Логирование работает ✅'),
              _buildFeatureItem('Сетевой слой готов ✅'),
              _buildFeatureItem('Утилиты загружены ✅'),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Log.i('🎯 Пользователь нажал кнопку');
                  // Тестируем логирование
                  _testLogging();
                },
                child: const Text('Тест логирования'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  void _testLogging() {
    // Демонстрация всех уровней логирования
    Log.t('🔍 Детальное отслеживание');
    Log.d('🐛 Отладочная информация');
    Log.i('📝 Общая информация');
    Log.w('⚠️ Предупреждение');

    // Имитация ошибки для демонстрации
    try {
      throw Exception('Тестовая ошибка для демонстрации логирования');
    } catch (e, stackTrace) {
      Log.e('❌ Ошибка', error: e, stackTrace: stackTrace);
    }

    // Специализированное логирование
    Log.network(method: 'GET', url: '/api/test');
    Log.bloc('TestBloc', 'ButtonPressed', state: 'Loading');
    Log.navigation('home', 'details', arguments: {'id': 123});

    // Профилирование
    final result = Log.measure('heavy_operation', () {
      // Имитация тяжелой операции
      var sum = 0;
      for (var i = 0; i < 1000000; i++) {
        sum += i;
      }
      return 'Результат: $sum';
    });

    Log.i('📊 Результат тяжелой операции: $result');

    // Асинхронное профилирование
    Log.measureAsync('async_operation', () async {
      await Future.delayed(const Duration(milliseconds: 100));
      return 'Асинхронный результат';
    }).then((result) {
      Log.i('📊 Асинхронный результат: $result');
    });
  }
}
