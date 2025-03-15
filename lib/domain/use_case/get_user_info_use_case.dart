import 'package:injectable/injectable.dart';
import 'package:online_exam/domain/repository/repository_contract/auth_repository_contract.dart';

import '../../data/api/api_result.dart';
import '../entity/get_user_info_entity.dart';
@lazySingleton
class GetUserInfoUseCase {
  final AuthRepositoryContract authRepositoryContract;

  GetUserInfoUseCase({required this.authRepositoryContract});

  Future<ApiResult<UserInfoEntity>> invoke() async {

    return await authRepositoryContract.getUserInfo();
  }
}