import 'package:injectable/injectable.dart';
import 'package:online_exam/data/api/api_result.dart';
import 'package:online_exam/data/models/request/get_all_subjects_request.dart';
import 'package:online_exam/domain/entity/get_all_subjects_entity.dart';
import 'package:online_exam/domain/entity/subjects_entity.dart';
import 'package:online_exam/domain/repository/repository_contract/auth_repository_contract.dart';

@lazySingleton
class GetAllSubjectsUseCase {
  AuthRepositoryContract  authRepositoryContract;
  GetAllSubjectsUseCase({required this.authRepositoryContract});

  Future<ApiResult<List<GetAllSubjectsRequest>>> call( String name,String icon) async {
   return await authRepositoryContract.getAllSubjects(name, icon);
  }
}