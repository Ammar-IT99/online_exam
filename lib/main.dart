import 'package:flutter/material.dart';
import 'package:online_exam/core/cache_network.dart';
import 'package:online_exam/data/api/api_constant.dart';
import 'package:online_exam/presentation/auth/login/login_screen.dart';
import 'package:online_exam/presentation/auth/register/register_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cacheInitialization();
  ApiConstant.token = await CacheNetwork.getCacheData(key: 'token');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Exam App',
      theme: ThemeData(
        useMaterial3: false
      ),
      home: RegisterScreen(),
      // Define the routes
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        // Add other routes here if you have more screens
      },
    );
  }
}
