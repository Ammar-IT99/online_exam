import 'package:online_exam/domain/entity/auth_result_entity.dart';

class LoginState{}
//signin
class SignInInitialState extends LoginState{}
class SignInErrorState extends LoginState{
  final String errorMessage;
  SignInErrorState(this.errorMessage);
}
class SignInLoadingState extends LoginState{}
class SignInSuccessState extends LoginState{
  AuthResultEntity authResultEntity;
  SignInSuccessState({required this.authResultEntity,});
}