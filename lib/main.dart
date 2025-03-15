import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/cache_network.dart';
import 'package:online_exam/core/constants/app_strings.dart';
import 'package:online_exam/data/api/api_constant.dart';
import 'package:online_exam/presentation/auth/forgot_password/forgot_password_screen.dart';
import 'package:online_exam/presentation/auth/login/login_screen.dart';
import 'package:online_exam/presentation/auth/register/register_screen.dart';
import 'package:online_exam/presentation/auth/reset_password/reset_password_screen.dart';
import 'package:online_exam/presentation/auth/verify_reset_code/verify_reset_code_screen.dart';
import 'package:online_exam/presentation/home/explore/exam_screen.dart';
import 'package:online_exam/presentation/home/explore/start_exam_screen.dart';
import 'core/di.dart';
import 'package:online_exam/presentation/home/home_screen.dart';
import 'package:online_exam/presentation/home/profile/profile_screen.dart';
import 'package:online_exam/presentation/home/profile/update_password.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  String? token = await CacheNetwork.getCacheData(key: "token");
  ApiConstant.token = token ?? '';

  runApp(MyApp(isLoggedIn: ApiConstant.token.isNotEmpty));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: ThemeData(useMaterial3: false),
          home: isLoggedIn ? HomeScreen() : const LoginScreen(),
          routes: {
            RegisterScreen.routeName: (context) => RegisterScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
            VerifyResetCodeScreen.routeName: (context) =>
                VerifyResetCodeScreen(),
            ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
            UpdatePassword.routeName: (context) => UpdatePassword(),
            ProfileScreen.routeName: (context) => ProfileScreen(),
            ExamScreen.routeName: (context) => ExamScreen(),
            StartExamScreen.routeName: (context) => StartExamScreen(),
          },
        );
      },


      // Define the routes

    );
  }
}
