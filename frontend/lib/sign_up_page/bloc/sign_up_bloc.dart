import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<ISignUpEvent, ISignUpState> {
  final IUserRepository _userRepository;

  SignUpBloc({required IUserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpInitial()) {
    on<SignUpRequired>(_onSignUpRequired);
  }

  Future<void> _onSignUpRequired(
      SignUpRequired event, Emitter<ISignUpState> emit) async {
    emit(SignUpProcess());

    final response = await _userRepository.signUp(
      email: event.email,
      password: event.password,
      username: event.username,
    );
    response.fold(
      (failure) => emit(
        SignUpFailure(message: failure.message),
      ),
      (success) => emit(SignUpSuccess(message: success)),
    );
  }
}
