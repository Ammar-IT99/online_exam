// core/network/api_result.dart
import 'package:online_exam/data/models/request/get_all_exams_request.dart';
import 'package:online_exam/data/models/request/get_all_subjects_request.dart';
import 'package:online_exam/data/models/response/get_all_subjects_dto.dart';
import 'package:online_exam/data/models/response/get_single_subject_dto.dart';
import 'package:online_exam/domain/entity/subjects_entity.dart';

import '../models/response/Register_response_data_model.dart';
import '../models/response/forgot_password_response_dto.dart';
import '../models/response/reset_password_response_dto.dart';
import '../models/response/signin_response.dart';
import '../models/response/verify_reset_code_dto.dart';

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
typedef VerifyResetCodeResult = ApiResult<VerifyResetCodeDto>;
typedef ResetPasswordResult = ApiResult<ResetPasswordResponseDto>;
typedef GetAllSubjectsResult = ApiResult<List<GetAllSubjectsRequest>>;
typedef GetSingleSubjectsResult = ApiResult<GetSingleSubjectDto>;
typedef GetAllExamsResult = ApiResult<List<GetAllExamsRequest>>;