import 'package:online_exam/core/di.dart';

class ApiConstant{
  static const String baseUrl = "https://exam.elevateegy.com";
  static String? token;

}
class ApiEndPoint{
  static const String registerApi = "/api/v1/auth/signup";
  static const String loginApi = "/api/v1/auth/signin";
  static const String forgotPasswordApi = "/api/v1/auth/forgotPassword";

}