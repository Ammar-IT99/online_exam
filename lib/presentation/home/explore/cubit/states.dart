
import 'package:online_exam/data/models/request/get_all_exams_request.dart';
import 'package:online_exam/data/models/request/get_all_subjects_request.dart';
import 'package:online_exam/data/models/response/get_all_subjects_dto.dart';
import 'package:online_exam/domain/entity/get_all_subjects_entity.dart';
import 'package:online_exam/domain/entity/subjects_entity.dart';

//subjects
sealed class GetAllSubjects {}

class GetAllSubjectsInitialState extends GetAllSubjects {}

class GetAllSubjectsLoadingState extends GetAllSubjects {}

class GetAllSubjectsSuccessState extends GetAllSubjects {
  final List<GetAllSubjectsRequest> getAllSubjectsEntity;
  GetAllSubjectsSuccessState({required this.getAllSubjectsEntity});
}

class GetAllSubjectsErrorState extends GetAllSubjects {
  final String errorMessage;
  GetAllSubjectsErrorState(this.errorMessage);
}

//exams
sealed class GetAllExams {}

class GetAllExamsInitialState extends GetAllExams {}

class GetAllExamsLoadingState extends GetAllExams {}

class GetAllExamsSuccessState extends GetAllExams {
  final List<GetAllExamsRequest> getAllExamsRequest;
  GetAllExamsSuccessState({required this.getAllExamsRequest});
}

class GetAllExamsErrorState extends GetAllExams {
  final String errorMessage;
  GetAllExamsErrorState(this.errorMessage);
}