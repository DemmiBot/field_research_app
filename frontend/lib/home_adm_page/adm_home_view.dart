import 'package:app_ui/app_ui.dart';
import 'package:fieldresearch/home_adm_page/researches_adm_view.dart';
import 'package:fieldresearch/home_adm_page/users_adm_view/cubit/manage_users_cubit.dart';
import 'package:fieldresearch/home_adm_page/users_adm_view/users_adm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_repository/research_repository.dart';
import 'package:user_repository/user_repository.dart';

class AdmHomeViewPage extends StatelessWidget {
  final UserModel currentUser;

  const AdmHomeViewPage({
    super.key,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavBloc(),
        ),
        BlocProvider(
          create: (context) =>
              ResearchModelBloc(repository: context.read<IResearchRepository>())
                ..add(GetAllResearches()),
        ),
        BlocProvider(
          create: (context) => UserModelBloc(
            repository: context.read<IUserRepository>(),
          )..add(
              GetUserData(userId: currentUser.id),
            ),
        ),
        BlocProvider(
          create: (context) =>
              ManageUsersCubit(userRepository: context.read<IUserRepository>())
                ..fetchUsers(),
        ),
      ],
      child: AdmHomeView(currentUser: currentUser),
    );
  }
}

class AdmHomeView extends StatefulWidget {
  final UserModel currentUser;
  const AdmHomeView({super.key, required this.currentUser});

  @override
  State<AdmHomeView> createState() => _AdmHomeViewState();
}

class _AdmHomeViewState extends State<AdmHomeView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyNavBar.adm(pageController: _pageController),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => context
            .read<BottomNavBloc>()
            .add(IndexChangedEvent(newIndex: BottomNavBloc.toEnum(value))),
        children: [
          const ResearchesAdmView(),
          AdmUsersView(currentUser: widget.currentUser),
          const Center(child: Text('Page 3')),
          const Center(child: Text('Page 4')),
        ],
      ),
    );
  }
}
