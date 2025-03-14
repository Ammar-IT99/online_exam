class GetSingleSubjectRequest {
  String? message;
  String? category;
  GetSingleSubjectRequest({this.message,this.category});
  factory GetSingleSubjectRequest.fromJson(Map<String, dynamic> json) {
    return GetSingleSubjectRequest(message: json['message'], category: json['category']);
  }
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'category': category,
    };
  }

  GetSingleSubjectRequest toGetSingleSubjectRequest() {
    return GetSingleSubjectRequest(
      message: message,
      category: category,
    );
  }
}
