import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/di.dart';
import '../../utlis/custome_text_form_feild.dart';
import '../../utlis/dialog_utlis.dart';
import '../login/login_screen.dart';
import 'cubit/reset_password_view_model.dart';
import 'cubit/states.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = 'ResetPasswordScreen';


  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final ResetPasswordViewModel viewModel = getIt<ResetPasswordViewModel>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final email = ModalRoute.of(context)?.settings.arguments as String?;
    if (email != null) {
      viewModel.setEmail(email);

    } else {

    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: BlocConsumer<ResetPasswordViewModel, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordLoading) {
            DialogUtils.showLoadingDialog(context, message: 'Loading...');
          } else {
            DialogUtils.hideLoadingDialog(context);
          }

          if (state is ResetPasswordSuccess) {
            DialogUtils.showMessageDialog(
              context,
              message: 'Password has been reset successfully!',
              posButtonTitle: 'OK',
              posButtonAction: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginScreen.routeName,
                      (route) => false,
                );
              },
            );
          } else if (state is ResetPasswordError) {
            DialogUtils.showMessageDialog(
              context,
              message: state.message,
              posButtonTitle: 'Try Again',
            );
          }
        },
        builder: (context, state) {

          return Scaffold(
            appBar: AppBar(
              title: const Text('Password'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            AppStrings.resetPassword,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                          AppStrings.passwordError,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.gray),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomTextFormField(
                      label:AppStrings.newPassword,
                      isPassword: true,
                      controller: viewModel.newPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.pleaseEnterNewPassword;
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
                      isPassword: true,
                      controller: viewModel.confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.pleaseConfirmPassword;
                        }
                        if (value != viewModel.newPasswordController.text) {
                          return AppStrings.rePasswordError;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40.h),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (viewModel.formKey.currentState?.validate() ?? false) {
                            viewModel.resetPassword();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blueBase,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                         AppStrings.continueText,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
