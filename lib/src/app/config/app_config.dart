// ================================
// 🔄 RE-EXPORT - ОБРАТНАЯ СОВМЕСТИМОСТЬ
// ================================
//
// Этот файл реэкспортирует AppConfig из core/config/ для обратной совместимости.
// ВАЖНО: Используйте импорты из core/config/ в новом коде!
//
// ❌ НЕ ИСПОЛЬЗУЙТЕ:
//   import 'package:eki_al/src/app/config/app_config.dart';
//
// ✅ ИСПОЛЬЗУЙТЕ:
//   import 'package:eki_al/src/core/config/app_config.dart';

export 'package:eki_al/src/core/config/app_config.dart';
export 'package:eki_al/src/core/config/config_reader.dart';
export 'package:eki_al/src/core/config/dev_config.dart';
export 'package:eki_al/src/core/config/prod_config.dart';
export 'package:eki_al/src/core/config/staging_config.dart';
