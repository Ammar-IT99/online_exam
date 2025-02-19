
import 'User_entity.dart';

class RegisterResponseEntity {
  RegisterResponseEntity({
      this.message, 
      this.token, 
      this.user,});


  String? message;
  String? token;
  UserEntity? user;

}