// ================================
// 🏛️ SHARED ENTITY - БАЗОВЫЕ ДОМЕННЫЕ СУЩНОСТИ И БИЗНЕС-ЛОГИКА
// ================================

// ================================
// 🎯 БАЗОВЫЕ АБСТРАКТНЫЕ КЛАССЫ
// ================================

/// 🏗️ АБСТРАКТНЫЙ КЛАСС ДЛЯ ВСЕХ СУЩНОСТЕЙ (ENTITY)
///
/// ## 🏛️ АРХИТЕКТУРНЫЕ ПРИНЦИПЫ:
/// - **Identity-based equality** - сравнение по идентификатору
/// - **Immutable by design** - все поля final
/// - **Business invariants** - гарантия целостности бизнес-правил
/// - **Domain-driven design** - соответствие DDD принципам
abstract class Entity<T> {
  /// 🔑 УНИКАЛЬНЫЙ ИДЕНТИФИКАТОР СУЩНОСТИ
  final T id;

  /// 🏷️ ВЕРСИЯ СУЩНОСТИ ДЛЯ OPTIMISTIC CONCURRENCY
  final int version;

  /// 🕐 TIMESTAMP СОЗДАНИЯ СУЩНОСТИ (UTC)
  final DateTime createdAt;

  /// 🔄 TIMESTAMP ПОСЛЕДНЕГО ОБНОВЛЕНИЯ (UTC)
  final DateTime updatedAt;

  /// 🏗️ БАЗОВЫЙ КОНСТРУКТОР ДЛЯ ВСЕХ СУЩНОСТЕЙ
  const Entity({
    required this.id,
    this.version = 1,
    required this.createdAt,
    required this.updatedAt,
  });

  /// ✅ ВАЛИДАЦИЯ БИЗНЕС-ИНВАРИАНТОВ СУЩНОСТИ
  void validateInvariants();

  /// 🔄 ОБНОВЛЕНИЕ ВЕРСИИ И TIMESTAMP ПРИ ИЗМЕНЕНИЯХ
  Entity<T> markAsUpdated() {
    return _copyWith(version: version + 1, updatedAt: DateTime.now().toUtc());
  }

  /// 🏭 АБСТРАКТНЫЙ МЕТОД ДЛЯ COPY-WITH ПАТТЕРНА
  Entity<T> _copyWith({int? version, DateTime? updatedAt});

  /// ⚖️ IDENTITY-BASED EQUALITY (ПО ИДЕНТИФИКАТОРУ)
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Entity<T> &&
            runtimeType == other.runtimeType &&
            id == other.id;
  }

  /// 🔑 HASHCODE НА ОСНОВЕ ИДЕНТИФИКАТОРА
  @override
  int get hashCode => id.hashCode;

  /// 📝 СТАНДАРТНОЕ СТРОКОВОЕ ПРЕДСТАВЛЕНИЕ
  @override
  String toString() {
    return '$runtimeType(id: $id, version: $version)';
  }
}

/// 🎯 АБСТРАКТНЫЙ КЛАСС ДЛЯ VALUE OBJECTS (ОБЪЕКТЫ-ЗНАЧЕНИЯ)
///
/// ## 🏛️ АРХИТЕКТУРНЫЕ ПРИНЦИПЫ:
/// - **Value-based equality** - сравнение по всем полям
/// - **Immutable by design** - неизменяемость гарантирована
/// - **Self-validation** - валидация при создании
/// - **No identity** - не имеют идентификатора
abstract class ValueObject<T> {
  /// 💾 ВНУТРЕННЕЕ ЗНАЧЕНИЕ VALUE OBJECT
  final T _value;

  /// 🏗️ КОНСТРУКТОР С АВТОМАТИЧЕСКОЙ ВАЛИДАЦИЕЙ
  ValueObject(this._value) {
    _validate(_value);
  }

  /// ✅ АБСТРАКТНЫЙ МЕТОД ВАЛИДАЦИИ ЗНАЧЕНИЯ
  void _validate(T value);

