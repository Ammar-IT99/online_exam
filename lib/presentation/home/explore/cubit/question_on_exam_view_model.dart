import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/data/api/api_result.dart';
import 'package:online_exam/data/models/response/question_on_exam_response.dart';
import 'package:online_exam/domain/use_case/question_on_exam_use_case.dart';
import 'package:online_exam/presentation/home/explore/cubit/states.dart';

@injectable
class Question0nexamCubit extends Cubit<Question0nexamState> {
  QuestionOnexamUsecase questionOnexamUsecase;
  Question0nexamCubit(this.questionOnexamUsecase) : super(Question0nexamInitial());

  static Question0nexamCubit get(context){
    return BlocProvider.of(context);
  }

  Future<void> getQuestion({required String examID})async{
    emit(QuestionOnExamLoadingState());

    var result=await questionOnexamUsecase.call(examID: examID);
    switch (result) {
      case Success(data: final entities):
        emit(QuestionOnExamSuccessState(entities));
        break;

      case Failure(message: final error):
        emit(QuestionOnExamErrorState(error));
        break;
    }
  }
}