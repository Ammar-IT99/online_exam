import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/domain/use_case/signin_use_case.dart';
import 'package:online_exam/presentation/auth/login/cubit/states.dart';

class LoginScreenViewModel extends Cubit<LoginState> {
  LoginScreenViewModel({required this.signInUseCase}) : super(SignInInitialState());

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController(text: 'ampar133@1elevate.com');
  var passwordController = TextEditingController(text: 'Elevate@123');
  bool obscurePassword = true;

  final SignInUseCase signInUseCase;

  void signIn() async {
    if (formKey.currentState?.validate() != true) {
      return;
    }

    emit(SignInLoadingState());
    var either = await signInUseCase.invoke(
        emailController.text,
        passwordController.text,
        );

    either.fold(
      (l) {
        emit(SignInErrorState(l.errorMessage!));
      },
      (r) {
        emit(SignInSuccessState(authResultEntity: r));
      },
    );
  }
}
