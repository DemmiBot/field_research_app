import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_repository/research_repository.dart';

part 'create_form_event.dart';
part 'create_form_state.dart';

class CreateFormBloc extends Bloc<ICreateFormEvent, ICreateFormState> {
  final IResearchRepository _repository;
  CreateFormBloc({required IResearchRepository repository})
      : _repository = repository,
        super(CreateFormInitial()) {
    on<CreateFormRequired>(_onCreateFormRequired);

    on<ResetStateBloc>((event, emit) {
      emit(CreateFormInitial());
    });
  }

  Future<void> _onCreateFormRequired(
      CreateFormRequired event, Emitter<ICreateFormState> emit) async {
    final response = await _repository.createPoll(pollData: event.pollData);

    response.fold(
      (failure) => emit(CreateFormFailure(message: failure.message)),
      (success) => emit(CreateFormSuccess(message: success)),
    );
  }
}
