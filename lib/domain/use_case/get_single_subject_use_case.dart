import 'package:injectable/injectable.dart';
import 'package:online_exam/data/api/api_result.dart';
import 'package:online_exam/data/models/request/get_single_subject_request.dart';
import 'package:online_exam/domain/entity/get_single_subjects_entity.dart';
import 'package:online_exam/domain/repository/repository_contract/auth_repository_contract.dart';

@lazySingleton
class GetSingleSubjectUseCase {
  AuthRepositoryContract  authRepositoryContract;
  GetSingleSubjectUseCase({required this.authRepositoryContract});

  Future<ApiResult<GetSingleSubjectsEntity>> call(String message) async {
   return await authRepositoryContract.getSingleSubjects(message);
  }
}