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
import 'api_constant.dart';
import 'package:http/http.dart' as http;

@singleton
class ApiService {
  static ApiService? _instance;

  static ApiService getInstance() {
    _instance ??= ApiService();
    return _instance!;
  }

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
}
