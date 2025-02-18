import 'package:flutter/material.dart';
import 'package:online_exam/data/api/api/all_questions.dart';
import 'package:online_exam/data/models/request/all_questions.dart';

FutureBuilder<AllQuestions> allQuestions() {
  return FutureBuilder<AllQuestions>(
    future: fetchAllQuestions(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        final examSubject = snapshot.data!;
        return ListView.builder(
          itemCount: examSubject.questions.length,
          itemBuilder: (context, index) {
            final question = examSubject.questions[index];
            return ListTile(
              title: Text(question.question),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: question.answers.map((answer) {
                  return Text('Answer: ${answer.answer} (Key: ${answer.key})');
                }).toList(),
              ),
            );
          },
        );
      } else {
        return Text('No data available');
      }
    },
  );
}
