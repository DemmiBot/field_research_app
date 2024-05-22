import 'package:app_ui/app_ui.dart';
import 'package:fieldresearch/home_adm_page/create_form_view/view/create_form_view.dart';
import 'package:fieldresearch/home_adm_page/adm_home_view.dart';
import 'package:fieldresearch/researcher_page/reseacher_home_view.dart';
import 'package:fieldresearch/researcher_page/survey_submission_view/view/survey_submission_view.dart';
import 'package:fieldresearch/sign_in_page/bloc/sign_in_bloc.dart';
import 'package:fieldresearch/sign_in_page/view/sign_in_view.dart';
import 'package:fieldresearch/sign_up_page/view/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:research_repository/research_repository.dart';
import 'package:user_repository/user_repository.dart';

class MainApp extends StatelessWidget {
  final IUserRepository _userRepository;
  final IResearchRepository _researchRepository;

  const MainApp({
    super.key,
    required IUserRepository userRepository,
    required IResearchRepository researchRepository,
  })  : _userRepository = userRepository,
        _researchRepository = researchRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _researchRepository),
      ],
      child: BlocProvider(
        create: (context) =>
            SignInBloc(userRepository: context.read<IUserRepository>()),
        child: const MyAppView(),
      ),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: false,
      child: MaterialApp(
        routes: {
          '/register': (context) => const SignUpPage(),
          '/admCreateForm': (context) => const CreateFormPage(),
          '/surveySubmission': (context) => const SurveySubmissionPage()
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
              return AdmHomeViewPage(currentUser: state.currentUser);
            }

            // success login researcher
            else if (state is SignInSuccess &&
                state.typeUser == TypeUser.user) {
              return HomeResearcherPage(userId: state.currentUser.id);
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
