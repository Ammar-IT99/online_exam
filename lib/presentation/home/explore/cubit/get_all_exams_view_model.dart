import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/data/api/api_result.dart';
import 'package:online_exam/data/models/request/get_all_exams_request.dart';
import 'package:online_exam/domain/use_case/get_all_exams_use_case.dart';
import 'package:online_exam/presentation/home/explore/cubit/states.dart';

@injectable
class GetAllExamsViewModel extends Cubit<GetAllExams> {
  final GetAllExamsUseCase getAllExamsUseCase;

  GetAllExamsViewModel({required this.getAllExamsUseCase})
      : super(GetAllExamsInitialState());
  List<GetAllExamsRequest> allExams = [];
  // Form Key & Controller
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController(); 
  final TextEditingController numberOfQuestionsController = TextEditingController(); 
  final TextEditingController durationController = TextEditingController();    
  getAllExams() async {
    emit(GetAllExamsLoadingState());

    emit(GetAllExamsLoadingState());
    final result = await getAllExamsUseCase.call(titleController.text,int.tryParse(numberOfQuestionsController.text)??0,int.tryParse(durationController.text)??0);

    switch (result) {
      case Success(data: final entities):
        emit(GetAllExamsSuccessState(getAllExamsRequest: entities));
        break;

      case Failure(message: final error):
        emit(GetAllExamsErrorState(error));
        break;
    }
  }
}