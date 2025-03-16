
import 'package:online_exam/data/models/response/answers.dart';
import 'package:online_exam/data/models/response/exam.dart';
import 'package:online_exam/data/models/response/subject.dart';

class Questions {
  List<Answers>? answers;
  String? type;
  String? id;
  String? question;
  String? correct;
  Subject? subject;
  Exam? exam;
  DateTime? createdAt;

  Questions({this.answers, this.type, this.id, this.question, this.correct, this.subject, this.exam, this.createdAt});

  Questions.fromJson(Map<String, dynamic> json) {
    answers = json["answers"] == null
        ? null
        : (json["answers"] as List).map((e) => Answers.fromJson(e)).toList();
    type = json["type"];
    id = json["_id"];
    question = json["question"];
    correct = json["correct"];
    subject = json["subject"] == null ? null : Subject.fromJson(json["subject"]);
    exam = json["exam"] == null ? null : Exam.fromJson(json["exam"]);
    createdAt = json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "answers": answers?.map((e) => e.toJson()).toList(),
      "type": type,
      "_id": id,
      "question": question,
      "correct": correct,
      "subject": subject?.toJson(),
      "exam": exam?.toJson(),
      "createdAt": createdAt?.toIso8601String(),
    };
  }
}
