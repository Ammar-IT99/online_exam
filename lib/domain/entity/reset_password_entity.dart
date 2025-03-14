class ResetPasswordEntity {
  final String message;
  final String? token;

  ResetPasswordEntity({
    required this.message,
    this.token,
  });
}