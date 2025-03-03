import 'package:online_exam/data/models/response/User_data_model.dart';
import 'package:online_exam/domain/entity/auth_result_entity.dart';

class SignInResponseDataModel {
  SignInResponseDataModel({
      this.message, 
      this.token, 
      this.user,});

  SignInResponseDataModel.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? UserDataModel.fromJson(json['user']) : null;
    code = json['code'];
  }
  String? message;
  String? token;
  UserDataModel? user;
  int? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    map['code'] = code;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
  AuthResultEntity toAuthResultEntity(){
    return AuthResultEntity(
    token:token,
    userEntity:user?.toUserEntity()
    );
  }

}