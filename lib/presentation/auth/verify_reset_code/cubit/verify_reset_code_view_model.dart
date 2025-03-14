import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/presentation/auth/verify_reset_code/cubit/states.dart';
import 'package:online_exam/data/api/api_result.dart';
import 'package:online_exam/domain/entity/verify_reset_code_entity.dart';

import '../../../../domain/use_case/verify_reset_code_use_case.dart';

@injectable
class VerifyResetCodeViewModel extends Cubit<VerifyResetCodeState> {
  final VerifyResetCodeUseCase verifyResetCodeUseCase;

  VerifyResetCodeViewModel(this.verifyResetCodeUseCase)
      : super(VerifyResetCodeInitial());

  String code = '';
  String? email;

  void setEmail(String email) {
    this.email = email;
  }


  Future<void> verifyCode(String resetCode) async {
    if (email == null || email!.isEmpty) {
      emit(VerifyResetCodeError('Email is required before verifying the code.'));

      return;
    }

    emit(VerifyResetCodeLoading());

    final result = await verifyResetCodeUseCase.invoke(resetCode);

    switch (result) {
      case Success(data: final VerifyResetCodeEntity entity):
        if (entity.status == "Success") {
          emit(VerifyResetCodeSuccess(verifyResetCodeEntity: entity));
        } else {

          emit(VerifyResetCodeError(entity.message ?? "Invalid code. Please try again."));
        }
        break;

      case Failure(message: final error):
        emit(VerifyResetCodeError(error));
        break;
    }
  }

}
