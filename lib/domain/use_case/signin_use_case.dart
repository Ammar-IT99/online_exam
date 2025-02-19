import 'package:dartz/dartz.dart';
import 'package:online_exam/domain/repository/repository_contract/auth_repository_contract.dart';

import '../entity/auth_result_entity.dart';
import '../entity/failures.dart';

class SignInUseCase {
 AuthRepositoryContract authRepositoryContract;
 SignInUseCase( {required this.authRepositoryContract});

 Future<Either<Failures, AuthResultEntity>> invoke(String email, String password,)async{
   return await authRepositoryContract.signIn(email, password,);
 }
}