import 'package:dartz/dartz.dart';

import '../../entity/auth_result_entity.dart';
import '../../entity/failures.dart';

abstract class AuthRemoteDataSource{
  Future<Either<Failures, AuthResultEntity>> register(String userName, String firstName, String lastName, String email, String password, String rePassword, String phoneNumber);
  Future<Either<Failures, AuthResultEntity>> signIn(String email, String password,);
  }
