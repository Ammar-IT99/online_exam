import '../../../domain/entity/forgot_password_entity.dart';

class ForGotPasswordDto {
  final String message;
  final String info;

  ForGotPasswordDto({required this.message, required this.info});

  factory ForGotPasswordDto.fromJson(Map<String, dynamic> json) {
    return ForGotPasswordDto(
      message: json['message'],
      info: json['info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'info': info,
    };
  }
  ForgotPasswordEntity toForgotPasswordEntity(){
    return ForgotPasswordEntity(
      message: message,
      info: info,
    );
}
}
