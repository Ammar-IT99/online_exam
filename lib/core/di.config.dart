// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/api/api_service.dart' as _i103;
import '../data/repository/data_source_impl/auth_remote_data_source_impl.dart'
    as _i32;
import '../data/repository/repository_impl/auth_repository_impl.dart' as _i17;
import '../domain/repository/data_source/auth_remote_data_source.dart' as _i341;
import '../domain/repository/repository_contract/auth_repository_contract.dart'
    as _i235;
import '../domain/use_case/forgot_password_use_case.dart' as _i755;
import '../domain/use_case/register_use_case.dart' as _i224;
import '../domain/use_case/signin_use_case.dart' as _i435;
import '../presentation/auth/login/cubit/login_screen_view_model.dart' as _i703;
import '../presentation/auth/register/cubit/register_screen_view_model.dart'
    as _i265;
import '../presentation/forgotPassword/cubit/forgot_password_view_model.dart'
    as _i515;

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
    gh.lazySingleton<_i103.ApiService>(() => _i103.ApiService());
    gh.lazySingleton<_i341.AuthRemoteDataSource>(() =>
        _i32.AuthRemoteDataSourceImpl(apiService: gh<_i103.ApiService>()));
    gh.lazySingleton<_i235.AuthRepositoryContract>(() =>
        _i17.AuthRepositoryImpl(
            remoteDataSource: gh<_i341.AuthRemoteDataSource>()));
    gh.factory<_i224.RegisterUseCase>(() => _i224.RegisterUseCase(
        authRepositoryContract: gh<_i235.AuthRepositoryContract>()));
    gh.factory<_i435.SignInUseCase>(() => _i435.SignInUseCase(
        authRepositoryContract: gh<_i235.AuthRepositoryContract>()));
    gh.lazySingleton<_i755.ForgotPasswordUseCase>(() =>
        _i755.ForgotPasswordUseCase(
            authRepositoryContract: gh<_i235.AuthRepositoryContract>()));
    gh.factory<_i703.LoginScreenViewModel>(() =>
        _i703.LoginScreenViewModel(signInUseCase: gh<_i435.SignInUseCase>()));
    gh.factory<_i515.ForgotPasswordViewModel>(() =>
        _i515.ForgotPasswordViewModel(
            forgotPasswordUseCase: gh<_i755.ForgotPasswordUseCase>()));
    gh.factory<_i265.RegisterScreenViewModel>(() =>
        _i265.RegisterScreenViewModel(
            registerUseCase: gh<_i224.RegisterUseCase>()));
    return this;
  }
}
