import 'package:app_ui/app_ui.dart';
import 'package:fieldresearch/researcher_page/researches_user_view.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_repository/research_repository.dart';
import 'package:user_repository/user_repository.dart';

class HomeResearcherPage extends StatelessWidget {
  final String userId;

  const HomeResearcherPage({
    super.key,
    required this.userId,
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
              GetUserData(userId: userId),
            ),
        ),
      ],
      child: const HomeResearcherView(),
    );
  }
}

class HomeResearcherView extends StatefulWidget {
  const HomeResearcherView({super.key});

  @override
  State<HomeResearcherView> createState() => _ResearcherViewState();
}

class _ResearcherViewState extends State<HomeResearcherView> {
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
      bottomNavigationBar: MyNavBar.user(pageController: _pageController),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => context
            .read<BottomNavBloc>()
            .add(IndexChangedEvent(newIndex: BottomNavBloc.toEnum(value))),
        children: const [
          ResearchesUserView(),
          Center(child: Text('Page 2')),
          Center(child: Text('Page 3')),
        ],
      ),
    );
  }
}
