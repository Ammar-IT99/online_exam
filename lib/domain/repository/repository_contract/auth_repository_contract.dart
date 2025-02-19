
import 'package:dartz/dartz.dart';
import 'package:online_exam/domain/entity/auth_result_entity.dart';
import 'package:online_exam/domain/entity/failures.dart';

import '../../entity/Register_response.dart';

abstract class AuthRepositoryContract{
  Future<Either<Failures, AuthResultEntity>> register(String userName, String firstName, String lastName, String email, String password, String rePassword, String phoneNumber);
  Future<Either<Failures, AuthResultEntity>> signIn(String email, String password,);
  }
