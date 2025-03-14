

import '../../../domain/entity/reset_password_entity.dart';

class ResetPasswordResponseDto {
  final String message;
  final String? token;

  ResetPasswordResponseDto({
    required this.message,
    this.token,
  });

  factory ResetPasswordResponseDto.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseDto(
      message: json['message'] ?? '',
      token: json['token'],
    );
  }

  ResetPasswordEntity toResetPasswordEntity() {
    return ResetPasswordEntity(
      message: message,
      token: token,
    );
  }
}