// ================================
// 🎯 VALIDATORS
// ================================

/// Утилиты для валидации различных типов данных
///
/// Предоставляет набор статических методов для проверки:
/// - Email адресов
/// - Номеров телефонов
/// - Паролей (с политиками сложности)
/// - Обязательных полей
/// - Кастомных условий
///
/// Все методы возвращают [bool] или [String?] для удобства
/// использования с [TextFormField.validator]
class Validators {
  // ================================
  // 📧 EMAIL ВАЛИДАЦИЯ
  // ================================

  /// Регулярное выражение для валидации email
  /// Соответствует стандарту RFC 5322
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  /// Проверяет валидность email адреса
  ///
  /// Пример использования:
  /// ```dart
  /// final isValid = Validators.isEmail('test@example.com'); // true
  /// final isInvalid = Validators.isEmail('invalid-email'); // false
  /// ```
  static bool isEmail(String email) {
    return _emailRegex.hasMatch(email.trim());
  }

  /// Валидатор для TextFormField который возвращает сообщение об ошибке
  ///
  /// Пример использования:
  /// ```dart
  /// TextFormField(
  ///   validator: Validators.emailValidator,
  /// )
  /// ```
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Email обязателен';
    if (!isEmail(value)) return 'Введите корректный email';
    return null;
  }

  // ================================
  // 📱 ТЕЛЕФОН ВАЛИДАЦИЯ
  // ================================

  /// Регулярное выражение для валидации российских номеров телефонов
  /// Поддерживает форматы: +7..., 8..., 7...
  static final RegExp _phoneRegex = RegExp(
    r'^(\+7|7|8)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$',
  );

  /// Проверяет валидность номера телефона
  ///
  /// Пример использования:
  /// ```dart
  /// final isValid = Validators.isPhone('+79991234567'); // true
  /// final isInvalid = Validators.isPhone('123'); // false
  /// ```
  static bool isPhone(String phone) {
    return _phoneRegex.hasMatch(phone.replaceAll(RegExp(r'\s+'), ''));
  }

  /// Валидатор для TextFormField который возвращает сообщение об ошибке
  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) return 'Телефон обязателен';
    if (!isPhone(value)) return 'Введите корректный номер телефона';
    return null;
  }

  // ================================
  // 🔐 ПАРОЛЬ ВАЛИДАЦИЯ
  // ================================

  /// Проверяет сложность пароля по заданным критериям
  ///
  /// Параметры:
  /// - [password] - пароль для проверки
  /// - [minLength] - минимальная длина (по умолчанию 8)
  /// - [requireUppercase] - требовать заглавные буквы
  /// - [requireLowercase] - требовать строчные буквы
  /// - [requireNumbers] - требовать цифры
  /// - [requireSpecial] - требовать специальные символы
  ///
  /// Пример использования:
  /// ```dart
  /// final result = Validators.validatePassword(
  ///   'MyPass123!',
  ///   minLength: 8,
  ///   requireUppercase: true,
  /// );
  /// ```
  static PasswordValidationResult validatePassword(
    String password, {
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumbers = true,
    bool requireSpecial = false,
  }) {
    final errors = <String>[];

    if (password.length < minLength) {
      errors.add('Пароль должен содержать минимум $minLength символов');
    }

    if (requireUppercase && !password.contains(RegExp(r'[A-Z]'))) {
      errors.add('Пароль должен содержать заглавные буквы');
    }

    if (requireLowercase && !password.contains(RegExp(r'[a-z]'))) {
      errors.add('Пароль должен содержать строчные буквы');
    }

    if (requireNumbers && !password.contains(RegExp(r'[0-9]'))) {
      errors.add('Пароль должен содержать цифры');
    }

    if (requireSpecial &&
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      errors.add('Пароль должен содержать специальные символы');
    }

    return PasswordValidationResult(isValid: errors.isEmpty, errors: errors);
  }

  /// Валидатор пароля для TextFormField
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Пароль обязателен';

    final result = validatePassword(value);
    if (!result.isValid) {
      return result.errors.first;
    }

    return null;
  }

  // ================================
  // ✅ ОБЩИЕ ВАЛИДАТОРЫ
  // ================================

  /// Проверяет что строка не пустая
  ///
  /// Пример использования:
  /// ```dart
  /// TextFormField(
  ///   validator: Validators.required,
  /// )
  /// ```
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'Это поле обязательно для заполнения';
    }
    return null;
  }

  /// Проверяет минимальную длину строки
  static String? minLength(String? value, int min) {
    if (value == null || value.length < min) {
      return 'Минимальная длина: $min символов';
    }
    return null;
  }

  /// Проверяет максимальную длину строки
  static String? maxLength(String? value, int max) {
    if (value != null && value.length > max) {
      return 'Максимальная длина: $max символов';
    }
    return null;
  }

  /// Комбинирует несколько валидаторов
  ///
  /// Пример использования:
  /// ```dart
  /// TextFormField(
  ///   validator: Validators.combine([
  ///     Validators.required,
  ///     (value) => Validators.minLength(value, 3),
  ///   ]),
  /// )
  /// ```
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}

/// Результат валидации пароля
class PasswordValidationResult {
  final bool isValid;
  final List<String> errors;

  const PasswordValidationResult({required this.isValid, required this.errors});
}
