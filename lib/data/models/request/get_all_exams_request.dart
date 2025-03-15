class GetAllExamsRequest {
  String? id;
  String? title;
  int? numberOfQuestions;
  int? duration;
  GetAllExamsRequest({this.title, this.duration,this.numberOfQuestions,this.id});
  factory GetAllExamsRequest.fromJson(Map<String, dynamic> json) {
    return GetAllExamsRequest(id: json['_id'],title: json['title'], duration: json['duration'], numberOfQuestions: json['numberOfQuestions']);
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'duration': duration,
      'numberOfQuestions': numberOfQuestions,
      '_id':id
    };
  }

  GetAllExamsRequest toGetAllExamsRequest() {
    return GetAllExamsRequest(
      id: id,
      title: title,
      duration: duration,
      numberOfQuestions: numberOfQuestions
    );
  }
}