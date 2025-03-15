import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/constants/app_strings.dart';

class CustomExamCardItem extends StatelessWidget {
  final String title;
  final String? id;
  final int numberOfQuestions;
  final int duration;
  const CustomExamCardItem(
      {super.key,
      required this.title,
      required this.numberOfQuestions,
      required this.duration,
      this.id});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 11,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppStrings.examIcon,
              height: 71.h,
              width: 60.w,
            ), // Placeholder for custom image
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: AppColors.blackBase),
                  ),
                  Text(
                    '$numberOfQuestions Question',
                    style: TextStyle(
                      color: AppColors.gray,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'From: 1.00   To: 6.00',
                    style: TextStyle(
                      color: AppColors.blackBase,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '$duration Minutes',
              style: TextStyle(
                color: AppColors.blueBase,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
