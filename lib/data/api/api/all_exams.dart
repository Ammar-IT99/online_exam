import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_exam/data/models/request/all_exams.dart';

final String apiUrl = "https://exam.elevateegy.com/api/v1/exams";

Future<List<AllExams>> fetchAllExams() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body)['exams'];
    List<AllExams> exams = body.map((dynamic item) => AllExams.fromJson(item)).toList();
    return exams;
  } else {
    throw Exception('Failed to load exams');
  }
}
