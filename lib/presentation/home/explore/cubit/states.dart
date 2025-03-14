
import 'package:online_exam/data/models/request/get_all_subjects_request.dart';
import 'package:online_exam/data/models/response/get_all_subjects_dto.dart';
import 'package:online_exam/domain/entity/get_all_subjects_entity.dart';
import 'package:online_exam/domain/entity/subjects_entity.dart';

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