import 'package:online_exam/domain/entity/get_single_subjects_entity.dart';

class GetSingleSubjectDto {
  String? message;
  String? category;
  GetSingleSubjectDto({this.message,this.category});
  factory GetSingleSubjectDto.fromJson(Map<String, dynamic> json) {
    return GetSingleSubjectDto(message: json['message'], category: json['category']);
  }
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'category': category,
    };
  }

  GetSingleSubjectsEntity toGetSingleSubjectEntity() {
    return GetSingleSubjectsEntity(
      message: message,
      category: category,
    );
  }
}
