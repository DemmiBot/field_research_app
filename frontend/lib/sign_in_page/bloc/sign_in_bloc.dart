import 'dart:developer';

import 'package:app_repositories/app_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<ISignInBlocEvent, ISignInState> {
  final IUserRepository _userRepository;

  final BiometricRepository biometric;

  final IStorageRepository _storage;

  //state inital in constructor
  SignInBloc({
    required IStorageRepository storage,
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        _storage = storage,
        biometric = BiometricRepository(storage: storage),
        super(SignInInitial()) {
    //trigger signIn event
    on<SignInRequiredAndSave>(_onSignInRequiredAndSave);

    //trigger logOut event
    on<SignOutRequired>(_onSignOutRequired);

    //trigger signIn biometric event
    on<SignInBiometricRequired>(_onSignInBiometricRequired);
  }

  Future<void> _onSignInRequiredAndSave(
      SignInRequiredAndSave event, Emitter<ISignInState> emit) async {
    emit(SignInProcess());

    final response = await _userRepository.signIn(
      login: event.login.text.trim(),
      password: event.password.text.trim(),
    );

    //save in storage
    if (response.isRight()) {
      await _storage.setLogin(
        login: event.login.text.trim(),
        password: event.password.text.trim(),
      );
    }

    response.fold(
      (failure) => emit(
        SignInFailure(message: failure.message),
      ),
      (success) => emit(
        SignInSuccess(
          currentUser: success,
          typeUser: getTypeUser(success.adm!),
        ),
      ),
    );
  }

  Future<void> _onSignOutRequired(
      SignOutRequired event, Emitter<ISignInState> emit) async {
    await _userRepository.logOut();
  }

  Future<void> _onSignInBiometricRequired(
      SignInBiometricRequired event, Emitter<ISignInState> emit) async {
    final List<String?> login = await _storage.login;

    if (await biometric.authenticate()) {
      emit(SignInProcess());

      final response = await _userRepository.signIn(
        login: login[0]!,
        password: login[1]!,
      );

      response.fold(
        (failure) => emit(
          SignInFailure(message: failure.message),
        ),
        (success) => emit(
          SignInSuccess(
              currentUser: success, typeUser: getTypeUser(success.adm!)),
        ),
      );
    }
  }

  TypeUser getTypeUser(String response) {
    switch (response) {
      case 'USER':
        return TypeUser.user;
      case 'ADMIN':
        return TypeUser.admin;
      default:
        return TypeUser.user;
    }
  }
}
