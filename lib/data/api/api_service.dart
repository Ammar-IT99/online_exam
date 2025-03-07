import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/cache_network.dart';
import 'package:online_exam/data/api/api_result.dart';
import 'package:online_exam/data/models/request/signin_request.dart';
import 'package:online_exam/data/models/response/Register_response_data_model.dart';
import 'package:online_exam/data/models/response/signin_response.dart';
import '../models/request/Register_request.dart';
import '../models/request/forgot_password_request.dart';
import '../models/response/forgot_password_response_dto.dart';
import 'api_constant.dart';
import 'package:http/http.dart' as http;

@lazySingleton
class ApiService {

  //register
  Future< RegisterResult> register(
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
        return Failure( 'No Internet Connection');
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
          var registerResponse = RegisterResponseDataModel.fromJson(responseData);
          return Success( registerResponse);
        } else {
          return Failure(
              responseData['message'] ?? 'Server Error: ${response.statusCode}');
        }
      } catch (e) {
        return Failure('Invalid JSON response: $e');
      }
    } on SocketException {
      return Failure( 'No Internet Connection');
    } on TimeoutException {
      return Failure( 'Request timed out');

    } catch (e) {

      return Failure( 'Unexpected Error: $e');
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
          'Authorization': 'Bearer ${ApiConstant.token}'
        },
      );
      var responseData = jsonDecode(response.body);
      await CacheNetwork.insertToCache(key: "token", value: responseData['token']??'');
        ApiConstant.token = await CacheNetwork.getCacheData(key: "token");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var loginResponse = SignInResponseDataModel.fromJson(responseData);
        return Success(loginResponse);
      } else {
        return Failure(
            ( ' ${responseData['message']}'));
      }
    } catch (e) {
      return Failure('Unexpected Error: $e');
    }
  }
  // 📩 Forgot Password
  // 📩 Forgot Password
  Future<ForgotPasswordResult> forgotPassword(String email) async {
    try {
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
        },
      ).timeout(const Duration(seconds: 10));

      var responseData = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var forgotPasswordResponse = ForGotPasswordDto.fromJson(responseData);
        return Success(forgotPasswordResponse);
      } else {
        return Failure(responseData['message'] ?? 'Server Error: ${response.body}');
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
