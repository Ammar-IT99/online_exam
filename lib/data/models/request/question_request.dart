class QuestionRequest {
  String? message;
  List<Questions>? questions;

  QuestionRequest({this.message, this.questions});

  QuestionRequest.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    questions = json["questions"] == null
        ? null
        : (json["questions"] as List).map((e) => Questions.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "questions": questions?.map((e) => e.toJson()).toList(),
    };
  }
}

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

class Subject {
  String? id;
  String? name;
  String? icon;
  DateTime? createdAt;

  Subject({this.id, this.name, this.icon, this.createdAt});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    icon = json["icon"];
    createdAt = json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "icon": icon,
      "createdAt": createdAt?.toIso8601String(),
    };
  }
}

class Answers {
  String? answer;
  String? key;

  Answers({this.answer, this.key});

  Answers.fromJson(Map<String, dynamic> json) {
    answer = json["answer"];
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    return {
      "answer": answer,
      "key": key,
    };
  }
}
