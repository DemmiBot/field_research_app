import 'package:app_ui/app_ui.dart';
import 'package:fieldresearch/screens/adm_page/create_form_view/create_form_view.dart';
import 'package:fieldresearch/screens/adm_page/home_adm_view/home_adm_view.dart';
import 'package:fieldresearch/screens/adm_page/users_adm_view/users_adm_view.dart';
import 'package:fieldresearch/screens/researcher_page/reseacher_home_view.dart';
import 'package:fieldresearch/screens/sign_in_page/bloc/sign_in_bloc.dart';
import 'package:fieldresearch/screens/sign_in_page/view/sign_in_view.dart';
import 'package:fieldresearch/screens/sign_up_page/view/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:research_repository/research_repository.dart';
import 'package:user_repository/user_repository.dart';

class MainApp extends StatelessWidget {
  final IUserRepository userRepository;
  final IResearchRepository researchRepository;
  const MainApp(
      {super.key,
      required this.userRepository,
      required this.researchRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider(
          create: (_) => SignInBloc(userRepository: userRepository),
        ),
      ],
      child: MyAppView(
        userRepository: userRepository,
        researchRepository: researchRepository,
      ),
    );
  }
}

class MyAppView extends StatelessWidget {
  final IUserRepository userRepository;
  final IResearchRepository researchRepository;
  const MyAppView(
      {super.key,
      required this.userRepository,
      required this.researchRepository});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: false,
      child: MaterialApp(
        routes: {
          '/register': (context) => SignUpPage(userRepository: userRepository),
          '/admUsers': (context) => AdmUsers(usersRepository: userRepository),
          '/admCreateForm': (context) =>
              CreateFormPage(researchRepository: researchRepository),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: MyColors.white,
        ),
        home: BlocBuilder<SignInBloc, ISignInState>(
          builder: (context, state) {
            //success login adm
            if (state is SignInSuccess && state.typeUser == TypeUser.admin) {
              return HomeAdmPage(
                userId: state.userId,
                userRepository: userRepository,
                researchRepository: researchRepository,
              );
            }

            // success login researcher
            else if (state is SignInSuccess &&
                state.typeUser == TypeUser.user) {
              return const HomeResearcherPage();
            }

            // failure login
            else {
              return const SignInView();
            }
          },
        ),
      ),
    );
  }
}
