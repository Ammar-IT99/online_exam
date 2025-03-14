import '../../../domain/entity/verify_reset_code_entity.dart';

class VerifyResetCodeDto {
  final String status;
  final String? message;
  final int? code;

  VerifyResetCodeDto({
    required this.status,
    this.message,
    this.code,
  });

  // تحويل من JSON إلى Model
  factory VerifyResetCodeDto.fromJson(Map<String, dynamic> json) {
    return VerifyResetCodeDto(
      status: json['status'] as String? ?? 'Error',
      message: json['message'] as String?,
      code: json['code'] as int?,
    );
  }

  // تحويل من Model إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'code': code,
    };
  }

  // تحويل من DTO إلى Entity
  VerifyResetCodeEntity toVerifyResetCodeEntity() {
    return VerifyResetCodeEntity(
      status: status,
      message: message ?? 'No message provided',
      code: code ?? 0,
    );
  }
}
