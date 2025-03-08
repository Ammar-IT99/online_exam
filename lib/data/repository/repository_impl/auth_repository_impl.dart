
import 'package:injectable/injectable.dart';
import 'package:online_exam/domain/entity/auth_result_entity.dart';
import 'package:online_exam/domain/entity/forgot_password_entity.dart';


import '../../../domain/repository/data_source/auth_remote_data_source.dart';
import '../../../domain/repository/repository_contract/auth_repository_contract.dart';
import '../../api/api_result.dart';
@LazySingleton(as: AuthRepositoryContract)
class AuthRepositoryImpl implements AuthRepositoryContract {
  AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});
  //register
  @override
  Future<ApiResult<AuthResultEntity>> register(String userName, String firstName, String lastName, String email, String password, String rePassword, String phoneNumber) {
    return remoteDataSource.register(
        userName, firstName, lastName, email, password, rePassword, phoneNumber,);
  }

  //signIn
  @override
  Future<ApiResult<AuthResultEntity>> signIn(String email, String password,) {
    return remoteDataSource.signIn(
        email, password,);
  }
  //forgotPassword
  @override
  Future<ApiResult<ForgotPasswordEntity>> forgotPassword(String email) {
    // TODO: implement forgotPassword
   return remoteDataSource.forgotPassword(email);
  }



}
