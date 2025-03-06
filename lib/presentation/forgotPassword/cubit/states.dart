import '../../../domain/entity/forgot_password_entity.dart';

sealed class ForgotState {}

class ForgotInitialState extends ForgotState {}

class ForgotLoadingState extends ForgotState {}

class ForgotSuccessState extends ForgotState {
  final ForgotPasswordEntity forgotPasswordEntity;
  ForgotSuccessState({required this.forgotPasswordEntity});
}

class ForgotErrorState extends ForgotState {
  final String errorMessage;
  ForgotErrorState(this.errorMessage);
}