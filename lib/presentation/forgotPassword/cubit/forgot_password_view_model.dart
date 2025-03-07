import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/presentation/forgotPassword/cubit/states.dart';

import '../../../data/api/api_result.dart';
import '../../../domain/use_case/forgot_password_use_case.dart';
@injectable
class ForgotPasswordViewModel extends Cubit<ForgotState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordViewModel({required this.forgotPasswordUseCase})
      : super(ForgotInitialState());

  // Form Key & Controller
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  // Forgot Password Function
  void forgotPassword() async {
    if (formKey.currentState?.validate() != true) {
      return;
    }

    emit(ForgotLoadingState());

    final result = await forgotPasswordUseCase.call(emailController.text);

    switch (result) {
      case Success(data: final data):
        emit(ForgotSuccessState(forgotPasswordEntity: data));
        break;

      case Failure(message: final error):
        emit(ForgotErrorState(error));
        break;
    }
  }
}
