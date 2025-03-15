import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/data/api/api_result.dart';
import 'package:online_exam/domain/entity/get_user_info_entity.dart';
import 'package:online_exam/domain/use_case/get_user_info_use_case.dart';
import 'states.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  final GetUserInfoUseCase getUserInfoUseCase;

  ProfileViewModel({required this.getUserInfoUseCase}) : super(ProfileInitial());

  Future<void> fetchUserInfo() async {
    emit(ProfileLoading());


    final result = await getUserInfoUseCase.invoke();

    if (result is Success<UserInfoEntity>) {
      emit(ProfileLoaded(result.data));
    } else if (result is Failure) {
      emit(ProfileError(result.message));
    }
  }
}
