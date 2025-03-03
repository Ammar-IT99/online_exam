import 'package:online_exam/data/models/request/allquestions_onexam.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<AllQuestionOnExam> fetchAllQuestionOnExam(String examId) async {
  final response = await http.get(
    Uri.parse('https://exam.elevateegy.com/api/v1/questions?exam=$examId'),
  );

  if (response.statusCode == 200) {
    return AllQuestionOnExam.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load exam questions');
  }
}
