import '../../../data/api/api_result.dart';
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
  }