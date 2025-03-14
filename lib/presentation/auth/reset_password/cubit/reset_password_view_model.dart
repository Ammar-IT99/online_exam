import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/presentation/auth/reset_password/cubit/states.dart';
import '../../../../domain/use_case/reset_password_use_case.dart';
import '../../../../data/api/api_result.dart';
import '../../../../domain/entity/reset_password_entity.dart';

@injectable
class ResetPasswordViewModel extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordViewModel(this.resetPasswordUseCase)
      : super(ResetPasswordInitial());

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;

  void setEmail(String email) {
    this.email = email;
  }


  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    if (email == null || email!.isEmpty) {
      emit(ResetPasswordError('Email is required!'));

      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      emit(ResetPasswordError('Passwords do not match!'));

      return;
    }

    emit(ResetPasswordLoading());

    try {
      final result = await resetPasswordUseCase.invoke(
        email!,
        newPasswordController.text,
      );

      switch (result) {
        case Success(data: final ResetPasswordEntity entity):
          if (entity.message.toLowerCase() == "success") {
            emit(ResetPasswordSuccess(entity));
            print('Success State Emitted!');
          } else {
            emit(ResetPasswordError(entity.message));
            print('Error State Emitted: ${entity.message}');
          }
          break;

        case Failure(message: final error):
          emit(ResetPasswordError(error));
          print('Failure State Emitted: $error');
          break;
      }
    } catch (e) {
      emit(ResetPasswordError('Unexpected Error: $e'));
      print('Unexpected Error: $e');
    }
  }


  @override
  Future<void> close() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
