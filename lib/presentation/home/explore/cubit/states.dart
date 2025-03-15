
import 'package:online_exam/data/models/request/get_all_subjects_request.dart';


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