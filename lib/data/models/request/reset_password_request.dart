class ResetPasswordRequestModel {
  final String email;
  final String newPassword;

  ResetPasswordRequestModel({
    required this.email,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'newPassword': newPassword,
    };
  }
}
