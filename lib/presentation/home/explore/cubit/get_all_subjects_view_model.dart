import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/cache_network.dart';
import 'package:online_exam/data/api/api_result.dart';
import 'package:online_exam/data/api/api_service.dart';
import 'package:online_exam/data/models/request/get_all_subjects_request.dart';
import 'package:online_exam/data/models/response/get_single_subject_dto.dart';
import 'package:online_exam/data/repository/data_source_impl/auth_remote_data_source_impl.dart';
import 'package:online_exam/data/repository/repository_impl/auth_repository_impl.dart';
import 'package:online_exam/domain/entity/get_all_subjects_entity.dart';
import 'package:online_exam/domain/entity/get_single_subjects_entity.dart';
import 'package:online_exam/domain/entity/subjects_entity.dart';
import 'package:online_exam/domain/repository/repository_contract/auth_repository_contract.dart';
import 'package:online_exam/domain/use_case/get_all_subjects_use_case.dart';
import 'package:online_exam/presentation/forgotPassword/cubit/states.dart';
import 'package:online_exam/presentation/home/explore/cubit/states.dart';
import 'package:http/http.dart' as http;

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
      filteredSubjects = List.from(allSubjects); // إعادة القائمة الأصلية
    } else {
      filteredSubjects = allSubjects
          .where((subject) =>
              subject.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      // Uri url = Uri.parse(
      //     "https://exam.elevateegy.com/api/v1/subjects/6715db9addfd54f0a196ab6c");
      // final token = await CacheNetwork.getCacheData(key: "token") ?? '';
      // var response = await http.get(
      //   url,
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Accept': 'application/json',
      //     'token': '$token',
      //   },
      // ).timeout(const Duration(seconds: 10));
      // if (filteredSubjects.isNotEmpty) {
      //   // عرض رسالة الخطأ في Dialog إذا لم يكن هناك فئات
      //   print('Success');
      // } else {
      //   print('Error');
      // }
    }

    emit(GetAllSubjectsSuccessState(
        getAllSubjectsEntity:
            List.from(filteredSubjects))); // تأكد من إعادة البناء
  }
  // Get All Subjects Function
  // Future<ApiResult<List<GetAllSubjectsEntity>>> getAllSubjects() async {
  //   emit(GetAllSubjectsLoadingState());

  // final token = await CacheNetwork.getCacheData(key: "token"); // Read token from storage
  // print("Loaded Token: $token"); // Debugging

  // if (token == null) {
  //   print("Error: No token found in secure storage");
  //   emit(GetAllSubjectsErrorState("No authentication token available"));
  //   return Failure("No authentication token available");
  // }

  //   final result = await getAllSubjectsUseCase.call(nameController.text, iconController.text);

  //   // switch (result) {
  //   //   case Success(data: final entities):
  //   //     // تحويل البيانات بشكل صحيح إلى List<SubjectsEntity>
  //   //     List<GetAllSubjectsEntity> subjects = entities
  //   //         .where((entity) => entity.subjects != null) // تصفية الكيانات التي تحتوي على null
  //   //         .expand<GetAllSubjectsEntity>((entity) => entities)
  //   //         .toList();

  //   //     emit(GetAllSubjectsSuccessState(getAllSubjectsEntity: subjects));
  //   //     return Success(subjects);

  //   //   case Failure(message: final error):
  //   //     emit(GetAllSubjectsErrorState(error));
  //   //     return Failure(error);
  //   // }
  //   switch (result) {
  //   case Success(data: final entities):
  //     emit(GetAllSubjectsSuccessState(getAllSubjectsEntity: entities));
  //     return Success(entities);

  //   case Failure(message: final error):
  //     emit(GetAllSubjectsErrorState(error));
  //     return Failure(error);
  // }
  // }
  void getAllSubjects() async {
    emit(GetAllSubjectsLoadingState());

    final result = await AuthRepositoryImpl(
            remoteDataSource:
                AuthRemoteDataSourceImpl(apiService: ApiService()))
        .getAllSubjects(
            nameController.text, iconController.text); // استدعاء API

    if (result is Success<List<GetAllSubjectsRequest>>) {
      allSubjects = result.data
          .map((e) => GetAllSubjectsRequest(name: e.name, icon: e.icon))
          .toList();
      filteredSubjects = List.from(allSubjects); // تأكد من نسخ القائمة الأصلية
      emit(GetAllSubjectsSuccessState(getAllSubjectsEntity: filteredSubjects));
    } else if (result is Failure) {
      emit(GetAllSubjectsErrorState(result.message));
    }
  }
}
