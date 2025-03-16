class Subject {
  String? id;
  String? name;
  String? icon;
  DateTime? createdAt;

  Subject({this.id, this.name, this.icon, this.createdAt});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    icon = json["icon"];
    createdAt = json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "icon": icon,
      "createdAt": createdAt?.toIso8601String(),
    };
  }
}