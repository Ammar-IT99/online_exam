
import '../../../data/api/api_result.dart';
import '../../entity/auth_result_entity.dart';
import '../../entity/forgot_password_entity.dart';


abstract class AuthRemoteDataSource{
  Future<ApiResult<AuthResultEntity>> register(String userName, String firstName, String lastName, String email, String password, String rePassword, String phoneNumber);
  Future<ApiResult<AuthResultEntity>> signIn(String email, String password,);
  Future<ApiResult<ForgotPasswordEntity>> forgotPassword(String email);
  }
