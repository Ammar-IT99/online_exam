import 'package:online_exam/domain/entity/meta_data_entity.dart';
import 'package:online_exam/domain/entity/subjects_entity.dart';

class GetAllSubjectsEntity {
  String? message;
  MetaDataEntity? metaData;
  List<SubjectsEntity>? subjects;
  GetAllSubjectsEntity({this.message,this.metaData,this.subjects});
  factory GetAllSubjectsEntity.fromJson(Map<String, dynamic> json) {
    return GetAllSubjectsEntity(
      message: json['message'],
      metaData: json['metaData'] != null ? MetaDataEntity.fromJson(json['metaData']) : null,
      subjects: json['subjects'] != null
          ? List<SubjectsEntity>.from(json['subjects'].map((x) => SubjectsEntity.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'metaData': metaData?.toJson(),
      'subjects': subjects?.map((x) => x.toJson()).toList(),
    };
  }
}