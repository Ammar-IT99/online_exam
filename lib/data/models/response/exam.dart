class Exam {
  Exam({
      this.id, 
      this.title, 
      this.duration, 
      this.subject, 
      this.numberOfQuestions, 
      this.active, 
      this.createdAt,});

  Exam.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    duration = json['duration'];
    subject = json['subject'];
    numberOfQuestions = json['numberOfQuestions'];
    active = json['active'];
    createdAt = json['createdAt'];
  }
  String? id;
  String? title;
  int? duration;
  String? subject;
  int? numberOfQuestions;
  bool? active;
  String? createdAt;
Exam copyWith({  String? id,
  String? title,
  int? duration,
  String? subject,
  int? numberOfQuestions,
  bool? active,
  String? createdAt,
}) => Exam(  id: id ?? this.id,
  title: title ?? this.title,
  duration: duration ?? this.duration,
  subject: subject ?? this.subject,
  numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
  active: active ?? this.active,
  createdAt: createdAt ?? this.createdAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['duration'] = duration;
    map['subject'] = subject;
    map['numberOfQuestions'] = numberOfQuestions;
    map['active'] = active;
    map['createdAt'] = createdAt;
    return map;
  }



}