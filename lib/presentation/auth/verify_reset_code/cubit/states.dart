import 'package:online_exam/domain/entity/verify_reset_code_entity.dart';

abstract class VerifyResetCodeState {}

class VerifyResetCodeInitial extends VerifyResetCodeState {}

class VerifyResetCodeLoading extends VerifyResetCodeState {}

class VerifyResetCodeSuccess extends VerifyResetCodeState {
 final  VerifyResetCodeEntity verifyResetCodeEntity;
   VerifyResetCodeSuccess({required this.verifyResetCodeEntity});
}

class VerifyResetCodeError extends VerifyResetCodeState {
  final String message;
  VerifyResetCodeError(this.message);
}

class VerifyResetCodeResent extends VerifyResetCodeState {

}
