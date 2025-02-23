
import 'package:online_exam/domain/entity/auth_result_entity.dart';
import '../../../data/api/api_result.dart';
abstract class AuthRepositoryContract{
  Future<ApiResult<AuthResultEntity>> register(String userName, String firstName, String lastName, String email, String password, String rePassword, String phoneNumber);
  Future<ApiResult<AuthResultEntity>> signIn(String email, String password,);
  }
