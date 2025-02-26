import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_exam/data/models/request/allquestions_onexam.dart';

Future<List<Subject>> fetchSubjects() async {
  final url = 'https://exam.elevateegy.com/api/v1/subjects';
  
  try {
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Subject.fromJson(json)).toList();
    } else {
      print('Failed to fetch subjects. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}