// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:eki_al/src/core/auth/auth_service.dart' as _i352;
import 'package:eki_al/src/core/auth/token_service.dart' as _i493;
import 'package:eki_al/src/core/di/app_module.dart' as _i388;
import 'package:eki_al/src/core/di/network_module.dart' as _i217;
import 'package:eki_al/src/core/network/dio_client.dart' as _i823;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    final storageModule = _$StorageModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => appModule.dio);
    gh.singleton<_i895.Connectivity>(() => appModule.connectivity);
    gh.factory<String>(
      () => storageModule.userDataKey,
      instanceName: 'userDataKey',
    );
    gh.factory<int>(
      () => storageModule.maxCacheSize,
      instanceName: 'maxCacheSize',
    );
    gh.factory<String>(
      () => storageModule.authTokenKey,
      instanceName: 'authTokenKey',
    );
    gh.factory<bool>(
      () => appModule.analyticsEnabled,
      instanceName: 'analyticsEnabled',
    );
    gh.factory<Duration>(
      () => storageModule.cacheDuration,
      instanceName: 'cacheDuration',
    );
    gh.factory<String>(
      () => storageModule.settingsKey,
      instanceName: 'settingsKey',
    );
    gh.factory<String>(() => appModule.apiKey, instanceName: 'apiKey');
    gh.factory<_i217.AuthInterceptorFactory>(
      () => _i217.AuthInterceptorFactory(dio: gh<_i361.Dio>()),
    );
    gh.factory<_i217.RetryInterceptorFactory>(
      () => _i217.RetryInterceptorFactory(dio: gh<_i361.Dio>()),
    );
    gh.factory<_i823.DioClient>(() => _i823.DioClient(dio: gh<_i361.Dio>()));
    gh.factory<_i493.TokenService>(
      () => _i493.TokenService(prefs: gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i352.AuthService>(
      () => _i352.AuthService(tokenService: gh<_i493.TokenService>()),
    );
    return this;
  }
}

class _$AppModule extends _i388.AppModule {}

class _$StorageModule extends _i388.StorageModule {}
