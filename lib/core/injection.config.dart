// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:logger/web.dart' as _i120;
import 'package:pokedex_app/core/injection_modules.dart' as _i489;
import 'package:pokedex_app/services/api_service.dart' as _i687;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModules = _$InjectionModules();
    gh.lazySingleton<_i974.Logger>(() => injectionModules.logger);
    gh.lazySingleton<_i687.ApiService>(
        () => _i687.ApiService(gh<_i120.Logger>()));
    return this;
  }
}

class _$InjectionModules extends _i489.InjectionModules {}
