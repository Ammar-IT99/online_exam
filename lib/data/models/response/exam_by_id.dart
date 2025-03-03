import 'package:flutter/material.dart';
import 'package:online_exam/data/api/api/exam_by_id.dart';
import 'package:online_exam/data/models/request/exam_by_id.dart';

FutureBuilder<ExamId> examById() {
  return FutureBuilder<ExamId>(
    future: fetchExamId(''),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        final exam = snapshot.data!;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Title: ${exam.title}', style: TextStyle(fontSize: 20)),
            Text('Duration: ${exam.duration} minutes',
                style: TextStyle(fontSize: 16)),
            Text('Subject: ${exam.subject}', style: TextStyle(fontSize: 16)),
            Text('Number of Questions: ${exam.numberOfQuestions}',
                style: TextStyle(fontSize: 16)),
            Text('Active: ${exam.active}', style: TextStyle(fontSize: 16)),
            Text('Created At: ${exam.createdAt}',
                style: TextStyle(fontSize: 16)),
          ],
        );
      } else {
        return Text('No data available');
      }
    },
  );
}
