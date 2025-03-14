import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/cache_network.dart';
import 'package:online_exam/data/api/api_result.dart';
import 'package:online_exam/data/models/request/get_all_subjects_request.dart';
import 'package:online_exam/data/models/request/signin_request.dart';
import 'package:online_exam/data/models/response/Register_response_data_model.dart';
import 'package:online_exam/data/models/response/get_all_subjects_dto.dart';
import 'package:online_exam/data/models/response/get_single_subject_dto.dart';
import 'package:online_exam/data/models/response/signin_response.dart';
import 'package:online_exam/domain/entity/get_all_subjects_entity.dart';
import '../models/request/Register_request.dart';
import '../models/request/forgot_password_request.dart';
import '../models/response/forgot_password_response_dto.dart';
import 'api_constant.dart';
import 'package:http/http.dart' as http;

@lazySingleton
class ApiService {
  bool isTokenExpired(String token) {
    try {
      List<String> parts = token.split('.');
      if (parts.length != 3) return true;

      String payload =
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      Map<String, dynamic> payloadMap = jsonDecode(payload);

      int exp = payloadMap["exp"] ?? 0; // Expiration time
      int now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      return now >= exp; // Check if expired
    } catch (e) {
      return true; // If there's an error, assume token is expired
    }
  }

  //register
  Future<RegisterResult> register(
      String email,
      String password,
      String userName,
      String firstName,
      String lastName,
      String phoneNumber,
      String rePassword) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return Failure('No Internet Connection');
      }

      Uri url = Uri.parse(ApiConstant.baseUrl + ApiEndPoint.registerApi);
      var registerRequest = RegisterRequest(
          username: userName,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          rePassword: rePassword,
          phone: phoneNumber);
      var requestBody = jsonEncode(registerRequest.toJson());

      var response = await http.post(
        url,
        body: requestBody,
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      try {
        var responseData = jsonDecode(response.body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          var registerResponse =
              RegisterResponseDataModel.fromJson(responseData);
          return Success(registerResponse);
        } else {
          return Failure(responseData['message'] ??
              'Server Error: ${response.statusCode}');
        }
      } catch (e) {
        return Failure('Invalid JSON response: $e');
      }
    } on SocketException {
      return Failure('No Internet Connection');
    } on TimeoutException {
      return Failure('Request timed out');
    } catch (e) {
      return Failure('Unexpected Error: $e');
    }
  }

  //signin
  Future<SignInResult> signIn(
    String email,
    String password,
  ) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return Failure('No Internet Connection');
      }
      Uri url = Uri.parse(ApiConstant.baseUrl + ApiEndPoint.loginApi);
      var signIn = SignInRequest(
        email: email,
        password: password,
      );

      var requestBody = jsonEncode(signIn.toJson());

      var response = await http.post(
        url,
        body: requestBody,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var loginResponse = SignInResponseDataModel.fromJson(responseData);
        // ✅ Store token after login
        String token = responseData['token'] ?? '';
        if (token.isNotEmpty) {
          await CacheNetwork.insertToCache(key: "token", value: token);
          ApiConstant.token = token; // ✅ Update token globally
          print("✅ Token Stored: $token");
        } else {
          print("⚠️ Token is empty");
        }
        return Success(loginResponse);
      } else {
        return Failure((' ${responseData['message']}'));
      }
    } catch (e) {
      return Failure('Unexpected Error: $e');
    }
  }

  // 📩 Forgot Password
  // 📩 Forgot Password
  Future<ForgotPasswordResult> forgotPassword(String email) async {
    try {
      await CacheNetwork.getCacheData(key: "token");
      print("Using Token for API Call: ${ApiConstant.token}");
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return Failure('No Internet Connection');
      }

      Uri url = Uri.parse(ApiConstant.baseUrl + ApiEndPoint.forgotPasswordApi);
      var forgotPasswordRequest = ForgotPasswordRequest(
        email: email,
      );
      var requestBody = jsonEncode(forgotPasswordRequest.toJson());

      var response = await http.post(
        url,
        body: requestBody,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ApiConstant.token}'
        },
      ).timeout(const Duration(seconds: 10));
      print("API Response Code: ${response.statusCode}");
      var responseData = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var forgotPasswordResponse = ForGotPasswordDto.fromJson(responseData);
        return Success(forgotPasswordResponse);
      } else {
        return Failure(
            responseData['message'] ?? 'Server Error: ${response.body}');
      }
    } on SocketException {
      return Failure('No Internet Connection');
    } on TimeoutException {
      return Failure('Request timed out');
    } catch (e) {
      return Failure('Unexpected Error: $e');
    }
  }

  //Get All Subjects
  //Future<GetAllSubjectsResult> getAllSubjects(String name,String icon) async {
  // Future<GetAllSubjectsResult> getAllSubjects(String name, String icon) async {
  //   try {
  //     print(
  //         "Using Token for API Call: ${ApiConstant.token}"); // ✅ Debugging before request
  //     var connectivityResult = await Connectivity().checkConnectivity();
  //     if (connectivityResult == ConnectivityResult.none) {
  //       return Failure('No Internet Connection');
  //     }
  //     ApiConstant.token = await CacheNetwork.getCacheData(key: "token");
  //     Uri url = Uri.parse(ApiConstant.baseUrl + ApiEndPoint.getAllSubjectsApi,);
  //     var response = await http.get(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer ${ApiConstant.token}',
  //       },
  //     ).timeout(const Duration(seconds: 10));
  //     var responseData = jsonDecode(response.body);
  //     print(
  //         "API Response Code: ${response.statusCode}"); // ✅ Debugging response status
  //     if (response.statusCode >= 200 && response.statusCode < 300) {
  //       // List<GetAllSubjectsRequest> list = [];
  //       // List<dynamic> data = responseData['subjects'];
  //       // for (var element in data) {
  //       //   GetAllSubjectsRequest getAllSubjectsResult =
  //       //       GetAllSubjectsRequest(icon: element['icon'],name: element['name']);
  //       //   list.add(getAllSubjectsResult);
  //       //   print(List);
  //       // }
  //       // print(List);
  //       // return Success(responseData['subjects'] ?? 'Success: ${response.body}');
  //       List<GetAllSubjectsRequest> list =
  //           responseData['subjects']
  //               .map((element) => GetAllSubjectsRequest.fromJson(
  //                     element,
  //                   ),)
  //               .toList();
  //       print('list = $list');
  //       return Success(responseData['subjects'] ?? 'Success: ${response.body}');
  //     } else {
  //       return Failure(
  //           responseData['message'] ?? 'Server Error: ${response.body}');
  //     }
  //   } on SocketException {
  //     return Failure('No Internet Connection');
  //   } on TimeoutException {
  //     return Failure('Request timed out');
  //   } catch (e) {
  //     return Failure('Unexpected Error: $e');
  //   }
  // }
  Future<GetAllSubjectsResult> getAllSubjects(String name, String icon) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return Failure('No Internet Connection');
      }

      final token =
          await CacheNetwork.getCacheData(key: "token") ?? ''; // Prevent null
      print('tokeeeeen is $token');

      // 🔍 Check if token is expired

      Uri url = Uri.parse(ApiConstant.baseUrl + ApiEndPoint.getAllSubjectsApi);

      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'token': '$token',
        },
      ).timeout(const Duration(seconds: 10));

      print("📌 API Response Code: ${response.statusCode}");
      print("📌 API Response Body: ${response.body}");

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<GetAllSubjectsRequest> subjectsList =
            (responseData['subjects'] as List)
                .map((element) => GetAllSubjectsRequest.fromJson(element))
                .toList();
        print('sssssssss$subjectsList');
        return Success(subjectsList);
      } else {
        return Failure(responseData['message'] ?? 'Server Error');
      }
    } on SocketException {
      return Failure('No Internet Connection');
    } on TimeoutException {
      return Failure('Request timed out');
    } catch (e) {
      return Failure('Unexpected Error: $e');
    }
  }

//get single subject
  Future<GetSingleSubjectsResult> getSingleSubject(String message) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return Failure('No Internet Connection');
      }

      final token =
          await CacheNetwork.getCacheData(key: "token") ?? ''; // Prevent null
      print('tokeeeeen is $token');

      // 🔍 Check if token is expired

      Uri url =
          Uri.parse(ApiConstant.baseUrl + ApiEndPoint.getIngleSubjectsApi);

      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'token': '$token',
        },
      ).timeout(const Duration(seconds: 10));

      print("📌 API Response Code: ${response.statusCode}");
      print("📌 API Response Body: ${response.body}");

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var getSingleSubject = GetSingleSubjectDto.fromJson(responseData);
        return Success(getSingleSubject);
      } else {
        return Failure(
            responseData['message'] ?? 'Server Error: ${response.body}');
      }
    } on SocketException {
      return Failure('No Internet Connection');
    } on TimeoutException {
      return Failure('Request timed out');
    } catch (e) {
      return Failure('Unexpected Error: $e');
    }
  }
}
