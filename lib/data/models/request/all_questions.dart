class AllQuestions {
  final String message;
  final List<Question> questions;

  AllQuestions({
    required this.message,
    required this.questions,
  });

  factory AllQuestions.fromJson(Map<String, dynamic> json) {
    return AllQuestions(
      message: json['message'],
      questions: List<Question>.from(
          json['questions'].map((q) => Question.fromJson(q))),
    );
  }
}

class Question {
  final List<Answer> answers;
  final String type;
  final String id;
  final String question;
  final String correct;
  final Subject subject;
  final Exam exam;
  final DateTime createdAt;

  Question({
    required this.answers,
    required this.type,
    required this.id,
    required this.question,
    required this.correct,
    required this.subject,
    required this.exam,
    required this.createdAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      answers:
          List<Answer>.from(json['answers'].map((a) => Answer.fromJson(a))),
      type: json['type'],
      id: json['_id'],
      question: json['question'],
      correct: json['correct'],
      subject: Subject.fromJson(json['subject']),
      exam: Exam.fromJson(json['exam']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class Answer {
  final String answer;
  final String key;

  Answer({required this.answer, required this.key});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answer: json['answer'],
      key: json['key'],
    );
  }
}

class Subject {
  final String id;
  final String name;
  final String icon;
  final DateTime createdAt;

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
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class Exam {
  final String id;
  final String title;
  final int duration;
  final String subject;
  final int numberOfQuestions;
  final bool active;
  final DateTime createdAt;

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
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}