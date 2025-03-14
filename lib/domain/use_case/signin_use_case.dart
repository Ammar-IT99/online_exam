
import 'package:injectable/injectable.dart';
import 'package:online_exam/domain/repository/repository_contract/auth_repository_contract.dart';

import '../../data/api/api_result.dart';
import '../entity/auth_result_entity.dart';

@injectable
class SignInUseCase {
 AuthRepositoryContract authRepositoryContract;
 SignInUseCase( {required this.authRepositoryContract});

 Future<ApiResult<AuthResultEntity>>invoke(String email, String password,)async{
   return await authRepositoryContract.signIn(email, password,);
 }
}