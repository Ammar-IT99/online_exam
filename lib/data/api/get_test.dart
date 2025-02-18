import 'dart:convert';

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
  final String createdAt;

  Subject({required this.id, required this.name, required this.icon, required this.createdAt});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['_id'],
      name: json['name'],
      icon: json['icon'],
      createdAt: json['createdAt'],
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
  final String createdAt;

  Exam({required this.id, required this.title, required this.duration, required this.subject, required this.numberOfQuestions, required this.active, required this.createdAt});

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
}

class Question {
  final String id;
  final String type;
  final String question;
  final String correct;
  final List<Answer> answers;
  final Subject subject;
  final Exam exam;
  final String createdAt;

  Question({required this.id, required this.type, required this.question, required this.correct, required this.answers, required this.subject, required this.exam, required this.createdAt});

  factory Question.fromJson(Map<String, dynamic> json) {
    var answersList = json['answers'] as List;
    List<Answer> answers = answersList.map((i) => Answer.fromJson(i)).toList();

    return Question(
      id: json['_id'],
      type: json['type'],
      question: json['question'],
      correct: json['correct'],
      answers: answers,
      subject: Subject.fromJson(json['subject']),
      exam: Exam.fromJson(json['exam']),
      createdAt: json['createdAt'],
    );
  }
}

class QuestionsResponse {
  final String message;
  final List<Question> questions;

  QuestionsResponse({required this.message, required this.questions});

  factory QuestionsResponse.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);

    var questionsList = json['questions'] as List;
    List<Question> questions = questionsList.map((i) => Question.fromJson(i)).toList();

    return QuestionsResponse(
      message: json['message'],
      questions: questions,
    );
  }
}
