import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:online_exam/core/constants/app_strings.dart';
import 'package:online_exam/presentation/auth/login/cubit/login_screen_view_model.dart';
import 'package:online_exam/presentation/auth/register/register_screen.dart';
import 'package:online_exam/presentation/home/home_screen.dart';
import '../../../core/di.dart';
import '../../utlis/custom_elevated_button.dart';
import '../../utlis/custome_text_form_feild.dart';
import '../../utlis/dialog_utlis.dart';
import '../forgotPassword/forgot_password_screen.dart';
import 'cubit/states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginScreenViewModel viewModel = getIt<LoginScreenViewModel>();

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  void _loadRememberMe() async {
    String? remember = await secureStorage.read(key: 'rememberMe');
    setState(() {
      rememberMe = remember == 'true';
      if (rememberMe) {
        secureStorage.read(key: 'email').then((value) {
          viewModel.emailController.text = value ?? '';
        });
        secureStorage.read(key: 'password').then((value) {
          viewModel.passwordController.text = value ?? '';
        });
      }
    });
  }

  void _saveRememberMe() async {
    if (rememberMe) {
      await secureStorage.write(key: 'rememberMe', value: 'true');
      await secureStorage.write(
          key: 'email', value: viewModel.emailController.text);
      await secureStorage.write(
          key: 'password', value: viewModel.passwordController.text);
    } else {
      await secureStorage.deleteAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: viewModel,
      listener: (context, state) {
        if (state is SignInLoadingState) {
          DialogUtils.showLoadingDialog(context, message: AppStrings.loading);
        } else if (state is SignInSuccessState) {
          DialogUtils.hideLoadingDialog(context);
          DialogUtils.showMessageDialog(
            context,
            message: "${AppStrings.loginSuccess}\n${state.authResultEntity.userEntity?.username}",
            posButtonTitle: AppStrings.ok,
            posButtonAction: () {
              Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName,(route)=>false,);
            },
          );
        } else if (state is SignInErrorState) {
          DialogUtils.hideLoadingDialog(context);
          DialogUtils.showMessageDialog(
            context,
            message: '${state.errorMessage}${AppStrings.pleaseTryAgain}',
            posButtonTitle: AppStrings.ok,
            posButtonAction: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.login),
          backgroundColor: AppColors.blueBase,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.formKey,
            child: ListView(
              children: <Widget>[
                CustomTextFormField(
                  label: AppStrings.email,
                  keyboardType: TextInputType.emailAddress,
                  controller: viewModel.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterYourEmail;
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  label: AppStrings.password,
                  isPassword: true,
                  controller: viewModel.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterYourPassword;
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          activeColor: AppColors.blueBase,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value ?? false;
                            });
                          },
                        ),
                        const Text(AppStrings.rememberMe),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ForgotPasswordScreen.routeName);
                      },
                      child:  Text(
                        AppStrings.forgetPassword,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 12.0,

                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  label: AppStrings.login,
                  onTap: () {
                    if (viewModel.formKey.currentState!.validate()) {
                      _saveRememberMe();
                      viewModel.signIn();
                    }
                  },

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppStrings.doNotHaveAccount),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: const Text(
                        AppStrings.signup,
                        style: TextStyle(
                          color: AppColors.blueBase,
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