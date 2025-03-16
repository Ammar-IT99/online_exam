import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/cache_network.dart';
import 'package:online_exam/core/constants/app_strings.dart';
import 'package:online_exam/data/api/api_constant.dart';
import 'package:online_exam/data/api/api_service.dart';
import 'package:online_exam/data/models/response/exam.dart';
import 'package:online_exam/data/repository/data_source_impl/auth_remote_data_source_impl.dart';
import 'package:online_exam/data/repository/repository_impl/auth_repository_impl.dart';
import 'package:online_exam/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:online_exam/domain/repository/repository_contract/auth_repository_contract.dart';
import 'package:online_exam/domain/use_case/question_on_exam_use_case.dart';
import 'package:online_exam/presentation/auth/forgotPassword/forgot_password_screen.dart';
import 'package:online_exam/presentation/auth/login/login_screen.dart';
import 'package:online_exam/presentation/auth/register/register_screen.dart';
import 'package:online_exam/presentation/auth/reset_password/reset_password_screen.dart';
import 'package:online_exam/presentation/auth/verify_reset_code/verify_reset_code_screen.dart';
import 'package:online_exam/presentation/home/explore/cubit/question_on_exam_view_model.dart';
import 'package:online_exam/presentation/home/explore/exam_screen.dart';
import 'package:online_exam/presentation/home/explore/quiz_screen.dart';
import 'package:online_exam/presentation/home/explore/start_exam_screen.dart';
import 'package:online_exam/presentation/home/result/result_screen.dart';
import 'core/di.dart';
import 'package:online_exam/presentation/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/presentation/home/profile/profile_screen.dart';
import 'package:online_exam/presentation/home/profile/reset_password.dart';


void main() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  // Retrieve token before starting the app
  String? token = await CacheNetwork.getCacheData(key: "token");
  ApiConstant.token = token ?? '';


  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<Question0nexamCubit>(
          create: (context) => Question0nexamCubit(QuestionOnexamUsecase(AuthRepositoryImpl(remoteDataSource: AuthRemoteDataSourceImpl(apiService: ApiService())))),
        ),
      ],
      child: MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        ScreenUtil.init(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: ThemeData(useMaterial3: false,),
          home: ApiConstant.token.isNotEmpty ? HomeScreen() : LoginScreen(),
          // Define the routes
          routes: {
            RegisterScreen.routeName: (context) => RegisterScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            ForgotPasswordScreen.routeName: (context) =>  ForgotPasswordScreen(),
            VerifyResetCodeScreen.routeName: (context) => VerifyResetCodeScreen(),
            ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
            ResetPassword.routeName: (context) => ResetPassword(),
            ProfileScreen.routeName: (context) => ProfileScreen(),
            ExamScreen.routeName: (context) => ExamScreen(),
            StartExamScreen.routeName: (context) => StartExamScreen(),
            ResultScreen.routeName: (context) => ResultScreen(),
            QuizScreen.routeName: (context) => QuizScreen(exam: Exam(),examID: Exam().id??'',)
          },
        );
      },


      // Define the routes

    );
  }
}
