import 'package:fieldresearch/researcher_page/survey_submission_view/bloc/survey_submission_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_repository/research_repository.dart';

class SurveySubmissionPage extends StatelessWidget {
  const SurveySubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SurveySubmissionBloc(
          researchRepository: context.read<IResearchRepository>()),
      child: const SurveySubmissionView(),
    );
  }
}

class SurveySubmissionView extends StatefulWidget {
  const SurveySubmissionView({super.key});

  @override
  State<SurveySubmissionView> createState() => _SurveySubmissionViewState();
}

class _SurveySubmissionViewState extends State<SurveySubmissionView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Expanded(
        child: Center(
          child: Text('COMMING SOON'),
        ),
      ),
    );
  }
}
