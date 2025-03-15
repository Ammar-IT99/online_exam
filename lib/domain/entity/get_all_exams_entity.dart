import 'package:online_exam/domain/entity/exams_entity.dart';
import 'package:online_exam/domain/entity/meta_data_entity.dart';

class GetAllExamsEntity {
  String? message;
  MetaDataEntity? metaData;
  List<ExamsEntity>? exams;
  GetAllExamsEntity({this.message,this.metaData,this.exams});
  factory GetAllExamsEntity.fromJson(Map<String, dynamic> json) {
    return GetAllExamsEntity(
      message: json['message'],
      metaData: json['metaData'] != null ? MetaDataEntity.fromJson(json['metaData']) : null,
      exams: json['exams'] != null
          ? List<ExamsEntity>.from(json['exams'].map((x) => ExamsEntity.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'metaData': metaData?.toJson(),
      'exams': exams?.map((x) => x.toJson()).toList(),
    };
  }
}