import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_exam/data/models/request/exam_by_id.dart';

final String apiUrl =
    "https://exam.elevateegy.com/api/v1/exams/6700707030a3c3c1944a9c5d";

Future<ExamId> fetchExamId(String id) async {
  final response = await http.get(Uri.parse('$apiUrl/$id'));

  if (response.statusCode == 200) {
    Map<String, dynamic> body = jsonDecode(response.body)['exam'];
    return ExamId.fromJson(body);
  } else {
    throw Exception('Failed to load exam');
  }
}
