class VerifyResetCodeRequestModel {
  final String resetCode;

  VerifyResetCodeRequestModel({required this.resetCode});

  // تحويل من JSON إلى Model
  factory VerifyResetCodeRequestModel.fromJson(Map<String, dynamic> json) {
    return VerifyResetCodeRequestModel(
      resetCode: json['resetCode'],
    );
  }

  // تحويل من Model إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'resetCode': resetCode,
    };
  }
}
