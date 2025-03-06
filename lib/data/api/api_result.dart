// core/network/api_result.dart

import '../models/response/Register_response_data_model.dart';
import '../models/response/forgot_password_response_dto.dart';
import '../models/response/signin_response.dart';

sealed class ApiResult<T> {
  const ApiResult();
}

// ✅ Success Case
class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

// ❌ Failure Case
class Failure extends ApiResult<Never> {
  final String message;
  const Failure(this.message);
}

typedef RegisterResult = ApiResult<RegisterResponseDataModel>;
typedef SignInResult = ApiResult<SignInResponseDataModel>;
typedef ForgotPasswordResult = ApiResult<ForGotPasswordDto>;
