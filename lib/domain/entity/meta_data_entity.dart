class MetaDataEntity{
  int? currentPage;
  int? numberOfPage;
  int? limit;
  MetaDataEntity({this.currentPage,this.numberOfPage,this.limit});
  factory MetaDataEntity.fromJson(Map<String,dynamic> json){
    return MetaDataEntity(
      currentPage: json['currentPage'] as int?,
      numberOfPage: json['numberOfPages'] as int?,
      limit: json['limit'] as int?,
    );
  }
  Map<String,dynamic> toJson(){
    return{
      'currentPage':currentPage,
      'numberOfPages':numberOfPage,
      'limit':limit,
    };
  }
}