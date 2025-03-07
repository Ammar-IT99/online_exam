import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/domain/use_case/signin_use_case.dart';
import 'package:online_exam/presentation/auth/login/cubit/states.dart';

import '../../../../data/api/api_result.dart';
@injectable
class LoginScreenViewModel extends Cubit<LoginState> {
  LoginScreenViewModel({required this.signInUseCase}) : super(SignInInitialState());

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool obscurePassword = true;

  final SignInUseCase signInUseCase;

  void signIn() async {
    if (formKey.currentState?.validate() != true) {
      return;
    }

    emit(SignInLoadingState());
    var result = await signInUseCase.invoke(
        emailController.text,
        passwordController.text,
        );
    switch (result) {
      case Success(data: final authEntity):
        emit(SignInSuccessState(authResultEntity: authEntity));
      case Failure(message: final error):
        emit(SignInErrorState(error));
    }
  }
}
