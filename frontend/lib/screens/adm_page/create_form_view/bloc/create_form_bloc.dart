import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_form_event.dart';
part 'create_form_state.dart';

class CreateFormBloc extends Bloc<ICreateFormEvent, ICreateFormState> {
  CreateFormBloc() : super(CreateFormInitial()) {
    on<AddNewItem>((event, emit) {});
  }
}
