import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/cache_network.dart';
import 'package:online_exam/data/models/request/signin_request.dart';
import 'package:online_exam/data/models/response/Register_response_data_model.dart';
import 'package:online_exam/data/models/response/signin_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entity/failures.dart';
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
  Future<Either<Failures, RegisterResponseDataModel>> register(
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
        return Left(NetworkError(errorMessage: 'No Internet Connection'));
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
          return Right(registerResponse);
        } else {
          return Left(ServerError(
              errorMessage: responseData['message'] ?? 'Server Error: ${response.statusCode}'));
        }
      } catch (e) {
        return Left(ServerError(errorMessage: 'Invalid JSON response: $e'));
      }
    } on SocketException {
      return Left(NetworkError(errorMessage: 'No Internet Connection'));
    } on TimeoutException {
      return Left(ServerError(errorMessage: 'Request timed out'));

    } catch (e) {
      print('Unexpected Error: $e');
      return Left(ServerError(errorMessage: 'Unexpected Error: $e'));
    }
  }

  //signin
  Future<Either<Failures, SignInResponseDataModel>> signIn(
    String email,
    String password,
  ) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return Left(NetworkError(errorMessage: 'No Internet Connection'));
      }
      Uri url = Uri.parse(ApiConstant.baseUrl + ApiEndPoint.loginApi);
      var signIn = SignInRequest(
        email: email,
        password: password,
      );

      var requestBody = jsonEncode(signIn.toJson());
      print('Request body: $requestBody');
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
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('user token: ${ApiConstant.token}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var loginResponse = SignInResponseDataModel.fromJson(responseData);
        return Right(loginResponse);
      } else {
        return Left(
            ServerError(errorMessage: 'Server Error: ${responseData['message']}'));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: 'Unexpected Error: $e'));
    }
  }
}
