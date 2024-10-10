import 'package:flutter/material.dart';
import 'package:frontend_alleck/view/screens/login.dart';
import 'package:frontend_alleck/view/screens/user_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/user': (context) => UserHome(),
      },
      title: 'SurveyDMAlleck',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 34, 148, 255)),
        useMaterial3: true,
      ),
    );
  }
}