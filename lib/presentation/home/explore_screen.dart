import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/constants/app_strings.dart';
import 'package:online_exam/presentation/utlis/custom_browse_by_subject.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(top: 46.h),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  AppStrings.surveyAppBar,
                  style: TextStyle(
                      color: AppColors.blueBase,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 16.h,
                left: 16.w,
                right: 16.w,
              ),
              child: SizedBox(
                width: 384.w,
                height: 48.h,
                child: TextFormField(
                  controller: searchController,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: AppColors.blackOverThirty,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      borderSide: BorderSide(
                        color: AppColors.gray,
                      ),
                    ),
                    hintStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackOverThirty),
                    border: InputBorder.none,
                    hintText: AppStrings.search,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 180.w,
              ),
              child: Text(
                AppStrings.browseBySubject,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            CustomBrowseBySubject(
              imagePath: AppStrings.languageTranslator,
              subject: AppStrings.language,
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomBrowseBySubject(
              imagePath: AppStrings.mathSubject,
              subject: AppStrings.math,
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomBrowseBySubject(
              imagePath: AppStrings.artSubject,
              subject: AppStrings.art,
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomBrowseBySubject(
              imagePath: AppStrings.microscope,
              subject: AppStrings.science,
            ),
          ],
        ),
      )),
    );
  }
}
