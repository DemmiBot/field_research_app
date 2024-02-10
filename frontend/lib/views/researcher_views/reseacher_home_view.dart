import 'package:flutter/material.dart';

class HomeResearcherView extends StatefulWidget {
  const HomeResearcherView({super.key});

  @override
  State<HomeResearcherView> createState() => _ResearcherViewState();
}

class _ResearcherViewState extends State<HomeResearcherView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'TU É UM PESQUISADOR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
