import 'package:fieldresearch/controller/form_controller.dart';
import 'package:fieldresearch/utils/utils.dart';
import 'package:fieldresearch/screens/create_form_view.dart';
import 'package:fieldresearch/screens/home_adm_view.dart';
import 'package:fieldresearch/screens/users_adm.dart';
import 'package:fieldresearch/screens/signup_view.dart';
import 'package:fieldresearch/screens/register_view.dart';
import 'package:fieldresearch/screens/reseacher_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
        create: (_) => FormController(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: false,
      child: MaterialApp(
        routes: {
          '/': (context) => const SignupView(),
          '/register': (context) => const RegisterView(),
          '/adm': (context) => const HomeAdmView(),
          '/admUsers': (context) => const AdmUsers(),
          '/admCreateForm': (context) => const CreateFormView(),
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
