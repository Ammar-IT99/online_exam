import 'package:injectable/injectable.dart';
import 'package:online_exam/data/api/api_result.dart';
import 'package:online_exam/data/models/response/question_on_exam_response.dart';
import 'package:online_exam/domain/repository/repository_contract/auth_repository_contract.dart';

@injectable
class QuestionOnexamUsecase{
  AuthRepositoryContract questionOnexamRepo;
  QuestionOnexamUsecase(this.questionOnexamRepo);
  Future<ApiResult<QuestionOnExamResponse>> call({required String examID}){
    return questionOnexamRepo.getQuestion(examID: examID);
  }
}