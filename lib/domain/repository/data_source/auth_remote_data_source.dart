import 'package:dartz/dartz.dart';

import '../../../data/api/api_result.dart';
import '../../entity/auth_result_entity.dart';
import '../../entity/failures.dart';

abstract class AuthRemoteDataSource{
  Future<ApiResult<AuthResultEntity>> register(String userName, String firstName, String lastName, String email, String password, String rePassword, String phoneNumber);
  Future<ApiResult<AuthResultEntity>> signIn(String email, String password,);
  }
