// 📂 reset_password_use_case.dart

import 'package:injectable/injectable.dart';

import '../../data/api/api_result.dart';
import '../entity/reset_password_entity.dart';
import '../repository/repository_contract/auth_repository_contract.dart';
@injectable
class ResetPasswordUseCase {
  AuthRepositoryContract authRepositoryContract;
  ResetPasswordUseCase({required this.authRepositoryContract});

  Future<ApiResult<ResetPasswordEntity>> invoke(
     String email, String newPassword,
  ) async {
    return await authRepositoryContract.resetPassword(
       email,
      newPassword,
    );
  }
}
