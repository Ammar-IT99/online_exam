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
import '../domain/use_case/get_all_exams_use_case.dart' as _i767;
import '../domain/use_case/get_all_subjects_use_case.dart' as _i805;
import '../domain/use_case/get_single_subject_use_case.dart' as _i2;
import '../domain/use_case/register_use_case.dart' as _i224;
import '../domain/use_case/reset_password_use_case.dart' as _i276;
import '../domain/use_case/signin_use_case.dart' as _i435;
import '../domain/use_case/verify_reset_code_use_case.dart' as _i353;
import '../presentation/auth/forgotPassword/cubit/forgot_password_view_model.dart'
    as _i1035;
import '../presentation/auth/login/cubit/login_screen_view_model.dart' as _i703;
import '../presentation/auth/register/cubit/register_screen_view_model.dart'
    as _i265;
import '../presentation/auth/reset_password/cubit/reset_password_view_model.dart'
    as _i867;
import '../presentation/auth/verify_reset_code/cubit/verify_reset_code_view_model.dart'
    as _i319;
import '../presentation/home/explore/cubit/get_all_exams_view_model.dart'
    as _i562;
import '../presentation/home/explore/cubit/get_all_subjects_view_model.dart'
    as _i570;

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
    gh.factory<_i276.ResetPasswordUseCase>(() => _i276.ResetPasswordUseCase(
        authRepositoryContract: gh<_i235.AuthRepositoryContract>()));
    gh.factory<_i435.SignInUseCase>(() => _i435.SignInUseCase(
        authRepositoryContract: gh<_i235.AuthRepositoryContract>()));
    gh.lazySingleton<_i755.ForgotPasswordUseCase>(() =>
        _i755.ForgotPasswordUseCase(
            authRepositoryContract: gh<_i235.AuthRepositoryContract>()));
    gh.lazySingleton<_i767.GetAllExamsUseCase>(() => _i767.GetAllExamsUseCase(
        authRepositoryContract: gh<_i235.AuthRepositoryContract>()));
    gh.lazySingleton<_i805.GetAllSubjectsUseCase>(() =>
        _i805.GetAllSubjectsUseCase(
            authRepositoryContract: gh<_i235.AuthRepositoryContract>()));
    gh.lazySingleton<_i2.GetSingleSubjectUseCase>(() =>
        _i2.GetSingleSubjectUseCase(
            authRepositoryContract: gh<_i235.AuthRepositoryContract>()));
    gh.lazySingleton<_i224.RegisterUseCase>(() => _i224.RegisterUseCase(
        authRepositoryContract: gh<_i235.AuthRepositoryContract>()));
    gh.factory<_i562.GetAllExamsViewModel>(() => _i562.GetAllExamsViewModel(
        getAllExamsUseCase: gh<_i767.GetAllExamsUseCase>()));
    gh.factory<_i703.LoginScreenViewModel>(() =>
        _i703.LoginScreenViewModel(signInUseCase: gh<_i435.SignInUseCase>()));
    gh.lazySingleton<_i353.VerifyResetCodeUseCase>(
        () => _i353.VerifyResetCodeUseCase(gh<_i235.AuthRepositoryContract>()));
    gh.factory<_i570.GetAllSubjectsViewModel>(() =>
        _i570.GetAllSubjectsViewModel(
            getAllSubjectsUseCase: gh<_i805.GetAllSubjectsUseCase>()));
    gh.factory<_i1035.ForgotPasswordViewModel>(() =>
        _i1035.ForgotPasswordViewModel(
            forgotPasswordUseCase: gh<_i755.ForgotPasswordUseCase>()));
    gh.factory<_i265.RegisterScreenViewModel>(() =>
        _i265.RegisterScreenViewModel(
            registerUseCase: gh<_i224.RegisterUseCase>()));
    gh.factory<_i867.ResetPasswordViewModel>(
        () => _i867.ResetPasswordViewModel(gh<_i276.ResetPasswordUseCase>()));
    gh.factory<_i319.VerifyResetCodeViewModel>(() =>
        _i319.VerifyResetCodeViewModel(gh<_i353.VerifyResetCodeUseCase>()));
    return this;
  }
}
