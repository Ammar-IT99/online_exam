import 'dart:convert';

import 'package:online_exam/data/models/request/all_questions.dart';

class QuestionsResponse {
  final String message;
  final List<Question> questions;

  QuestionsResponse({required this.message, required this.questions});

  factory QuestionsResponse.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);

    var questionsList = json['questions'] as List;
    List<Question> questions =
        questionsList.map((i) => Question.fromJson(i)).toList();

    return QuestionsResponse(
      message: json['message'],
      questions: questions,
    );
  }
}
