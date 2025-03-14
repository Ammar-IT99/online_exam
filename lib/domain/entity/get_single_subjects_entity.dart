class GetSingleSubjectsEntity {
  String? message;
  String? category;
  GetSingleSubjectsEntity({this.message,this.category,});
  factory GetSingleSubjectsEntity.fromJson(Map<String, dynamic> json) {
    return GetSingleSubjectsEntity(
      message: json['message'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'category': category,
    };
  }
}