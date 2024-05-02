import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_repository/research_repository.dart';

part 'research_model_event.dart';
part 'research_model_state.dart';

class ResearchModelBloc extends Bloc<IResearchModelEvent, ResearchModelState> {
  final IResearchRepository repository;
  ResearchModelBloc({required this.repository})
      : super(const ResearchModelState.loading()) {
    on<GetAllResearches>((event, emit) async {
      try {
        final List<ResearchModel> response = await repository.fetchResearches();
        emit(ResearchModelState.success(researches: response));
      } catch (e) {
        log('log [ResearchesModelBloc] ==> $e');
        emit(const ResearchModelState.failure());
      }
    });
  }
}
