import 'package:injectable/injectable.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/data/models/request/get_all_subjects_request.dart';
import 'package:online_exam/data/models/response/get_all_subjects_dto.dart';
import 'package:online_exam/domain/entity/auth_result_entity.dart';
import 'package:online_exam/domain/entity/forgot_password_entity.dart';
import 'package:online_exam/domain/entity/reset_password_entity.dart';
import 'package:online_exam/domain/entity/verify_reset_code_entity.dart';
import 'package:online_exam/domain/entity/forgot_password_entity.dart';
import 'package:online_exam/domain/entity/get_all_subjects_entity.dart';
import 'package:online_exam/domain/entity/get_single_subjects_entity.dart';
import 'package:online_exam/domain/entity/subjects_entity.dart';
import '../../../domain/repository/data_source/auth_remote_data_source.dart';
import '../../api/api_result.dart';
import '../../api/api_service.dart';
@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  // 🔑 Register Method
  @override
  Future<ApiResult<AuthResultEntity>> register(
      String userName,
      String firstName,
      String lastName,
      String email,
      String password,
      String rePassword,
      String phoneNumber,
      ) async {
    final result = await apiService.register(
      userName,
      firstName,
      lastName,
      email,
      password,
      rePassword,
      phoneNumber,
    );

    switch (result) {
      case Success(data: final response):
        return Success(response.toAuthResultEntity());
      case Failure(message: final error):
        return Failure(error);
    }
  }

  // 🔑 SignIn Method
  @override
  Future<ApiResult<AuthResultEntity>> signIn(
      String email,
      String password,
      ) async {
    final result = await apiService.signIn(email, password);

    switch (result) {
      case Success(data: final response):
        return Success(response.toAuthResultEntity());
      case Failure(message: final error):
        return Failure(error);
    }
  }

  @override
  Future<ApiResult<ForgotPasswordEntity>> forgotPassword(String email) async {
    final result = await apiService.forgotPassword(email);

    switch (result) {
      case Success(data: final response):
        return Success(response.toForgotPasswordEntity());
      case Failure(message: final error):
        return Failure(error);
    }
  }

  @override
  Future<ApiResult<VerifyResetCodeEntity>> verifyResetCode(String resetCode) async{
    final result= await apiService.verifyResetCode(resetCode);
    switch (result) {
      case Success(data: final response):
        return Success(response.toVerifyResetCodeEntity());
      case Failure(message: final error):
        return Failure(error);
    }
  }
  Future<ApiResult<List<GetAllSubjectsRequest>>> getAllSubjects(String name, String icon) async {
  final result = await apiService.getAllSubjects(name, icon);

  @override
  Future<ApiResult<ResetPasswordEntity>> resetPassword( String email,  String newPassword) async{

    final result =  await apiService.resetPassword(email,newPassword);
    print('API Response: $result');
    switch (result) {
      case Success(data: final response):
        return Success(response.toResetPasswordEntity());
      case Failure(message: final error):
        return Failure(error);
  switch (result) {
    case Success(data: final List<GetAllSubjectsRequest> response): // تأكد من أنه List<GetAllSubjectsDto>
      List<GetAllSubjectsRequest> entities = response.map((dto) => dto.toGetAllSubjectsRequest()).toList();
      return Success(entities);
    case Failure(message: final error):
      return Failure(error);
      default:
      return Failure('Unknown error occurred');
  }
}
}
@override
  Future<ApiResult<GetSingleSubjectsEntity>> getSingleSubjects(String message) async{
    final result = await apiService.getSingleSubject(message);

    switch (result) {
      case Success(data: final response):
        return Success(response.toGetSingleSubjectEntity());
      case Failure(message: final error):
        return Failure(error);
    }
  }
}