import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:online_exam/presentation/auth/log_out_cubit/states.dart';

import '../../../core/cache_network.dart';
import '../../../data/api/api_constant.dart';
import '../../../data/api/api_result.dart';
import '../../../data/models/response/get_log_out_response.dart';
import '../../../domain/use_case/logout_use_case.dart';
@injectable
class LogOutCubit extends Cubit<LogOutState> {
  final LogOutUseCase logOutUseCase;

  LogOutCubit({required this.logOutUseCase}) : super(LogOutInitial());

  Future<void> logOut() async {
    emit(LogOutLoading());

    final result = await logOutUseCase.invoke();

    if (result is Success<LogoutResponse>) {
      print("Logout Success: ${result.data.message}");
      await CacheNetwork.deleteCacheItem(key: "token");
      ApiConstant.token = '';
      emit(LogOutLoggedOut(result.data.message));
    } else if (result is Failure) {
      emit(LogOutError(result.message));
      print("Logout Error: ${result.message}");
    }
  }
}
