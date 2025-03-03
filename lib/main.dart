import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:online_exam/data/api/api_constant.dart';
import 'package:online_exam/presentation/auth/login/login_screen.dart';
import 'package:online_exam/presentation/auth/register/register_screen.dart';


import 'core/constants/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();


  ApiConstant.token = await secureStorage.read(key: 'token');

  runApp(const MyApp());
=======


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: AppStrings.appName,
      theme: ThemeData(useMaterial3: false),
      home: ApiConstant.token != null ? const LoginScreen() : const RegisterScreen(),
=======
 
      // Define the routes

    );
  }
}
