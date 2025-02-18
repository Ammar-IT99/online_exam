import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:online_exam/data/models/request/allexams_onsubject.dart';


final String apiUrl =
    "https://exam.elevateegy.com/api/v1/exams?subject=670037f6728c92b7fdf434fc";

Future<List<AllexamsOnsubject>> fetchAllexamsOnsubject() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body)['exams'];
    List<AllexamsOnsubject> exams = body.map((dynamic item) => AllexamsOnsubject.fromJson(item)).toList();
    return exams;
  } else {
    throw Exception('Failed to load exams');
  }
}
