import 'package:dartz/dartz.dart';
import 'package:online_exam/domain/entity/auth_result_entity.dart';

import 'package:online_exam/domain/entity/failures.dart';

import '../../../domain/repository/data_source/auth_remote_data_source.dart';
import '../../../domain/repository/repository_contract/auth_repository_contract.dart';

class AuthRepositoryImpl implements AuthRepositoryContract {
  AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failures, AuthResultEntity>> register(String userName, String firstName, String lastName, String email, String password, String rePassword, String phoneNumber) {
    return remoteDataSource.register(
        userName, firstName, lastName, email, password, rePassword, phoneNumber,);
  }
}
