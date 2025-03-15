import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/constants/app_strings.dart';
import 'package:online_exam/data/models/request/get_all_subjects_request.dart';
import 'package:online_exam/domain/entity/subjects_entity.dart';
import 'package:online_exam/presentation/home/explore/exam_screen.dart';
import 'package:online_exam/presentation/utlis/custom_elevated_button.dart';

class StartExamScreen extends StatefulWidget {
  const StartExamScreen({
    super.key,
  });
  static const String routeName = 'start-exam-screen';
  @override
  State<StartExamScreen> createState() => _StartExamScreenState();
}

class _StartExamScreenState extends State<StartExamScreen> {
  SubjectsEntity? subjectsEntity;
  @override
  Widget build(BuildContext context) {
    final getAllSubjectsRequest =
        ModalRoute.of(context)?.settings.arguments as GetAllSubjectsRequest?;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.blackBase,
          ),
          onPressed: () => Navigator.pushNamed(
            context,
            ExamScreen.routeName,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppStrings.examIcon,
                      width: 48,
                      height: 48,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      getAllSubjectsRequest?.name ?? '',
                      style: TextStyle(
                        color: AppColors.blackBase,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${getAllSubjectsRequest?.examsEntity?.duration ?? 0} Minutes',
                  style: TextStyle(
                    color: AppColors.blueBase,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                Text(getAllSubjectsRequest?.examsEntity?.title ?? '',
                    style: TextStyle(
                        color: AppColors.gray,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp)),
                Text(
                  ' | ',
                  style: TextStyle(
                    color: AppColors.gray,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  '${getAllSubjectsRequest?.examsEntity?.numberOfQuestions ?? 0} Questions',
                  style: TextStyle(
                    color: AppColors.gray,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 32.h,
            ),
            Text(
              'Instructions',
              style: TextStyle(
                color: AppColors.blackBase,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            // Instructions List
            Text(
              '• Lorem ipsum dolor sit amet consecratur.\n'
              '• Lorem ipsum dolor sit amet consectetur.\n'
              '• Lorem ipsum dolor sit amet consectetur.\n'
              '• Lorem ipsum dolor sit amet consectetur.',
              style: TextStyle(
                color: AppColors.gray,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),

            SizedBox(
              height: 48.h,
            ),
            CustomElevatedButton(
              label: AppStrings.start,
              onTap: () {},
              backgroundColor: AppColors.blueBase,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
