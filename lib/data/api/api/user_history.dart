import 'dart:convert';

import 'package:online_exam/data/models/request/user_history.dart';
import 'package:http/http.dart' as http;

Future<UserHistory> fetchUserHistory() async {
  final response = await http
      .get(Uri.parse('https://exam.elevateegy.com/api/v1/questions/history'));

  if (response.statusCode == 200) {
    return UserHistory.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user history');
  }
}

Future<void> sendUserHistory(UserHistory userHistory) async {
  final response = await http.post(
    Uri.parse('https://exam.elevateegy.com/api/v1/questions/history'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userHistory.toJson()),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to send user history');
  }
}
