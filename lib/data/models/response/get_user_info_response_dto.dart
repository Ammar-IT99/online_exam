
import '../../../domain/entity/get_user_info_entity.dart';

class UserInfoDTO {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime passwordChangedAt;

  const UserInfoDTO({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.isVerified,
    required this.createdAt,
    required this.passwordChangedAt,
  });


  factory UserInfoDTO.fromJson(Map<String, dynamic> json) {
    return UserInfoDTO(

      id: json["user"]["_id"],
      username: json["user"]["username"],
      firstName: json["user"]["firstName"],
      lastName: json["user"]["lastName"],
      email: json["user"]["email"],
      phone: json["user"]["phone"],
      role: json["user"]["role"],
      isVerified: json["user"]["isVerified"],
      createdAt: DateTime.parse(json["user"]["createdAt"]),
      passwordChangedAt: DateTime.parse(json["user"]["passwordChangedAt"]),
    );
  }

  UserInfoEntity userInfoToEntity() {
    return UserInfoEntity(
      id: id,
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      role: role,
      isVerified: isVerified,
      createdAt: createdAt,
      passwordChangedAt: passwordChangedAt,
    );
  }

}
