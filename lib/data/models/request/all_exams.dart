class AllExams {
  final String id;
  final String title;
  final int duration;
  final String subject;
  final int numberOfQuestions;
  final bool active;
  final String createdAt;

  AllExams({
    required this.id,
    required this.title,
    required this.duration,
    required this.subject,
    required this.numberOfQuestions,
    required this.active,
    required this.createdAt,
  });

  factory AllExams.fromJson(Map<String, dynamic> json) {
    return AllExams(
      id: json['_id'],
      title: json['title'],
      duration: json['duration'],
      subject: json['subject'],
      numberOfQuestions: json['numberOfQuestions'],
      active: json['active'],
      createdAt: json['createdAt'],
    );
  }
}
