import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/domain/use_case/register_use_case.dart';
import 'package:online_exam/presentation/auth/register/cubit/states.dart';

import '../../../../data/api/api_result.dart';
import '../../login/login_screen.dart';
@injectable
class RegisterScreenViewModel extends Cubit<RegisterState> {
  RegisterScreenViewModel({required this.registerUseCase}) : super(RegisterInitialState());

  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  bool obscurePassword = true;

  final RegisterUseCase registerUseCase;

  void register() async {
    if (formKey.currentState?.validate() != true) {
      return;
    }

    emit(RegisterLoadingState());
    var result = await registerUseCase.invoke(
        userNameController.text,
        firstNameController.text,
        lastNameController.text,
        emailController.text,
        passwordController.text,
      confirmPasswordController.text,
        phoneNumberController.text,
        );
  switch (result) {
    case Success(data: final authEntity):
      emit(RegisterSuccessState(authResultEntity: authEntity));
    case Failure(message: final error):
      emit(RegisterErrorState(error));

  }
}
  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }
}
