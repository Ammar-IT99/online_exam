import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/constants/app_strings.dart';
import 'package:online_exam/core/di.dart';
import 'package:online_exam/presentation/auth/login/login_screen.dart';
import 'package:online_exam/presentation/auth/register/cubit/register_screen_view_model.dart';
import 'package:online_exam/presentation/auth/register/cubit/states.dart';

import 'package:online_exam/presentation/home/profile/reset_password.dart';
import 'package:online_exam/presentation/utlis/custom_elevated_button.dart';
import 'package:online_exam/presentation/utlis/custome_text_form_feild.dart';
import 'package:online_exam/presentation/utlis/dialog_utlis.dart';

import '../home_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routeName = 'profile-screen';

  @override
  Widget build(BuildContext context) {
    final RegisterScreenViewModel viewModel = getIt<RegisterScreenViewModel>();

    return BlocListener<RegisterScreenViewModel, RegisterState>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          DialogUtils.showLoadingDialog(context, message: AppStrings.loading);
        } else if (state is RegisterSuccessState) {
          DialogUtils.hideLoadingDialog(context);
          DialogUtils.showMessageDialog(
            context,
            message:
            "${AppStrings.registerSuccess}, ${state.authResultEntity.userEntity?.username}",
            posButtonTitle: AppStrings.ok,
            posButtonAction: () {},
          );
        } else if (state is RegisterErrorState) {
          DialogUtils.hideLoadingDialog(context);
          DialogUtils.showMessageDialog(
            context,
            message:
            '${AppStrings.registerError}, ${state.errorMessage}\n${AppStrings.pleaseTryAgain}',
            posButtonTitle: AppStrings.ok,
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 46.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 16.w),
                        GestureDetector(
                      onTap: () => Navigator.pushNamed(context, HomeScreen.routeName),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.blueBase,
                      ),
                    ),
                    Text(
                      AppStrings.profileAppBar,
                      style: TextStyle(
                          color: AppColors.blueBase,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500),
                    ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      icon: Icon(
                      Icons.logout,
                      color: AppColors.red,
                        )
                    )
                  ],
                ),
                SizedBox(height: 24.h),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: AssetImage(AppStrings.photo),
                      ),
                      Positioned(
                        bottom: 0.h,
                        right: 0.w,
                        child: Image.asset(AppStrings.camera),
                      ),
                    ],
                  ),
                ),
                CustomTextFormField(
                  label: AppStrings.userName,
                  controller: viewModel.userNameController,
                  validator: (value) => value?.isEmpty ?? true
                      ? AppStrings.enterYourUserName
                      : null,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        label: AppStrings.firstName,
                        controller: viewModel.firstNameController,
                        validator: (value) => value?.isEmpty ?? true
                            ? AppStrings.enterYourFirstName
                            : null,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomTextFormField(
                        label: AppStrings.lastName,
                        controller: viewModel.lastNameController,
                        validator: (value) => value?.isEmpty ?? true
                            ? AppStrings.enterYourLastName
                            : null,
                      ),
                    ),
                  ],
                ),
                CustomTextFormField(
                  label: AppStrings.email,
                  keyboardType: TextInputType.emailAddress,
                  controller: viewModel.emailController,
                ),
                CustomTextFormField(
                  label: AppStrings.password,
                  isPassword: true,
                  controller: viewModel.passwordController,
                  widget: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ResetPassword.routeName);
                    },
                    child: Text(
                      AppStrings.change,
                      style: TextStyle(
                        color: AppColors.blueBase,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
                CustomTextFormField(
                  label: AppStrings.phoneNumber,
                  keyboardType: TextInputType.phone,
                  controller: viewModel.phoneNumberController,
                ),
                Padding(
                  padding: EdgeInsets.all(12.r),
                  child: CustomElevatedButton(
                    label: AppStrings.update,
                    onTap: () {},
                    borderColor: AppColors.blackOverThirty,
                    backgroundColor: AppColors.blackOverThirty,
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
