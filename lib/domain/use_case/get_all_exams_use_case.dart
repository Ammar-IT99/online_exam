import 'package:injectable/injectable.dart';
import 'package:online_exam/data/api/api_result.dart';
import 'package:online_exam/data/models/request/get_all_exams_request.dart';
import 'package:online_exam/domain/repository/repository_contract/auth_repository_contract.dart';

@lazySingleton
class GetAllExamsUseCase {
  AuthRepositoryContract  authRepositoryContract;
  GetAllExamsUseCase({required this.authRepositoryContract});

  Future<ApiResult<List<GetAllExamsRequest>>> call( String title,int numberOfQuestions, int duration) async {
   return await authRepositoryContract.getAllExams(title, numberOfQuestions,duration);
  }
}