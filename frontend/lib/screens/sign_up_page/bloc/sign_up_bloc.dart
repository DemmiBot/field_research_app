import 'dart:developer';

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
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        final response = await _userRepository.signUp(
            login: event.login, password: event.password);
        log('responseee => $response');
        emit(SignUpSuccess());
      } catch (failure) {
        log(' log signup ==>${failure.toString()}');
        emit(SignUpFailure(message: failure.toString()));
      }
    });
  }
}
