class Answers {
  Answers({
      this.answer, 
      this.key,});

  Answers.fromJson(dynamic json) {
    answer = json['answer'];
    key = json['key'];
  }
  String? answer;
  String? key;
Answers copyWith({  String? answer,
  String? key,
}) => Answers(  answer: answer ?? this.answer,
  key: key ?? this.key,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['answer'] = answer;
    map['key'] = key;
    return map;
  }

}