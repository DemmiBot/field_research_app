import 'package:fieldresearch/screens/adm_page/create_form_view/create_form_view.dart';
import 'package:fieldresearch/screens/adm_page/home_adm_view/home_adm_view.dart';
import 'package:fieldresearch/screens/adm_page/users_adm_view/users_adm_view.dart';
import 'package:fieldresearch/screens/researcher_page/reseacher_home_view.dart';
import 'package:fieldresearch/screens/sign_in_page/bloc/sign_in_bloc.dart';
import 'package:fieldresearch/screens/sign_in_page/view/signIn_view.dart';
import 'package:fieldresearch/screens/sign_up_page/bloc/sign_up_bloc.dart';
import 'package:fieldresearch/screens/sign_up_page/view/sign_up_view.dart';
import 'package:fieldresearch/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_repository/user_repository.dart';

class MainApp extends StatelessWidget {
  final IUserRepository userRepository;
  const MainApp({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider(
          create: (_) => SignInBloc(userRepository: userRepository),
        ),
      ],
      child: MyAppView(userRepository: userRepository),
    );
  }
}

class MyAppView extends StatelessWidget {
  final IUserRepository userRepository;
  const MyAppView({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: false,
      child: MaterialApp(
        routes: {
          '/register': (context) => BlocProvider<SignUpBloc>(
                create: (_) => SignUpBloc(userRepository: userRepository),
                child: const RegisterView(),
              ),
          //  '/adm': (context) => const HomeAdmView(),
          '/admUsers': (context) => const AdmUsers(),
          '/admCreateForm': (context) => const CreateFormView(),
          //  '/researcher': (context) => const HomeResearcherView(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Poppins', scaffoldBackgroundColor: backGroundColor),
        home: BlocBuilder<SignInBloc, ISignInState>(
          builder: (context, state) {
            if (state is SignInSuccess && state.typeUser == TypeUser.admin) {
              return const HomeAdmView();
            } else if (state is SignInSuccess &&
                state.typeUser == TypeUser.user) {
              return const HomeResearcherView();
            } else {
              return const SignupView();
            }
          },
        ),
      ),
    );
  }
}
