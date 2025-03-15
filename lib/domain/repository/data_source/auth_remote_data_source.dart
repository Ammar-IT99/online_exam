import 'package:online_exam/data/models/request/get_all_exams_request.dart';

import '../../../data/api/api_result.dart';
import 'package:online_exam/data/models/request/get_all_subjects_request.dart';
import 'package:online_exam/domain/entity/get_single_subjects_entity.dart';
import '../../entity/auth_result_entity.dart';
import '../../entity/forgot_password_entity.dart';
import '../../entity/reset_password_entity.dart';
import '../../entity/verify_reset_code_entity.dart';




abstract class AuthRemoteDataSource{
  Future<ApiResult<AuthResultEntity>> register(String userName, String firstName, String lastName, String email, String password, String rePassword, String phoneNumber);
  Future<ApiResult<AuthResultEntity>> signIn(String email, String password,);
  Future<ApiResult<ForgotPasswordEntity>> forgotPassword(String email);
  Future<ApiResult<VerifyResetCodeEntity>> verifyResetCode(String resetCode);
  Future<ApiResult<ResetPasswordEntity>> resetPassword( String email, String newPassword);
  Future<ApiResult<List<GetAllSubjectsRequest>>> getAllSubjects(String name,String icon);
  Future<ApiResult<GetSingleSubjectsEntity>> getSingleSubjects(String message,);
  Future<ApiResult<List<GetAllExamsRequest>>> getAllExams(String title,int numberOfQuestions,int duration);
  }