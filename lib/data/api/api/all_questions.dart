import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:online_exam/data/models/request/all_questions.dart';

Future<AllQuestions> fetchAllQuestions() async {
  final response =
      await http.get(Uri.parse('https://exam.elevateegy.com/api/v1/questions'));

  if (response.statusCode == 200) {
    try {
      return AllQuestions.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception('Error parsing JSON: $e');
    }
  } else {
    throw Exception('Failed to load exam subject: ${response.reasonPhrase}');
  }
}
