import 'package:flutter/material.dart';
import 'package:online_exam/core/constants/app_strings.dart';

class CustomTextButton extends StatelessWidget {
  Color color;
  Color textColor;
  String text;
  void Function()? onPressed;

  CustomTextButton(
      {required this.onPressed,
      required this.text,
      required this.color,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side:
                      const BorderSide(color: AppColors.blueBase, width: 2))),
          onPressed: onPressed,
          child: Text(text,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16))),
    );
  }
}