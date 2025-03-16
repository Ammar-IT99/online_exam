class Exam {
  String? id;
  String? title;
  int? duration;
  String? subject;
  int? numberOfQuestions;
  bool? active;
  DateTime? createdAt;

  Exam({this.id, this.title, this.duration, this.subject, this.numberOfQuestions, this.active, this.createdAt});

  Exam.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"];
    duration = json["duration"];
    subject = json["subject"];
    numberOfQuestions = json["numberOfQuestions"];
    active = json["active"];
    createdAt = json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "duration": duration,
      "subject": subject,
      "numberOfQuestions": numberOfQuestions,
      "active": active,
      "createdAt": createdAt?.toIso8601String(),
    };
  }
}