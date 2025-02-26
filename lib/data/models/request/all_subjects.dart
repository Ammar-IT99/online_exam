class AllSubjects {
  final String id;
  final String name;
  final String icon;
  final String createdAt;

  AllSubjects({
    required this.id,
    required this.name,
    required this.icon,
    required this.createdAt,
  });

  factory AllSubjects.fromJson(Map<String, dynamic> json) {
    return AllSubjects(
      id: json['_id'],
      name: json['name'],
      icon: json['icon'],
      createdAt: json['createdAt'],
    );
  }
}
