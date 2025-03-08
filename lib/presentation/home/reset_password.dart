import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/constants/app_strings.dart';
import 'package:online_exam/core/di.dart';
import 'package:online_exam/presentation/auth/register/cubit/register_screen_view_model.dart';
import 'package:online_exam/presentation/auth/register/cubit/states.dart';
import 'package:online_exam/presentation/home/profile_screen.dart';
import 'package:online_exam/presentation/utlis/custome_text_form_feild.dart';
import 'package:online_exam/presentation/utlis/dialog_utlis.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});
  static const String routeName = 'reset-password';
  @override
  Widget build(BuildContext context) {
    var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
    final RegisterScreenViewModel viewModel = RegisterScreenViewModel(
      registerUseCase: injectRegisterUseCase(),
    );
    return BlocListener<RegisterScreenViewModel, RegisterState>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          DialogUtlis.showLoadingDialog(context, message: AppStrings.loading);
        } else if (state is RegisterSuccessState) {
          DialogUtlis.hideLoadingDialog(context);
          DialogUtlis.showMessageDialog(
            context,
            message:
                "${AppStrings.registerSuccess}, ${state.authResultEntity.userEntity?.username}",
            posButtonTitle: AppStrings.ok,
            posButtonAction: () {},
          );
        } else if (state is RegisterErrorState) {
          DialogUtlis.hideLoadingDialog(context);
          DialogUtlis.showMessageDialog(
            context,
            message:
                '${AppStrings.registerError}, ${state.errorMessage}\n${AppStrings.pleaseTryAgain}',
            posButtonTitle: AppStrings.ok,
          );
        }
      },
      child: Scaffold(
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
                    GestureDetector(onTap: () => Navigator.pushNamed(context, ProfileScreen.routeName),child: Icon(Icons.arrow_back_ios,color: AppColors.blueBase,),),
                    Text(
                      AppStrings.resetPassword,
                      style: TextStyle(
                          color: AppColors.blueBase,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 24.h,),
                CustomTextFormField(
                  label: AppStrings.currentPassword,
                  controller: currentPasswordController,
                  validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.enterYourPassword;
                          }
                          if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
                              .hasMatch(value)) {
                            return AppStrings.passwordError;
                          }
                          return null;
                        },
                ),
                CustomTextFormField(
                  label: AppStrings.newPassword,
                  controller: newPasswordController,
                  validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.enterYourPassword;
                          }
                          if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
                              .hasMatch(value)) {
                            return AppStrings.passwordError;
                          }
                          return null;
                        },
                ),
                CustomTextFormField(
                  label: AppStrings.confirmPassword,
                  controller: confirmPasswordController,
                  validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.enterYourPassword;
                          }
                          if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
                              .hasMatch(value)) {
                            return AppStrings.passwordError;
                          }
                          return null;
                        },
                ),
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
                        AppStrings.update,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
