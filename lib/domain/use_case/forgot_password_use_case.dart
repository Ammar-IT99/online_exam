import 'package:injectable/injectable.dart';
import 'package:online_exam/data/api/api_result.dart';
import 'package:online_exam/domain/entity/forgot_password_entity.dart';

import '../repository/repository_contract/auth_repository_contract.dart';
@lazySingleton
class ForgotPasswordUseCase {
  AuthRepositoryContract  authRepositoryContract;
  ForgotPasswordUseCase({required this.authRepositoryContract});

  Future<ApiResult<ForgotPasswordEntity>> call( String email) async {
   return await authRepositoryContract.forgotPassword(email);
  }
}