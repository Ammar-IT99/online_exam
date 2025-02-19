import 'package:dartz/dartz.dart';

import 'package:online_exam/domain/entity/auth_result_entity.dart';

import 'package:online_exam/domain/entity/failures.dart';

import '../../../domain/repository/data_source/auth_remote_data_source.dart';
import '../../api/api_service.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
   ApiService apiService;
  AuthRemoteDataSourceImpl({required this.apiService});
  //register
  @override
  Future<Either<Failures, AuthResultEntity>> register(String userName, String firstName, String lastName, String email, String password, String rePassword, String phoneNumber)async {
    // TODO: implement register
    var either = await apiService.register(
        userName, firstName, lastName, email, password, rePassword, phoneNumber,);
    return either.fold((l) {
      return Left(l);

    }, (response) {
      return Right(response.toAuthResultEntity());
    });
  }

  //login
  @override
  Future<Either<Failures, AuthResultEntity>> signIn(String email, String password,)async {
    // TODO: implement register
    var either = await apiService.signIn(
        email, password,);
    return either.fold((l) {
      return Left(l);

    }, (response) {
      return Right(response.toAuthResultEntity());
    });
  }
}
