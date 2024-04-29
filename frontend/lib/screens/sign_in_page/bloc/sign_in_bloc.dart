import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
part 'sign_in_bloc_event.dart';
part 'sign_in_bloc_state.dart';

class SignInBloc extends Bloc<ISignInBlocEvent, ISignInState> {
  final IUserRepository _userRepository;

//{"timestamp":"2024-04-29T22:29:10.828+00:00","status":403,"error":"Forbidden","path":"/auth/login"}

  //state inital in constructor
  SignInBloc({required IUserRepository userRepository})
      : _userRepository = userRepository,
        super(SignInInitial()) {
    //trigger signIn event
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        final response = await _userRepository.signIn(
            login: event.email, password: event.password);
        log(response["error"]);
      } catch (failure) {
        log('log: ${failure.toString()}');
        emit(SignInFailure(message: failure.toString()));
      }
    });
    //trigger logOut event
    on<SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
    });
  }
}
