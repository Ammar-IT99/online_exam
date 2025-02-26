import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_exam/data/models/request/all_questions.dart';
import 'package:online_exam/data/models/response/test_response.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  QuestionPageState createState() => QuestionPageState();
}

class QuestionPageState extends State<QuestionPage> {
  QuestionsResponse questionsResponse =
      QuestionsResponse(questions: [], message: '');
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestion();
  }

  fetchQuestion() async {
    try {
      final response = await http
          .get(Uri.parse('https://exam.elevateegy.com/api/v1/questions'));
      if (response.statusCode == 200) {
        setState(() {
          questionsResponse = QuestionsResponse.fromJson(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load questions: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QuestionPage'),
      ),
      body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: questionsResponse.questions.length,
                  itemBuilder: (context, index) {
                    Question question = questionsResponse.questions[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              question.question,
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            ...List.generate(question.answers.length, (index) {
                              return ElevatedButton(
                                onPressed: () {
                                  // Handle answer selection
                                },
                                child: Text(question.answers[index].answer),
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}
