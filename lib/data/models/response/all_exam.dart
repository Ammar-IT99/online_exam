import 'package:flutter/material.dart';
import 'package:online_exam/data/models/request/all_exams.dart';
import '../../api/api/all_exams.dart';

FutureBuilder<List<AllExams>> allExam() {
  return FutureBuilder<List<AllExams>>(
    future: fetchAllExams(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        List<AllExams>? exams = snapshot.data;
        return ListView.builder(
          itemCount: exams!.length,
          itemBuilder: (context, index) {
            AllExams exam = exams[index];
            return ListTile(
              title: Text(exam.title),
              subtitle: Text(
                  'Duration: ${exam.duration} mins | Questions: ${exam.numberOfQuestions} | Subject ID: ${exam.subject} | Created At: ${exam.createdAt}'),
            );
          },
        );
      }
    },
  );
}
