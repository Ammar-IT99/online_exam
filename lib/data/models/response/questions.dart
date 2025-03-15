import 'package:online_exam/data/models/request/question_request.dart';

class Questions {
  Questions({
      this.answers, 
      this.type, 
      this.id, 
      this.question, 
      this.correct, 
      this.subject, 
      this.exam, 
      this.createdAt,});

  Questions.fromJson(dynamic json) {
    if (json['answers'] != null) {
      answers = [];
      json['answers'].forEach((v) {
        answers?.add(Answers.fromJson(v));
      });
    }
    type = json['type'];
    id = json['_id'];
    question = json['question'];
    correct = json['correct'];
    subject = json['subject'] != null ? Subject.fromJson(json['subject']) : null;
    exam = json['exam'] != null ? Exam.fromJson(json['exam']) : null;
    createdAt = json['createdAt'];
  }
  List<Answers>? answers;
  String? type;
  String? id;
  String? question;
  String? correct;
  Subject? subject;
  Exam? exam;
  String? createdAt;
Questions copyWith({  List<Answers>? answers,
  String? type,
  String? id,
  String? question,
  String? correct,
  Subject? subject,
  Exam? exam,
  String? createdAt,
}) => Questions(  answers: answers ?? this.answers,
  type: type ?? this.type,
  id: id ?? this.id,
  question: question ?? this.question,
  correct: correct ?? this.correct,
  subject: subject ?? this.subject,
  exam: exam ?? this.exam,
  createdAt: createdAt ?? this.createdAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (answers != null) {
      map['answers'] = answers?.map((v) => v.toJson()).toList();
    }
    map['type'] = type;
    map['_id'] = id;
    map['question'] = question;
    map['correct'] = correct;
    if (subject != null) {
      map['subject'] = subject?.toJson();
    }
    if (exam != null) {
      map['exam'] = exam?.toJson();
    }
    map['createdAt'] = createdAt;
    return map;
  }

}