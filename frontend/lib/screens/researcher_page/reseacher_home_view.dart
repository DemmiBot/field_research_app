import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeResearcherPage extends StatelessWidget {
  const HomeResearcherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavBloc(),
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
      bottomNavigationBar: MyNavBar(pageController: _pageController),
      body: IgnorePointer(
        child: PageView(
          controller: _pageController,
          onPageChanged: (value) => context
              .read<BottomNavBloc>()
              .add(IndexChangedEvent(newIndex: BottomNavBloc.toEnum(value))),
          children: const [
            Center(child: Text('Page 1')),
            Center(child: Text('Page 2')),
            Center(child: Text('Page 3')),
          ],
        ),
      ),
    );
  }
}
