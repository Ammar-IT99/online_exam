
import 'package:injectable/injectable.dart';
import 'package:online_exam/data/api/api_result.dart';

import 'package:online_exam/domain/repository/repository_contract/auth_repository_contract.dart';

import '../entity/verify_reset_code_entity.dart';

@lazySingleton
class VerifyResetCodeUseCase {
  final AuthRepositoryContract authRepositoryContract;

  VerifyResetCodeUseCase(this.authRepositoryContract);

  Future<ApiResult<VerifyResetCodeEntity>> invoke(String resetCode) async {
    return await authRepositoryContract.verifyResetCode(resetCode);
  }
}