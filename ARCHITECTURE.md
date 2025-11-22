# 🏗️ Архитектура проекта Eki Al

## 📋 Содержание
1. [Обзор архитектуры](#обзор-архитектуры)
2. [Структура проекта](#структура-проекта)
3. [Слои архитектуры](#слои-архитектуры)
4. [Технологический стек](#технологический-стек)
5. [Потоки данных](#потоки-данных)
6. [Dependency Injection](#dependency-injection)
7. [Навигация](#навигация)
8. [Проверка архитектуры](#проверка-архитектуры)

---

## 🎯 Обзор архитектуры

Проект **Eki Al** построен на принципах **Clean Architecture** с использованием **Feature-First** подхода.

### Основные принципы:
- ✅ **Разделение ответственности** - четкое разделение на слои
- ✅ **Независимость** - фичи изолированы друг от друга
- ✅ **Тестируемость** - каждый компонент тестируется изолированно
- ✅ **Масштабируемость** - легко добавлять новые фичи
- ✅ **Поддерживаемость** - понятная структура кода

### Направление зависимостей:
```
Presentation → Domain ← Data
     ↓              ↓
   Shared        Core
```

---

## 📁 Структура проекта

```
eki_al/
├── lib/
│   ├── main.dart                    # Точка входа приложения
│   └── src/
│       ├── app/                     # 📱 Конфигурация приложения
│       │   ├── app.dart
│       │   ├── bootstrap/           # 🚀 Инициализация
│       │   │   ├── app_initializer.dart
│       │   │   ├── data_preloader.dart
│       │   │   └── service_configurator.dart
│       │   ├── config/             # 🔄 Re-export (см. core/config/)
│       │   │   └── app_config.dart
│       │   └── navigation/          # 🧭 Маршрутизация
│       │       ├── app_router.dart
│       │       ├── app_router.gr.dart
│       │       ├── route_guards.dart
│       │       ├── route_names.dart
│       │       └── navigation_utils.dart
│       │
│       ├── core/                    # 🎯 Фундаментальные компоненты
│       │   ├── config/              # ⚙️ Конфигурация приложения
│       │   │   ├── app_config.dart
│       │   │   ├── config_reader.dart
│       │   │   ├── dev_config.dart
│       │   │   ├── staging_config.dart
│       │   │   └── prod_config.dart
│       │   ├── common/              # 🔧 Базовые классы
│       │   │   ├── base_bloc.dart
│       │   │   ├── base_event.dart
│       │   │   ├── base_state.dart
│       │   │   ├── base_model.dart
│       │   │   ├── base_repository.dart
│       │   │   └── base_response.dart
│       │   ├── constrants/          # 📋 Константы
│       │   │   ├── app_constants.dart
│       │   │   ├── api_endpints.dart
│       │   │   ├── app_strings.dart
│       │   │   ├── enums.dart
│       │   │   ├── regex_patters.dart
│       │   │   ├── storage_keys.dart
│       │   │   └── widget_constants.dart
│       │   ├── di/                  # 💉 Dependency Injection
│       │   │   ├── injector.dart
│       │   │   ├── injector.config.dart
│       │   │   ├── app_module.dart
│       │   │   └── feature_modules/
│       │   │       ├── auth_module.dart
│       │   │       ├── user_module.dart
│       │   │       ├── product_module.dart
│       │   │       ├── order_module.dart
│       │   │       └── settings_module.dart
│       │   ├── exceptions/          # ⚠️ Обработка ошибок
│       │   │   ├── app_exceptions.dart
│       │   │   ├── network_exceptions.dart
│       │   │   ├── local_exceptions.dart
│       │   │   ├── failure.dart
│       │   │   └── exception_handler.dart
│       │   ├── extensions/          # 🔌 Расширения
│       │   │   ├── string_extentions.dart
│       │   │   ├── datetime_extentions.dart
│       │   │   ├── num_extention.dart
│       │   │   ├── list_extention.dart
│       │   │   ├── map_extentions.dart
│       │   │   ├── context_extentions.dart
│       │   │   └── widget_extensions.dart
│       │   ├── monitoring/          # 📊 Мониторинг
│       │   │   ├── analytics_service.dart
│       │   │   ├── crash_reporting_service.dart
│       │   │   ├── performance_monitor.dart
│       │   │   └── monitoring_module.dart
│       │   ├── network/             # 🌐 Сеть
│       │   │   ├── api_constants.dart
│       │   │   ├── dio_client.dart
│       │   │   ├── interceptors/
│       │   │   │   ├── auth_interceptor.dart
│       │   │   │   ├── error_interceptor.dart
│       │   │   │   ├── logging_interceptor.dart
│       │   │   │   └── retry_interceptor.dart
│       │   │   └── response_models/
│       │   ├── theme/               # 🎨 Тема
│       │   │   ├── app_theme.dart
│       │   │   ├── colors.dart
│       │   │   ├── text_styles.dart
│       │   │   ├── light_theme.dart
│       │   │   ├── dark_theme.dart
│       │   │   ├── theme_controller.dart
│       │   │   └── qap.dart
│       │   └── utils/               # 🛠️ Утилиты
│       │       ├── validators.dart
│       │       ├── formatters.dart
│       │       ├── date_utils.dart
│       │       ├── money_utils.dart
│       │       ├── device_utils.dart
│       │       ├── image_utils.dart
│       │       ├── debouncer.dart
│       │       └── log_utils.dart
│       │
│       ├── features/                 # 🚀 Функциональные модули
│       │   └── feature/              # 📦 Шаблон фичи
│       │       ├── data/            # 💾 Слой данных
│       │       │   ├── datasources/
│       │       │   │   ├── remote_data_source.dart
│       │       │   │   ├── local_data_source.dart
│       │       │   │   └── cache_data_source.dart
│       │       │   ├── models/      # DTO модели
│       │       │   │   └── model.dart
│       │       │   ├── mapper/      # Преобразователи
│       │       │   │   ├── model_mapper.dart
│       │       │   │   ├── enitity_mapper.dart
│       │       │   │   └── response_mapper.dart
│       │       │   └── repositories/ # Реализации репозиториев
│       │       │
│       │       ├── domain/          # 🏛️ Бизнес-логика
│       │       │   ├── entities/    # Сущности
│       │       │   │   ├── entity.dart
│       │       │   │   ├── aggregates/
│       │       │   │   └── value_objects/
│       │       │   ├── repositories/ # Интерфейсы репозиториев
│       │       │   ├── usecases/    # Сценарии использования
│       │       │   └── value_objects/ # Объекты-значения
│       │       │
│       │       └── presentation/    # 🖥️ UI слой
│       │           ├── pages/       # Страницы
│       │           ├── widgets/    # Виджеты
│       │           ├── blocs/      # BLoC
│       │           └── cubits/     # Cubit
│       │
│       └── shared/                   # 🔄 Общие компоненты
│           ├── domain/              # Общая доменная логика
│           │   └── entity.dart
│           ├── data/                # Общие данные
│           │   ├── datasources/
│           │   ├── models/
│           │   ├── mappers/
│           │   └── repositories/
│           └── presentation/       # Общие UI компоненты
│               └── shared_widget.dart
│
├── test/                            # 🧪 Тесты
├── android/                         # 🤖 Android конфигурация
├── ios/                             # 🍎 iOS конфигурация
├── web/                             # 🌐 Web конфигурация
├── linux/                           # 🐧 Linux конфигурация
├── macos/                           # 🍎 macOS конфигурация
├── windows/                          # 🪟 Windows конфигурация
├── pubspec.yaml                     # 📦 Зависимости
└── README.md                        # 📖 Документация

```

---

## 🏛️ Слои архитектуры

### 1. **Presentation Layer** (Слой представления)
**Назначение:** Пользовательский интерфейс и управление состоянием UI

**Компоненты:**
- `pages/` - Экраны приложения
- `widgets/` - Переиспользуемые виджеты
- `blocs/` / `cubits/` - Управление состоянием (BLoC паттерн)

**Зависимости:**
- ✅ Зависит от `domain/` (use cases, entities)
- ✅ Использует `core/` (theme, utils, extensions)
- ❌ НЕ зависит от `data/`

**Пример:**
```dart
// presentation/blocs/feature_bloc.dart
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final GetFeatureUseCase getFeatureUseCase;
  
  FeatureBloc(this.getFeatureUseCase) : super(FeatureInitial()) {
    on<LoadFeature>(_onLoadFeature);
  }
  
  Future<void> _onLoadFeature(
    LoadFeature event,
    Emitter<FeatureState> emit,
  ) async {
    emit(FeatureLoading());
    final result = await getFeatureUseCase(event.id);
    result.fold(
      (failure) => emit(FeatureError(failure)),
      (feature) => emit(FeatureLoaded(feature)),
    );
  }
}
```

---

### 2. **Domain Layer** (Слой бизнес-логики)
**Назначение:** Бизнес-логика и правила приложения

**Компоненты:**
- `entities/` - Бизнес-сущности (чистые Dart классы)
- `repositories/` - Интерфейсы репозиториев (абстракции)
- `usecases/` - Сценарии использования (бизнес-операции)
- `value_objects/` - Объекты-значения с валидацией

**Зависимости:**
- ✅ НЕ зависит от других слоев
- ✅ Только чистый Dart код
- ❌ НЕ зависит от Flutter

**Пример:**
```dart
// domain/entities/feature_entity.dart
class FeatureEntity {
  final String id;
  final String name;
  
  const FeatureEntity({
    required this.id,
    required this.name,
  });
}

// domain/repositories/feature_repository.dart
abstract class FeatureRepository {
  Future<Either<Failure, FeatureEntity>> getFeature(String id);
}

// domain/usecases/get_feature_usecase.dart
class GetFeatureUseCase {
  final FeatureRepository repository;
  
  GetFeatureUseCase(this.repository);
  
  Future<Either<Failure, FeatureEntity>> call(String id) {
    return repository.getFeature(id);
  }
}
```

---

### 3. **Data Layer** (Слой данных)
**Назначение:** Работа с данными (API, локальное хранилище)

**Компоненты:**
- `datasources/` - Источники данных (remote, local, cache)
- `models/` - DTO модели (JSON сериализация)
- `mapper/` - Преобразователи (Model → Entity)
- `repositories/` - Реализации репозиториев

**Зависимости:**
- ✅ Зависит от `domain/` (реализует интерфейсы)
- ✅ Использует `core/` (network, exceptions)
- ❌ НЕ зависит от `presentation/`

**Пример:**
```dart
// data/models/feature_model.dart
@JsonSerializable()
class FeatureModel {
  final String id;
  final String name;
  
  FeatureModel({required this.id, required this.name});
  
  factory FeatureModel.fromJson(Map<String, dynamic> json) =>
      _$FeatureModelFromJson(json);
}

// data/mapper/feature_mapper.dart
extension FeatureMapper on FeatureModel {
  FeatureEntity toEntity() {
    return FeatureEntity(
      id: id,
      name: name,
    );
  }
}

// data/repositories/feature_repository_impl.dart
@Injectable(as: FeatureRepository)
class FeatureRepositoryImpl implements FeatureRepository {
  final RemoteDataSource remoteDataSource;
  
  FeatureRepositoryImpl(this.remoteDataSource);
  
  @override
  Future<Either<Failure, FeatureEntity>> getFeature(String id) async {
    try {
      final model = await remoteDataSource.getFeature(id);
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
```

---

## 🛠️ Технологический стек

### Основные зависимости:
- **Flutter** - UI фреймворк
- **Dart 3.9.2+** - Язык программирования

### State Management:
- **flutter_bloc** (^9.1.1) - BLoC паттерн
- **equatable** (^2.0.7) - Сравнение объектов

### Dependency Injection:
- **injectable** (^2.6.0) - Аннотации для DI
- **get_it** (^9.0.5) - Service Locator

### Routing:
- **auto_route** (^10.2.2) - Type-safe навигация

### Network:
- **dio** (^5.9.0) - HTTP клиент
- **connectivity_plus** (^7.0.0) - Проверка подключения

### Local Storage:
- **shared_preferences** (^2.5.3) - Key-value хранилище
- **hive** (^2.2.3) - NoSQL база данных
- **hive_flutter** (^1.1.0) - Flutter интеграция

### Code Generation:
- **freezed** (^3.2.3) - Immutable классы
- **json_serializable** (^6.11.1) - JSON сериализация
- **build_runner** (^2.10.3) - Генератор кода

### Utilities:
- **logger** (^2.6.2) - Логирование
- **flutter_hooks** (^0.21.3+1) - React-подобные хуки
- **intl** (^0.20.2) - Интернационализация
- **dartz** (^0.10.1) - Functional programming (Either)
- **decimal** (^3.2.4) - Точные вычисления

---

## 🔄 Потоки данных

### Типичный поток данных в фиче:

```
1. User Action (UI)
   ↓
2. BLoC Event
   ↓
3. Use Case
   ↓
4. Repository Interface (Domain)
   ↓
5. Repository Implementation (Data)
   ↓
6. Data Source (Remote/Local)
   ↓
7. Model → Entity (Mapper)
   ↓
8. Either<Failure, Entity>
   ↓
9. BLoC State
   ↓
10. UI Update
```

### Пример потока:

```dart
// 1. Пользователь нажимает кнопку
ElevatedButton(
  onPressed: () => context.read<FeatureBloc>().add(LoadFeature('123')),
)

// 2. BLoC обрабатывает событие
on<LoadFeature>((event, emit) async {
  emit(FeatureLoading());
  final result = await getFeatureUseCase(event.id);
  result.fold(
    (failure) => emit(FeatureError(failure)),
    (feature) => emit(FeatureLoaded(feature)),
  );
})

// 3. Use Case вызывает репозиторий
Future<Either<Failure, FeatureEntity>> call(String id) {
  return repository.getFeature(id);
}

// 4. Repository получает данные
Future<Either<Failure, FeatureEntity>> getFeature(String id) async {
  try {
    final model = await remoteDataSource.getFeature(id);
    return Right(model.toEntity());
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}

// 5. UI обновляется на основе состояния
BlocBuilder<FeatureBloc, FeatureState>(
  builder: (context, state) {
    if (state is FeatureLoading) return CircularProgressIndicator();
    if (state is FeatureError) return Text('Error: ${state.failure}');
    if (state is FeatureLoaded) return Text(state.feature.name);
    return SizedBox();
  },
)
```

---

## 💉 Dependency Injection

### Структура DI:

```
injector.dart (GetIt контейнер)
  ├── app_module.dart (Общие зависимости)
  └── feature_modules/
      ├── auth_module.dart
      ├── user_module.dart
      ├── product_module.dart
      ├── order_module.dart
      └── settings_module.dart
```

### Регистрация зависимостей:

```dart
// Использование Injectable аннотаций
@Injectable()
class DioClient {
  // ...
}

@Injectable(as: FeatureRepository)
class FeatureRepositoryImpl implements FeatureRepository {
  // ...
}

@injectable
class GetFeatureUseCase {
  final FeatureRepository repository;
  
  GetFeatureUseCase(this.repository);
}
```

### Инициализация:

```dart
// main.dart
await configureDependencies(environment: Environment.dev);

// Использование
final useCase = getIt<GetFeatureUseCase>();
final repository = DI.get<FeatureRepository>();
```

---

## 🧭 Навигация

### Type-safe навигация с AutoRoute:

```dart
// Определение маршрутов
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(
      page: ProfileRoute.page,
      guards: [AuthGuard], // Защита маршрута
    ),
  ];
}

// Использование
context.router.push(const HomeRoute());
context.router.push(FeatureRoute(id: '123'));
context.router.replace(const LoginRoute());
```

### Route Guards:

```dart
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authService = getIt<AuthService>();
    if (authService.isAuthenticated) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
```

---

## ✅ Проверка архитектуры

### Чек-лист для проверки:

#### 1. Структура слоев
- [ ] Каждая фича содержит `data/`, `domain/`, `presentation/`
- [ ] Domain слой не зависит от других слоев
- [ ] Data слой реализует интерфейсы из Domain
- [ ] Presentation зависит только от Domain

#### 2. Зависимости
- [ ] Нет циклических зависимостей
- [ ] Направление зависимостей: Presentation → Domain ← Data
- [ ] Core слой не зависит от других слоев
- [ ] Shared слой используется несколькими фичами

#### 3. Dependency Injection
- [ ] Все зависимости зарегистрированы в DI
- [ ] Используются интерфейсы, а не конкретные реализации
- [ ] Модули фич изолированы в `feature_modules/`

#### 4. Код и стиль
- [ ] Используются базовые классы из `core/common/`
- [ ] Константы вынесены в `core/constrants/`
- [ ] Ошибки обрабатываются через `core/exceptions/`
- [ ] Используются расширения из `core/extensions/`

#### 5. Тестирование
- [ ] Domain слой тестируется без Flutter
- [ ] Data слой тестируется с mock данными
- [ ] Presentation слой тестируется с mock use cases
- [ ] Покрытие тестами ключевых компонентов

#### 6. Навигация
- [ ] Используется type-safe навигация
- [ ] Маршруты защищены guards где необходимо
- [ ] Нет hardcoded строк для навигации

#### 7. Сеть
- [ ] Используется единый DioClient
- [ ] Интерцепторы настроены правильно
- [ ] Ошибки сети обрабатываются централизованно

#### 8. Локальное хранилище
- [ ] Используются правильные ключи из `storage_keys.dart`
- [ ] Данные кэшируются где необходимо
- [ ] Ошибки хранилища обрабатываются

---

## 📊 Диаграмма архитектуры

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                    │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │  Pages   │  │ Widgets  │  │  BLoC    │             │
│  └──────────┘  └──────────┘  └──────────┘             │
└──────────────────────┬──────────────────────────────────┘
                       │ depends on
                       ↓
┌─────────────────────────────────────────────────────────┐
│                      Domain Layer                        │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │ Entities │  │Use Cases │  │Repository│             │
│  │          │  │          │  │Interface │             │
│  └──────────┘  └──────────┘  └──────────┘             │
└──────────┬──────────────────────────┬───────────────────┘
           │                          │
           │ implements               │ implements
           ↓                          ↓
┌─────────────────────────────────────────────────────────┐
│                       Data Layer                        │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │  Models  │  │  Mapper  │  │Repository│             │
│  │   (DTO)  │  │          │  │   Impl   │             │
│  └──────────┘  └──────────┘  └──────────┘             │
│                                                         │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │  Remote  │  │  Local   │  │  Cache   │             │
│  │DataSource│  │DataSource│  │DataSource│             │
│  └──────────┘  └──────────┘  └──────────┘             │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│                      Core Layer                         │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │   DI     │  │ Network  │  │  Theme   │             │
│  └──────────┘  └──────────┘  └──────────┘             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │  Utils   │  │Exceptions│  │Extensions│             │
│  └──────────┘  └──────────┘  └──────────┘             │
└─────────────────────────────────────────────────────────┘
```

---

## 🚀 Команды разработки

```bash
# Генерация кода (модели, маршруты, DI)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch режим для разработки
flutter pub run build_runner watch

# Запуск приложения
flutter run

# Тестирование
flutter test

# Анализ кода
flutter analyze

# Форматирование кода
dart format .
```

---

## 📚 Дополнительная документация

- [Core Layer README](lib/src/core/README.md)
- [Features README](lib/src/features/README.md)
- [App README](lib/src/app/README.md)
- [Shared README](lib/src/shared/README.md)
- [DI README](lib/src/core/di/README.md)
- [Network README](lib/src/core/network/README.md)
- [Monitoring README](lib/src/core/monitoring/README.md)

---

## ✨ Заключение

Архитектура проекта **Eki Al** следует принципам Clean Architecture и Feature-First подхода, что обеспечивает:

- ✅ **Модульность** - каждая фича независима
- ✅ **Тестируемость** - легко тестировать каждый слой
- ✅ **Масштабируемость** - просто добавлять новые фичи
- ✅ **Поддерживаемость** - понятная структура кода
- ✅ **Переиспользуемость** - общие компоненты в core и shared

---

*Последнее обновление: 2025*