  /// 🔒 ПУБЛИЧНЫЙ ДОСТУП К ЗНАЧЕНИЮ (READ-ONLY)
  T get value => _value;

  /// 🎯 ПРОВЕРКА НА NULL ИЛИ ПУСТОЕ ЗНАЧЕНИЕ
  bool get isEmpty {
    if (_value == null) return true;
    if (_value is String) return (_value as String).isEmpty;
    if (_value is List) return (_value as List).isEmpty;
    if (_value is Map) return (_value as Map).isEmpty;
    return false;
  }

  /// ✅ ПРОВЕРКА НА НЕ-NULL И НЕ-ПУСТОЕ ЗНАЧЕНИЕ
  bool get isNotEmpty => !isEmpty;

  /// ⚖️ VALUE-BASED EQUALITY (ПО ЗНАЧЕНИЮ)
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ValueObject<T> &&
            runtimeType == other.runtimeType &&
            _value == other._value;
  }

  /// 🔑 HASHCODE НА ОСНОВЕ ЗНАЧЕНИЯ
  @override
  int get hashCode => _value.hashCode;

  /// 📝 ИНФОРМАТИВНОЕ СТРОКОВОЕ ПРЕДСТАВЛЕНИЕ
  @override
  String toString() {
    return '$runtimeType($_value)';
  }
}

// ================================
// 🎯 КОНКРЕТНЫЕ VALUE OBJECT РЕАЛИЗАЦИИ
// ================================

/// 📧 VALUE OBJECT ДЛЯ EMAIL АДРЕСА
///
/// ## 🎯 BUSINESS RULES:
/// - Должен соответствовать RFC 5322
/// - Должен иметь валидный domain
/// - Должен быть в lowercase для нормализации
/// - Максимальная длина: 254 characters
class Email extends ValueObject<String> {
  /// 📧 REGEX ДЛЯ ВАЛИДАЦИИ EMAIL ФОРМАТА
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  /// 🏗️ КОНСТРУКТОР С НОРМАЛИЗАЦИЕЙ EMAIL
  Email(String value) : super(value.toLowerCase());

  /// ✅ ВАЛИДАЦИЯ EMAIL АДРЕСА
  @override
  void _validate(String value) {
    if (value.isEmpty) {
      throw InvalidEmailException('Email cannot be empty');
    }

    if (value.length > 254) {
      throw InvalidEmailException('Email cannot exceed 254 characters');
    }

    if (!_emailRegex.hasMatch(value)) {
      throw InvalidEmailException('Invalid email format: $value');
    }

    final parts = value.split('@');
    if (parts.length != 2 || parts[1].isEmpty) {
      throw InvalidEmailException('Email must contain a domain part');
    }
  }

  /// 🌐 ИЗВЛЕЧЕНИЕ DOMAIN ИЗ EMAIL
  String get domain {
    return value.split('@')[1];
  }

  /// 👤 ИЗВЛЕЧЕНИЕ LOCAL PART ИЗ EMAIL
  String get localPart {
    return value.split('@')[0];
  }

  /// 🔒 ПРОВЕРКА ЯВЛЯЕТСЯ ЛИ EMAIL DISPOSABLE
  bool get isDisposable {
    const disposableDomains = {
      'tempmail.com',
      'throwawaymail.com',
      'guerrillamail.com',
    };
    return disposableDomains.contains(domain);
  }
}

/// 📞 VALUE OBJECT ДЛЯ НОМЕРА ТЕЛЕФОНА
///
/// ## 🎯 BUSINESS RULES:
/// - Формат E.164 (например, +71234567890)
/// - Валидация country code
/// - Нормализация к международному формату
class PhoneNumber extends ValueObject<String> {
  /// 🏗️ КОНСТРУКТОР С НОРМАЛИЗАЦИЕЙ НОМЕРА
  PhoneNumber(String value) : super(_normalizePhoneNumber(value));

