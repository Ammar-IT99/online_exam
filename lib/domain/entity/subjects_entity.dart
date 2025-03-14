class SubjectsEntity{
  String? id;
  String? name;
  String? icon;
  DateTime? createdAt;
  SubjectsEntity({this.id,this.name,this.icon,this.createdAt,});
  factory SubjectsEntity.fromJson(Map<String,dynamic> json){
    return SubjectsEntity(
      id: json['_id'],
      name: json['name'],
      icon: json['icon'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
    );
  }
  Map<String,dynamic> toJson(){
    return{
      '_id':id,
      'name':name,
      'icon':icon,
      'createdAt':createdAt?.toIso8601String()
    };
  }
}