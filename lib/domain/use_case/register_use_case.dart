import 'package:injectable/injectable.dart';
import 'package:online_exam/domain/repository/repository_contract/auth_repository_contract.dart';

import '../../data/api/api_result.dart';
import '../entity/auth_result_entity.dart';

@injectable
class RegisterUseCase {
 AuthRepositoryContract authRepositoryContract;
 RegisterUseCase( {required this.authRepositoryContract});

 Future<ApiResult<AuthResultEntity>> invoke(String userName, String firstName, String lastName, String email, String password, String rePassword, String phoneNumber)async{
   return await authRepositoryContract.register(email, password, userName, firstName, lastName, phoneNumber, rePassword);
 }
}
