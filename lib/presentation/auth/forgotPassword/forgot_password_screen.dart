import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/presentation/auth/verify_reset_code/verify_reset_code_screen.dart';
import 'package:online_exam/presentation/utlis/custome_text_form_feild.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/di.dart';
import '../../utlis/dialog_utlis.dart';
import 'cubit/forgot_password_view_model.dart';
import 'cubit/states.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = 'Forgot Password Screen';
   const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordViewModel viewModel = getIt<ForgotPasswordViewModel>();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ForgotPasswordViewModel, ForgotState>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is ForgotLoadingState) {
          DialogUtils.showLoadingDialog(context, message: AppStrings.loading);
        } else if (state is ForgotSuccessState) {
          DialogUtils.hideLoadingDialog(context);
          DialogUtils.showMessageDialog(
            context,
            message: " ${state.forgotPasswordEntity.info}",
            posButtonTitle: AppStrings.ok,
            posButtonAction: () {
              Navigator.pushNamed(
                context,
                VerifyResetCodeScreen.routeName,
                arguments: viewModel.emailController.text,
              );
            },
          );
        }
        else if (state is ForgotErrorState) {
          DialogUtils.hideLoadingDialog(context);
          DialogUtils.showMessageDialog(
            context,
            message: '${state.errorMessage}\n${AppStrings.pleaseTryAgain}',
            posButtonTitle: AppStrings.ok,
            posButtonAction: () {
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(AppStrings.password,
              style: TextStyle(
                color: AppColors.blackBase,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            leading: IconButton(
              icon:  Icon(Icons.arrow_back_ios_new, color: AppColors.blackBase,),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:[
                    const SizedBox(height: 40),
                    Text(AppStrings.forgetPassword,
                      style: TextStyle(
                        color: AppColors.blackBase,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Text(AppStrings.hintEnterEmailToResetPassword,
                      style: TextStyle(
                        color: AppColors.gray,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    CustomTextFormField(
                      label:
                      AppStrings.email,
                      keyboardType: TextInputType.emailAddress, controller: viewModel.emailController,
                      validator:
                          (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.enterYourEmail;
                        }
                        if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return AppStrings.emailError;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(onPressed: (){
                      if (viewModel.formKey.currentState?.validate() ?? false) {
                        viewModel.forgotPassword();
                      }
                    }, child: Text(AppStrings.continueText)),

                  ]
              ),
            ),
          ),

        );
      },
    );
  }
}