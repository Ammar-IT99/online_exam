import 'package:injectable/injectable.dart';
import 'package:online_exam/domain/entity/auth_result_entity.dart';
import 'package:online_exam/domain/entity/forgot_password_entity.dart';
import '../../../domain/repository/data_source/auth_remote_data_source.dart';
import '../../api/api_result.dart';
import '../../api/api_service.dart';
@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  // 🔑 Register Method
  @override
  Future<ApiResult<AuthResultEntity>> register(
      String userName,
      String firstName,
      String lastName,
      String email,
      String password,
      String rePassword,
      String phoneNumber,
      ) async {
    final result = await apiService.register(
      userName,
      firstName,
      lastName,
      email,
      password,
      rePassword,
      phoneNumber,
    );

    switch (result) {
      case Success(data: final response):
        return Success(response.toAuthResultEntity());
      case Failure(message: final error):
        return Failure(error);
    }
  }

  // 🔑 SignIn Method
  @override
  Future<ApiResult<AuthResultEntity>> signIn(
      String email,
      String password,
      ) async {
    final result = await apiService.signIn(email, password);

    switch (result) {
      case Success(data: final response):
        return Success(response.toAuthResultEntity());
      case Failure(message: final error):
        return Failure(error);
    }
  }

  @override
  Future<ApiResult<ForgotPasswordEntity>> forgotPassword(String email) async {
    final result = await apiService.forgotPassword(email);

    switch (result) {
      case Success(data: final response):
        return Success(response.toForgotPasswordEntity());
      case Failure(message: final error):
        return Failure(error);
    }
  }
}
