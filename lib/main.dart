import 'package:fieldresearch/controller/data_controller.dart';
import 'package:fieldresearch/provider/adm_provider.dart';
import 'package:fieldresearch/repositories/account_repository.dart';
import 'package:fieldresearch/utils/utils.dart';
import 'package:fieldresearch/views/adm_views/home_adm_view/home_adm_view.dart';
import 'package:fieldresearch/views/adm_views/users_adm_view/users_adm_view.dart';
import 'package:fieldresearch/views/login_view/signup_view.dart';
import 'package:fieldresearch/views/researcher_views/reseacher_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  AccountRepository.inicializeSupabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AdmProvider(),
        ),
        Provider(
          create: (context) => DataController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        routes: {
          '/': (context) => SignupView(),
          '/adm': (context) => const HomeAdmView(),
          '/admUsers': (context) => const AdmUsers(),
          '/researcher': (context) => const HomeResearcherView(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Poppins', scaffoldBackgroundColor: backGroundColor),
        initialRoute: '/',
      ),
    );
  }
}
