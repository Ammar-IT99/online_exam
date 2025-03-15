import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/data/api/api_result.dart';
import 'package:online_exam/data/api/api_service.dart';
import 'package:online_exam/data/models/request/get_all_subjects_request.dart';

import 'package:online_exam/data/repository/data_source_impl/auth_remote_data_source_impl.dart';
import 'package:online_exam/data/repository/repository_impl/auth_repository_impl.dart';

import 'package:online_exam/domain/use_case/get_all_subjects_use_case.dart';

import 'package:online_exam/presentation/home/explore/cubit/states.dart';


@injectable
class GetAllSubjectsViewModel extends Cubit<GetAllSubjects> {
  final GetAllSubjectsUseCase getAllSubjectsUseCase;

  GetAllSubjectsViewModel({required this.getAllSubjectsUseCase})
      : super(GetAllSubjectsInitialState());
  List<GetAllSubjectsRequest> allSubjects = [];
  List<GetAllSubjectsRequest> filteredSubjects = [];
  // Form Key & Controller
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  void searchSubjects(String query) async {
    if (query.isEmpty) {
      filteredSubjects = List.from(allSubjects);
    } else {
      filteredSubjects = allSubjects
          .where((subject) =>
              subject.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();

    }

    emit(GetAllSubjectsSuccessState(
        getAllSubjectsEntity:
            List.from(filteredSubjects)));
  }

  void getAllSubjects() async {
    emit(GetAllSubjectsLoadingState());

    final result = await AuthRepositoryImpl(
            remoteDataSource:
                AuthRemoteDataSourceImpl(apiService: ApiService()))
        .getAllSubjects(
            nameController.text, iconController.text);

    if (result is Success<List<GetAllSubjectsRequest>>) {
      allSubjects = result.data
          .map((e) => GetAllSubjectsRequest(name: e.name, icon: e.icon))
          .toList();
      filteredSubjects = List.from(allSubjects);
      emit(GetAllSubjectsSuccessState(getAllSubjectsEntity: filteredSubjects));
    } else if (result is Failure) {
      emit(GetAllSubjectsErrorState(result.message));
    }
  }
}
