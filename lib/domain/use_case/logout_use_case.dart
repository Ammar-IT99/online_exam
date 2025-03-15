import 'package:injectable/injectable.dart';

import '../../data/api/api_result.dart';
import '../../data/models/response/get_log_out_response.dart';
import '../repository/repository_contract/auth_repository_contract.dart';
@lazySingleton
class LogOutUseCase {
  AuthRepositoryContract authRepositoryContract;
  LogOutUseCase({required this.authRepositoryContract});
  Future<ApiResult<LogoutResponse>> invoke() async {
    return await authRepositoryContract.logOut();
  }

}