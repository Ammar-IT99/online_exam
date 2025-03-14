class GetAllSubjectsRequest {
  String? name;
  String? icon;
  GetAllSubjectsRequest({this.name, this.icon});
  factory GetAllSubjectsRequest.fromJson(Map<String, dynamic> json) {
    return GetAllSubjectsRequest(name: json['name'], icon: json['icon']);
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
    };
  }

  GetAllSubjectsRequest toGetAllSubjectsRequest() {
    return GetAllSubjectsRequest(
      name: name,
      icon: icon,
    );
  }
}
