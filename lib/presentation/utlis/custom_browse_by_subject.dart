import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBrowseBySubject extends StatelessWidget {
  const CustomBrowseBySubject({super.key,required this.imagePath,required this.subject});
  final String imagePath;
  final String subject;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 80.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white70),
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.r,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 16.h, bottom: 16.h, left: 24.w),
        child: Row(
          children: [
            Image.asset(imagePath),
            SizedBox(
              width: 8.w,
            ),
            Text(
              subject,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );

  }
}
