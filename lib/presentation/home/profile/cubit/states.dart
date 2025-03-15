
import '../../../../domain/entity/get_user_info_entity.dart';


abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserInfoEntity userInfo;
  ProfileLoaded(this.userInfo);
}

class ProfileError extends ProfileState {
  final String error;
  ProfileError(this.error);
}
