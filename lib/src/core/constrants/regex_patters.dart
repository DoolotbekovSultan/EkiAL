/// 🔍 РЕГУЛЯРНЫЕ ВЫРАЖЕНИЯ ДЛЯ ВАЛИДАЦИИ
///
/// Содержит паттерны для email, телефонов, паролей и других форматов данных
abstract class RegexPatterns {
  /// Паттерн для валидации email адресов
  static const String email =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  /// Паттерн для валидации международных номеров телефонов
  static const String phone = r'^\+?[1-9]\d{1,14}$';

  /// Паттерн для валидации паролей
  static const String password =
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$';

  /// Паттерн для валидации имен
  static const String name = r"^[a-zA-Zа-яА-ЯёЁ\s\-']+$";

  /// Паттерн для валидации дат в формате YYYY-MM-DD
  static const String date = r'^\d{4}-\d{2}-\d{2}$';

  /// Паттерн для проверки что строка содержит только цифры
  static const String numbersOnly = r'^[0-9]+$';

  /// Паттерн для валидации URL адресов
  static const String url = r'^(https?://)?([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$';
}

/// 🛠️ УТИЛИТЫ ДЛЯ РАБОТЫ С РЕГУЛЯРНЫМИ ВЫРАЖЕНИЯМИ
class RegexUtils {
  /// Проверяет является ли строка валидным email адресом
  static bool isEmail(String input) =>
      RegExp(RegexPatterns.email).hasMatch(input);

  /// Проверяет является ли строка валидным номером телефона
  static bool isPhone(String input) =>
      RegExp(RegexPatterns.phone).hasMatch(input);

  /// Проверяет соответствует ли пароль требованиям безопасности
  static bool isPassword(String input) =>
      RegExp(RegexPatterns.password).hasMatch(input);

  /// Проверяет является ли строка валидным именем
  static bool isName(String input) =>
      RegExp(RegexPatterns.name).hasMatch(input);

  /// Проверяет является ли строка валидной датой
  static bool isDate(String input) =>
      RegExp(RegexPatterns.date).hasMatch(input);

  /// Проверяет содержит ли строка только цифры
  static bool isNumbersOnly(String input) =>
      RegExp(RegexPatterns.numbersOnly).hasMatch(input);
}
