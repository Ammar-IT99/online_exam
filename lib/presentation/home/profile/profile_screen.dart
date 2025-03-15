import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/constants/app_strings.dart';
import 'package:online_exam/core/di.dart';
import 'package:online_exam/presentation/auth/login/login_screen.dart';
import 'package:online_exam/presentation/home/profile/cubit/profile_screen_view_model.dart';
import 'package:online_exam/presentation/home/profile/cubit/states.dart';
import 'package:online_exam/presentation/home/profile/update_password.dart';
import 'package:online_exam/presentation/utlis/custom_elevated_button.dart';
import 'package:online_exam/presentation/utlis/custome_text_form_feild.dart';
import '../../../domain/entity/get_user_info_entity.dart';
import '../../auth/log_out_cubit/log_out_cubit.dart';
import '../../auth/log_out_cubit/states.dart';


@injectable
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String routeName = 'profile-screen';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LogOutCubit>()),
        BlocProvider(
            create: (context) => getIt<ProfileViewModel>()..fetchUserInfo()),
      ],
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 46.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 16.w),
                    Text(
                      AppStrings.profileAppBar,
                      style: TextStyle(
                        color: AppColors.blueBase,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    BlocConsumer<LogOutCubit, LogOutState>(
                      listener: (context, state) {
                        if (state is LogOutLoading) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(AppStrings.loading),
                                backgroundColor: AppColors.blueBase),
                          );
                        } else if (state is LogOutLoggedOut) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(AppStrings.loggedOutSuccess),
                                backgroundColor: AppColors.blueBase),
                          );
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginScreen.routeName,
                            (route) => false,
                          );
                        } else if (state is LogOutError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${AppStrings.error} ${state.error}")),
                          );
                        }
                      },
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            context.read<LogOutCubit>().logOut();
                          },
                          icon: Icon(Icons.logout, color: AppColors.red),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                BlocBuilder<ProfileViewModel, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ProfileLoaded) {
                      return _buildProfileContent(context, state.userInfo);
                    } else if (state is ProfileError) {
                      return Center(
                          child: Text("${AppStrings.error} ${state.error}",
                              style: TextStyle(color: Colors.red)));
                    }
                    return Center(child: Text(AppStrings.update));
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(12.r),
                  child: CustomElevatedButton(
                    label: AppStrings.update,
                    onTap: () {},
                    backgroundColor: AppColors.blueBase,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, UserInfoEntity userInfo) {
    return Column(
      children: [
        CustomTextFormField(
            label: AppStrings.userName,
            controller: TextEditingController(text: userInfo.username)),
        CustomTextFormField(
            label: AppStrings.firstName,
            controller: TextEditingController(text: userInfo.firstName)),
        CustomTextFormField(
            label: AppStrings.lastName,
            controller: TextEditingController(text: userInfo.lastName)),
        CustomTextFormField(
            label: AppStrings.email,
            keyboardType: TextInputType.emailAddress,
            controller: TextEditingController(text: userInfo.email)),
        CustomTextFormField(
            label: AppStrings.phoneNumber,
            keyboardType: TextInputType.phone,
            controller: TextEditingController(text: userInfo.phone)),
        CustomTextFormField(
          label: AppStrings.password,
          isPassword: true,
          controller: TextEditingController(text: '********'),
          widget: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, UpdatePassword.routeName);
            },
            child: Text(
             AppStrings.change,
              style: TextStyle(
                color: AppColors.blueBase,
                fontSize: 20.sp,
              ),
            ),
          ),
        )
      ],
    );
  }
}
