class AllQuestionOnExam {
  final String message;
  final List<AllquestionOnexam> questions;

  AllQuestionOnExam({required this.message, required this.questions});

  factory AllQuestionOnExam.fromJson(Map<String, dynamic> json) {
    return AllQuestionOnExam(
      message: json['message'],
      questions: List<AllquestionOnexam>.from(
          json['questions'].map((x) => AllquestionOnexam.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'questions': List<dynamic>.from(questions.map((x) => x.toJson())),
    };
  }
}

class AllquestionOnexam {
  final List<Answer> answers;
  final String type;
  final String id;
  final String question;
  final String correct;
  final Subject subject;
  final Exam exam;
  final String createdAt;

  AllquestionOnexam({
    required this.answers,
    required this.type,
    required this.id,
    required this.question,
    required this.correct,
    required this.subject,
    required this.exam,
    required this.createdAt,
  });

  factory AllquestionOnexam.fromJson(Map<String, dynamic> json) {
    return AllquestionOnexam(
      answers:
          List<Answer>.from(json['answers'].map((x) => Answer.fromJson(x))),
      type: json['type'],
      id: json['_id'],
      question: json['question'],
      correct: json['correct'],
      subject: Subject.fromJson(json['subject']),
      exam: Exam.fromJson(json['exam']),
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answers': List<dynamic>.from(answers.map((x) => x.toJson())),
      'type': type,
      '_id': id,
      'question': question,
      'correct': correct,
      'subject': subject.toJson(),
      'exam': exam.toJson(),
      'createdAt': createdAt,
    };
  }
}

class Answer {
  final String answer;
  final String key;

  Answer({
    required this.answer,
    required this.key,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answer: json['answer'],
      key: json['key'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'key': key,
    };
  }
}

class Subject {
  final String id;
  final String name;
  final String icon;
  final String createdAt;

  Subject({
    required this.id,
    required this.name,
    required this.icon,
    required this.createdAt,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['_id'],
      name: json['name'],
      icon: json['icon'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'icon': icon,
      'createdAt': createdAt,
    };
  }
}

class Exam {
  final String id;
  final String title;
  final int duration;
  final String subject;
  final int numberOfQuestions;
  final bool active;
  final String createdAt;

  Exam({
    required this.id,
    required this.title,
    required this.duration,
    required this.subject,
    required this.numberOfQuestions,
    required this.active,
    required this.createdAt,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['_id'],
      title: json['title'],
      duration: json['duration'],
      subject: json['subject'],
      numberOfQuestions: json['numberOfQuestions'],
      active: json['active'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'duration': duration,
      'subject': subject,
      'numberOfQuestions': numberOfQuestions,
      'active': active,
      'createdAt': createdAt,
    };
  }
}
