import 'package:flutter/material.dart';
import 'package:online_exam/data/api/api/allexam_onsubject.dart';
import 'package:online_exam/data/models/request/allexams_onsubject.dart';

FutureBuilder<List<AllexamsOnsubject>> allexamsOnsubject() {
  return FutureBuilder<List<AllexamsOnsubject>>(
    future: fetchAllexamsOnsubject(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        List<AllexamsOnsubject>? exams = snapshot.data;
        return ListView.builder(
          itemCount: exams!.length,
          itemBuilder: (context, index) {
            AllexamsOnsubject exam = exams[index];
            return ListTile(
              title: Text(exam.title),
              subtitle: Text('Duration: ${exam.duration} mins'),
            );
          },
        );
      }
    },
  );
}