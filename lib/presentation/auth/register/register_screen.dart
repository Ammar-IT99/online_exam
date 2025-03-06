import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/presentation/auth/register/cubit/register_screen_view_model.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/di.dart';
import '../../utlis/custome_text_form_feild.dart';
import '../../utlis/dialog_utlis.dart';
import '../login/login_screen.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = 'Register Screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterScreenViewModel viewModel = RegisterScreenViewModel(
    registerUseCase: injectRegisterUseCase(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterScreenViewModel, RegisterState>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          DialogUtlis.showLoadingDialog(context, message: AppStrings.loading);
        } else if (state is RegisterSuccessState) {
          DialogUtlis.hideLoadingDialog(context);
          DialogUtlis.showMessageDialog(
            context,
            message: "${AppStrings.registerSuccess}, ${state.authResultEntity.userEntity?.username}",
            posButtonTitle: AppStrings.ok,
            posButtonAction: () {},
          );
        } else if (state is RegisterErrorState) {
          DialogUtlis.hideLoadingDialog(context);
          DialogUtlis.showMessageDialog(
            context,
            message: '${AppStrings.registerError}, ${state.errorMessage}\n${AppStrings.pleaseTryAgain}',
            posButtonTitle: AppStrings.ok,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.signup),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.formKey,
            child: ListView(
              children: <Widget>[
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
                    const SizedBox(width: 15),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterYourEmail;
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return AppStrings.emailError;
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        label: AppStrings.password,
                        isPassword: true,
                        controller: viewModel.passwordController,
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
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: CustomTextFormField(
                        label: AppStrings.confirmPassword,
                        isPassword: true,
                        controller: viewModel.confirmPasswordController,
                        validator: (value) => value != viewModel.passwordController.text
                            ? AppStrings.rePasswordError
                            : null,
                      ),
                    ),
                  ],
                ),
                CustomTextFormField(
                  label: AppStrings.phoneNumber,
                  keyboardType: TextInputType.phone,
                  controller: viewModel.phoneNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterYourPhoneNumber;
                    }
                    if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(value)) {
                      return AppStrings.phoneNumberError;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (viewModel.formKey.currentState?.validate() ?? false) {
                      viewModel.register();
                    }
                  },
                  child: const Text(AppStrings.signup),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppStrings.alreadyHaveAccount),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      child: const Text(
                        AppStrings.login,
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
