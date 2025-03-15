// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:online_exam/domain/entity/question_entity.dart';

// class OptionTile extends StatelessWidget {
//   final QuestionAnswers questionAnswer;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const OptionTile({super.key, required this.questionAnswer, required this.isSelected, required this.onTap, required String questionId});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<QuestionCubit, QuestionState>(
//       builder: (context, state) {
//         return GestureDetector(
//           onTap:()  =>onTap(),
//           child: Container(
//             margin: const EdgeInsets.symmetric(vertical: 8.0),
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.lightBlueAccent : Colors.lightBlue,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: ListTile(
//               leading: Radio.adaptive(
//                 activeColor: Colors.blue,
//                 toggleable: true,
//                 useCupertinoCheckmarkStyle: true,
//                 fillColor: WidgetStatePropertyAll(
//                     WidgetStateColor.resolveWith((states) => Colors.blue,)),
//                 value: isSelected ,
//                 groupValue: true,
//                 onChanged: (value) => onTap()),
//               title: Text(questionAnswer.answer),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }