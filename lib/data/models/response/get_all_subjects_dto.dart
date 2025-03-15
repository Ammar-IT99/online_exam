import 'package:online_exam/domain/entity/get_all_subjects_entity.dart';
import 'package:online_exam/domain/entity/meta_data_entity.dart';
import 'package:online_exam/domain/entity/subjects_entity.dart';

class GetAllSubjectsDto {
  String? message;
  MetaDataEntity? metaData;
  List<SubjectsEntity>? subjects;
  GetAllSubjectsDto({this.message,this.metaData,this.subjects});
  factory GetAllSubjectsDto.fromJson(Map<String, dynamic> json) {
  return GetAllSubjectsDto(
    message: json['message'] ?? '', // Ensure non-null string
    metaData: json['metadata'] != null ? MetaDataEntity.fromJson(json['metadata']) : null,
    subjects: (json['subjects'] as List?)?.map((e) => SubjectsEntity.fromJson(e)).toList() ?? [],
  );
}
  Map<String,dynamic> toJson(){
    return {
      'message': message,
      'metadata': metaData?.toJson(), // ✅ Fix: Convert to JSON properly
      'subjects': subjects?.map((e) => e.toJson()).toList(),
    };
  }

  GetAllSubjectsEntity toGetAllSubjectsEntity() {
  return GetAllSubjectsEntity(
    message: message ?? '',
    metaData: metaData,
    subjects: subjects ?? [], // Ensure subjects is never null
  );
}
}