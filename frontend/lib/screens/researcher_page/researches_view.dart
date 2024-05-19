import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_repository/research_repository.dart';
import 'package:user_repository/user_repository.dart';

class ResearchesViewPage extends StatelessWidget {
  final IResearchRepository researchRepository;

  final IUserRepository userRepository;

  final String userId;

  const ResearchesViewPage({
    super.key,
    required this.researchRepository,
    required this.userRepository,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ResearchModelBloc(repository: researchRepository)
          ..add(GetAllResearches()),
      ),
      BlocProvider(
        create: (context) => UserModelBloc(
          repository: userRepository,
        )..add(
            GetUserData(userId: userId),
          ),
      ),
    ], child: const ResearchesView());
  }
}

class ResearchesView extends StatefulWidget {
  const ResearchesView({super.key});

  @override
  State<ResearchesView> createState() => _ResearchesViewState();
}

class _ResearchesViewState extends State<ResearchesView> {
  List<ResearchModel> research = [];

  UserModel user = UserModel.empty;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
