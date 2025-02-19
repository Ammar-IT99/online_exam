//todo: view model => object useCase
//todo:  useCase => repository
//todo:  repository => data source
//todo:  data source => api service

import 'package:get_it/get_it.dart';
import 'package:online_exam/data/api/api_service.dart';
import 'package:online_exam/domain/use_case/register_use_case.dart';
import 'package:online_exam/domain/use_case/signin_use_case.dart';

import '../data/repository/data_source_impl/auth_remote_data_source_impl.dart';
import '../data/repository/repository_impl/auth_repository_impl.dart';
import '../domain/repository/data_source/auth_remote_data_source.dart';
import '../domain/repository/repository_contract/auth_repository_contract.dart';

RegisterUseCase injectRegisterUseCase(){
  return RegisterUseCase(authRepositoryContract: injectAuthRepositoryContract());
}
SignInUseCase injectSignInUseCase(){
  return SignInUseCase(authRepositoryContract: injectAuthRepositoryContract());

}
AuthRepositoryContract injectAuthRepositoryContract(){
return AuthRepositoryImpl(remoteDataSource: injectAuthRemoteDataSource());
}
AuthRemoteDataSource injectAuthRemoteDataSource(){
  return AuthRemoteDataSourceImpl(apiService: ApiService.getInstance());
}