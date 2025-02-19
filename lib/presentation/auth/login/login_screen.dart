import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/presentation/auth/login/cubit/login_screen_view_model.dart';
import 'package:online_exam/presentation/auth/register/register_screen.dart';
import '../../../core/di.dart';
import '../../utlis/custome_text_form_feild.dart';
import 'cubit/states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenViewModel viewModel = LoginScreenViewModel(
    signInUseCase: injectSignInUseCase(),
  );
  bool rememberMe = false;
  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  void _loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('rememberMe') ?? false;
      if (rememberMe) {
        viewModel.emailController.text = prefs.getString('email') ?? '';
        viewModel.passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  void _saveRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setBool('rememberMe', true);
      await prefs.setString('email', viewModel.emailController.text);
      await prefs.setString('password', viewModel.passwordController.text);
    } else {
      await prefs.remove('rememberMe');
      await prefs.remove('email');
      await prefs.remove('password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: viewModel,
      listener: (context, state) {
        if (state is SignInLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        } else if (state is SignInSuccessState) {
          Navigator.of(context).pop(); // Dismiss the loading dialog
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Success")));
        } else if (state is SignInErrorState) {
          Navigator.of(context).pop(); // Dismiss the loading dialog
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Signin'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.formKey,
            child: ListView(
              children: <Widget>[
                CustomTextFormField(
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: viewModel.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        label: 'Password',
                        isPassword: true,
                        controller: viewModel.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
                              .hasMatch(value)) {
                            return 'Password must be at least 11 characters long and include an uppercase letter, a lowercase letter, a number, and a special character';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            },
                          ),
                          const Text('Remember Me'),
                        ],
                      ),
                      Text('Forget Password?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 12.0))
                    ]),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (viewModel.formKey.currentState!.validate()) {
                      _saveRememberMe();
                      viewModel.signIn();
                      print('email + Password = ${viewModel.emailController.text + viewModel.passwordController.text + rememberMe.toString()}');
                    }
                  },
                  child: Text('Signin'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
