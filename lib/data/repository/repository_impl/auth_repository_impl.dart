
import 'package:injectable/injectable.dart';

import 'package:online_exam/data/models/request/get_all_subjects_request.dart';
import 'package:online_exam/data/models/response/get_log_out_response.dart';

import 'package:online_exam/domain/entity/auth_result_entity.dart';
import 'package:online_exam/domain/entity/forgot_password_entity.dart';
import 'package:online_exam/domain/entity/reset_password_entity.dart';
import 'package:online_exam/domain/entity/verify_reset_code_entity.dart';


import 'package:online_exam/domain/entity/get_single_subjects_entity.dart';



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

  @override
  Future<ApiResult<VerifyResetCodeEntity>> verifyResetCode(String resetCode) {
    return remoteDataSource.verifyResetCode(resetCode);
  }

  @override
  Future<ApiResult<ResetPasswordEntity>> resetPassword( String email, String newPassword) {
 return remoteDataSource.resetPassword( email, newPassword);

  }

  //getAllSubjects
  @override
  Future<ApiResult<List<GetAllSubjectsRequest>>> getAllSubjects(String name, String icon) {
    // TODO: implement forgotPassword
   return remoteDataSource.getAllSubjects(name,icon);
  }

  @override
  Future<ApiResult<GetSingleSubjectsEntity>> getSingleSubjects(String message) {
    // TODO: implement getSingleSubjects
    return remoteDataSource.getSingleSubjects(message);
  }

  @override
  Future<ApiResult<LogoutResponse>> logOut() {
    return remoteDataSource.logOut();

  }

}
