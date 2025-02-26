import 'package:flutter/material.dart';
import 'package:online_exam/presentation/auth/register/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Exam App',
      theme: ThemeData(useMaterial3: false),
      home: RegisterScreen(),
      // Define the routes
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        // Add other routes here if you have more screens
      },
    );
  }
}
