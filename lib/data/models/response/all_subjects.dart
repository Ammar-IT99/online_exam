  import 'package:online_exam/data/api/api/all_subjects.dart';

void main() async {
  final subjects = await fetchSubjects();
  
  if (subjects.isNotEmpty) {
    for (var subject in subjects) {
      print('ID: ${subject.id}');
      print('Name: ${subject.name}');
      print('Icon: ${subject.icon}');
      print('Created At: ${subject.createdAt}');
      print('----------------------');
    }
  }
}