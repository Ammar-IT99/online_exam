class ExamsEntity {
  String? id;
  String? title;
  int? duration;
  String? subjects;
  int? numberOfQuestions;
  bool? active;
  DateTime? createdAt;
  ExamsEntity({this.id,this.title,this.duration,this.subjects,this.numberOfQuestions,this.active,this.createdAt});
  factory ExamsEntity.fromJson(Map<String,dynamic> json){
    return ExamsEntity(
      id: json['_id'],
      title: json['title'],
      duration: json['duration'],
      subjects: json['subjects'],
      numberOfQuestions: json['numberOfQuestions'],
      active: json['active'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
    );
  }
  Map<String,dynamic> toJson(){
    return{
      '_id':id,
      'title':title,
      'duration':duration,
      'subjects':subjects,
      'numberOfQuestions':numberOfQuestions,
      'active':active,
      'createdAt':createdAt?.toIso8601String()
    };
  }
}