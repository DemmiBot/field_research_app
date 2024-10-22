import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_alleck/view/screens/login.dart';
import 'package:frontend_alleck/view/screens/register.dart';
import 'package:frontend_alleck/view/screens/home.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/home': (context) => Home(),
        '/register': (context) => RegisterScreen(),
      },
      title: 'SurveyDMAlleck',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 34, 148, 255)),
        useMaterial3: true,
      ),
    );
  }
}