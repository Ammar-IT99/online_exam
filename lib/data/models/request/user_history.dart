
class UserHistory {
  final String message;
  final dynamic history;

  UserHistory({required this.message, this.history});

  factory UserHistory.fromJson(Map<String, dynamic> json) {
    return UserHistory(
      message: json['message'],
      history: json['history'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'history': history,
    };
  }
}