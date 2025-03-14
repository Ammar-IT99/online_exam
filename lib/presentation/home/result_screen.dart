import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/constants/app_strings.dart';
import 'package:online_exam/presentation/home/home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});
 static const routeName = 'resultScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 46.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 16.w,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, HomeScreen.routeName),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.blueBase,
                    ),
                  ),
                  Text(
                    AppStrings.examScore,
                    style: TextStyle(
                        color: AppColors.blueBase,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                children: [
                  SizedBox(width: 16.w,),
                  Stack(children: [Image.asset(AppStrings.circularDeterminate),Padding(padding: EdgeInsets.all(48),child:Text('80%',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500),),),],),
                  SizedBox(
                    width: 23.w,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(AppStrings.correct,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: AppColors.blueBase),),
                          SizedBox(width: 70.w,),
                          Container(width: 25,height: 25,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30.r),),border: Border.all(color: AppColors.blueBase,),),child: Center(child: Text('18',style: TextStyle(color: AppColors.blueBase,fontSize: 13.sp,fontWeight: FontWeight.w500),),),),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Text(AppStrings.incorrect,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: Colors.red,),),
                          SizedBox(width: 60.w,),
                          Container(width: 25,height: 25,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30.r),),border: Border.all(color: Colors.red,),),child: Center(child: Text('2',style: TextStyle(color: Colors.red,fontSize: 13.sp,fontWeight: FontWeight.w500),),),),
                        ],
                      ),                      
                    ],
                  ),
                ],
              ),
              SizedBox(height: 80.h,),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 340.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100.r),
                        ),
                        color: AppColors.blueBase),
                    child: Center(
                      child: Text(
                        AppStrings.showResult,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h,),
                 GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 340.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.blueBase),
                        borderRadius: BorderRadius.all(
                          Radius.circular(100.r),
                        ),
                        color: Colors.white),
                    child: Center(
                      child: Text(
                        AppStrings.startAgain,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blueBase),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
