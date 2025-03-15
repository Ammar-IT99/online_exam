import 'package:online_exam/domain/entity/exams_entity.dart';

class GetAllSubjectsRequest {
  String? id;
  String? name;
  String? icon;
  ExamsEntity? examsEntity;
  GetAllSubjectsRequest({this.name, this.icon,this.id,this.examsEntity,});
  factory GetAllSubjectsRequest.fromJson(Map<String, dynamic> json) {
    return GetAllSubjectsRequest(name: json['name'], icon: json['icon'],id:json['_id'],examsEntity: json['exams'] != null ? ExamsEntity.fromJson(json['exams']) : null,);
  }
  Map<String, dynamic> toJson() {
    return {
      '_id':id,
      'name': name,
      'icon': icon,
      'exams': examsEntity?.toJson(),
    };
  }

  GetAllSubjectsRequest toGetAllSubjectsRequest() {
    return GetAllSubjectsRequest(
      name: name,
      icon: icon,
      id: id,
      examsEntity: examsEntity
    );
  }
}
