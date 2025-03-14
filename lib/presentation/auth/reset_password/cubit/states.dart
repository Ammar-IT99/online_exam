// 📂 reset_password_states.dart

import '../../../../domain/entity/reset_password_entity.dart';

abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final ResetPasswordEntity resetPasswordEntity;

  ResetPasswordSuccess(this.resetPasswordEntity);
}

class ResetPasswordError extends ResetPasswordState {
  final String message;
  ResetPasswordError(this.message);
}
