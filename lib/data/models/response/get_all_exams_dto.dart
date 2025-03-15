import 'package:online_exam/domain/entity/exams_entity.dart';
import 'package:online_exam/domain/entity/get_all_exams_entity.dart';
import 'package:online_exam/domain/entity/meta_data_entity.dart';

class GetAllExamssDto {
  String? message;
  MetaDataEntity? metaData;
  List<ExamsEntity>? exams;
  GetAllExamssDto({this.message,this.metaData,this.exams});
  factory GetAllExamssDto.fromJson(Map<String, dynamic> json) {
  return GetAllExamssDto(
    message: json['message'] ?? '', // Ensure non-null string
    metaData: json['metadata'] != null ? MetaDataEntity.fromJson(json['metadata']) : null,
    exams: (json['exams'] as List?)?.map((e) => ExamsEntity.fromJson(e)).toList() ?? [],
  );
}
  Map<String,dynamic> toJson(){
    return {
      'message': message,
      'metadata': metaData?.toJson(), // ✅ Fix: Convert to JSON properly
      'exams': exams?.map((e) => e.toJson()).toList(),
    };
  }

  GetAllExamsEntity toGetAllExamsEntity() {
  return GetAllExamsEntity(
    message: message ?? '',
    metaData: metaData,
    exams: exams ?? [], // Ensure subjects is never null
  );
}
}