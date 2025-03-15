class LogoutResponse {
  final String message;

  LogoutResponse({required this.message});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      message: json['message'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
  LogoutResponse toLogoutResponse() {
    return LogoutResponse(
      message: message,
    );
  }
}