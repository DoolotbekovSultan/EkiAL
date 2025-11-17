// ================================
// 🔐 AUTH MODULE - МОДУЛЬ АУТЕНТИФИКАЦИИ
// ================================

import 'package:injectable/injectable.dart';

/// 🎯 МОДУЛЬ ДЛЯ ФИЧИ АУТЕНТИФИКАЦИИ
///
/// 📋 ИНСТРУКЦИЯ ПО РЕАЛИЗАЦИИ:
/// 1. Создайте интерфейс в domain/repositories/i_auth_repository.dart
/// 2. Реализуйте репозиторий в data/repositories/auth_repository.dart
/// 3. Создайте use cases в domain/use_cases/auth/
/// 4. Создайте BLoC в presentation/bloc/auth/
/// 5. Раскомментируйте зависимости ниже
///
/// 🏗️ СТРУКТУРА ФИЧИ:
/// features/auth/
/// ├── data/              📊 Данные
/// ├── domain/            🧠 Логика
/// └── presentation/      🖼️ UI
@module
abstract class AuthModule {
  // ================================
  // 📦 РЕПОЗИТОРИИ (раскомментировать после реализации)
  // ================================

  /// Репозиторий аутентификации
  ///
  /// Требует реализации:
  /// - IAuthRepository в domain/repositories/
  /// - AuthRepositoryImpl в data/repositories/
  // @singleton
  // IAuthRepository get authRepository => AuthRepositoryImpl();

  // ================================
  // 🎯 USE CASES (раскомментировать после реализации)
  // ================================

  /// Use case для входа в систему
  ///
  /// Требует:
  /// - LoginUseCase в domain/use_cases/auth/
  /// - IAuthRepository (репозиторий)
  // @singleton
  // LoginUseCase get loginUseCase => LoginUseCase(getIt());

  /// Use case для регистрации
  // @singleton
  // RegisterUseCase get registerUseCase => RegisterUseCase(getIt());

  /// Use case для выхода из системы
  // @singleton
  // LogoutUseCase get logoutUseCase => LogoutUseCase(getIt());

  /// Use case для обновления токена
  // @singleton
  // RefreshTokenUseCase get refreshTokenUseCase => RefreshTokenUseCase(getIt());

  // ================================
  // 🎛️ BLoC / CUBIT (раскомментировать после реализации)
  // ================================

  /// BLoC для управления состоянием аутентификации
  ///
  /// Требует:
  /// - AuthBloc в presentation/bloc/auth/
  /// - Все необходимые use cases
  // @singleton
  // AuthBloc get authBloc => AuthBloc(
  //       loginUseCase: getIt(),
  //       logoutUseCase: getIt(),
  //       refreshTokenUseCase: getIt(),
  //     );

  // ================================
  // 🔧 СЕРВИСЫ (раскомментировать при необходимости)
  // ================================

  /// Сервис для работы с токенами
  ///
  /// Используется для хранения/получения JWT токенов
  // @singleton
  // TokenService get tokenService => TokenService(getIt());

  /// Сервис биометрии
  ///
  /// Для поддержки Touch ID / Face ID / отпечатков
  // @singleton
  // BiometricService get biometricService => BiometricService();
}
