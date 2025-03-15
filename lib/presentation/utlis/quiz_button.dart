import 'package:flutter/material.dart';
import 'package:online_exam/core/constants/app_strings.dart';

class QuizButton extends StatelessWidget {
  void Function()? ontap;
  Widget text;
  Color backgroundcolor;
  QuizButton({required this.ontap,required this.text,required this.backgroundcolor});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return InkWell(
      onTap:ontap ,
      child: Container(
        width: width*0.44,
        height: height*0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundcolor,
          border: Border.all(color: AppColors.blueBase)

        ),
        child:  Align(
            alignment: Alignment.center,
            child: text),
      ),
    );
  }
}