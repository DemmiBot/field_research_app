import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_repository/research_repository.dart';

part 'research_model_event.dart';
part 'research_model_state.dart';

class ResearchModelBloc extends Bloc<IResearchModelEvent, ResearchModelState> {
  final IResearchRepository repository;
  ResearchModelBloc({required this.repository})
      : super(const ResearchModelState.loading()) {
    on<GetAllResearches>(_onGetAllResearches);
  }

  Future<void> _onGetAllResearches(
      GetAllResearches event, Emitter<ResearchModelState> emit) async {
    final response = await repository.fetchResearches();

    response.fold(
      (failure) => emit(const ResearchModelState.failure()),
      (success) => emit(ResearchModelState.success(researches: success)),
    );
  }
}
