import 'package:online_exam/core/di.dart';

class ApiConstant{
  static const String baseUrl = "https://exam.elevateegy.com";
  static String token = ""; // Will be assigned at runtime

}
class ApiEndPoint{
  static const String registerApi = "/api/v1/auth/signup";
  static const String loginApi = "/api/v1/auth/signin";
  static const String forgotPasswordApi = "/api/v1/auth/forgotPassword";
  static const String getAllSubjectsApi = "/api/v1/subjects";
  static const String getIngleSubjectsApi = "/api/v1/subjects/6715db9addfd54f0a196ab6c";
}