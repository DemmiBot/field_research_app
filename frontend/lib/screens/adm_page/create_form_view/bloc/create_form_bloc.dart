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
    on<CreateFormRequired>((event, emit) async {
      final response = await _repository.createPoll(pollData: event.pollData);
      if (response.statusCode == 201) {
        emit(CreateFormSuccess());
      } else {
        emit(const CreateFormFailure(message: 'Erro ao criar pesquisa'));
      }
    });
  }
}