  /// ✅ ВАЛИДАЦИЯ НОМЕРА ТЕЛЕФОНА
  @override
  void _validate(String value) {
    if (value.isEmpty) {
      throw InvalidPhoneNumberException('Phone number cannot be empty');
    }

    if (!value.startsWith('+')) {
      throw InvalidPhoneNumberException(
        'Phone number must start with country code (e.g., +7)',
      );
    }

    final digits = value.substring(1);
    if (digits.isEmpty) {
      throw InvalidPhoneNumberException(
        'Phone number must contain digits after country code',
      );
    }

    if (!RegExp(r'^\d+$').hasMatch(digits)) {
      throw InvalidPhoneNumberException(
        'Phone number can only contain digits after country code',
      );
    }

    if (digits.length < 8 || digits.length > 15) {
      throw InvalidPhoneNumberException(
        'Phone number must be between 8 and 15 digits',
      );
    }

    final countryCode = value.substring(1, 3);
    if (!_isValidCountryCode(countryCode)) {
      throw InvalidPhoneNumberException('Invalid country code: $countryCode');
    }
  }

  /// 🇷🇺 НОРМАЛИЗАЦИЯ НОМЕРА ТЕЛЕФОНА
  static String _normalizePhoneNumber(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^\d]'), '');

    if (digits.startsWith('8') && digits.length == 11) {
      return '+7${digits.substring(1)}';
    }

    if (digits.length == 10) {
      return '+7$digits';
    }

    if (digits.length == 11 && digits.startsWith('7')) {
      return '+$digits';
    }

    return '+$digits';
  }

  /// 🌍 ПРОВЕРКА ВАЛИДНОСТИ COUNTRY CODE
  static bool _isValidCountryCode(String code) {
    final validCountryCodes = {'1', '7', '44', '49', '33', '39', '34', '86'};
    return validCountryCodes.contains(code);
  }

  /// 🇷🇺 ПРОВЕРКА ЯВЛЯЕТСЯ ЛИ НОМЕР РОССИЙСКИМ
  bool get isRussian => value.startsWith('+7');

  /// 📱 ФОРМАТИРОВАННЫЙ НОМЕР ДЛЯ ОТОБРАЖЕНИЯ
  String get formatted {
    if (isRussian && value.length == 12) {
      final groups = RegExp(
        r'(\d{3})(\d{3})(\d{2})(\d{2})',
      ).firstMatch(value.substring(2));
      if (groups != null) {
        return '+7 (${groups[1]}) ${groups[2]}-${groups[3]}-${groups[4]}';
      }
    }
    return value;
  }
}

// ================================
// 🚨 ДОМЕННЫЕ ИСКЛЮЧЕНИЯ (DOMAIN EXCEPTIONS)
// ================================

/// 🚨 БАЗОВОЕ ДОМЕННОЕ ИСКЛЮЧЕНИЕ
///
/// ## 🎯 DESIGN PRINCIPLES:
/// - Checked exceptions для recoverable errors
/// - Rich error information для debugging
/// - Business context для user-friendly messages
abstract class DomainException implements Exception {
  final String message;
  final String domain;
  final DateTime timestamp;

  DomainException({
    required this.message,
    required this.domain,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  String toString() => '$runtimeType: $message';
}

/// 🚨 ИСКЛЮЧЕНИЕ ДЛЯ НЕВАЛИДНЫХ EMAIL АДРЕСОВ
class InvalidEmailException extends DomainException {
  InvalidEmailException(String message)
    : super(message: message, domain: 'Email');
}

/// 🚨 ИСКЛЮЧЕНИЕ ДЛЯ НЕВАЛИДНЫХ НОМЕРОВ ТЕЛЕФОНА
class InvalidPhoneNumberException extends DomainException {
  InvalidPhoneNumberException(String message)
    : super(message: message, domain: 'PhoneNumber');
}

/// 🚨 ИСКЛЮЧЕНИЕ ДЛЯ НАРУШЕНИЯ БИЗНЕС-ПРАВИЛ
class BusinessRuleViolationException extends DomainException {
  final String rule;

  BusinessRuleViolationException({required this.rule, required super.message})
    : super(domain: 'BusinessRule');

  @override
  String toString() => 'BusinessRuleViolationException: $rule - $message';
}
