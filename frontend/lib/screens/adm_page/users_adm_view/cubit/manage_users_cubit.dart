import 'dart:developer';

import 'package:app_client/app_client.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'manage_users_state.dart';

class ManageUsersCubit extends Cubit<ManageUsersState> {
  ManageUsersCubit({required IUserRepository userRepository})
      : _userRepository = userRepository,
        super(const ManageUsersState.loading());

  final IUserRepository _userRepository;

  List<UserModel> usersSelected = [];

  Future<void> fetchUsers() async {
    final response = await _userRepository.fetchUsers();

    response.fold(
      (failure) => emit(ManageUsersState.failure(message: failure.message)),
      (success) => emit(ManageUsersState.success(users: success)),
    );
  }

  Future<void> deleteUsers() async {
    Either<Failure, String>? response;
    if (usersSelected != []) {
      emit(const ManageUsersState.loading());

      for (var user in usersSelected) {
        response = await _userRepository.deleteUser(userId: user.id);
        if (response.isLeft()) {
          return;
        }
      }
      response!.fold(
        (failure) =>
            emit(ManageUsersState.deletionFailure(message: failure.message)),
        (success) => emit(ManageUsersState.deletionSuccess(message: success)),
      );
    } else {
      emit(const ManageUsersState.deletionFailure(
          message: 'Nenhum usuário selecionado'));
    }
  }

  void usersSelect({required bool value, required UserModel user}) {
    if (value == true) {
      usersSelected.add(user);
      log('log[usersSelected] ==> $usersSelected');
    } else {
      usersSelected.remove(user);
      log('log[usersSelected remove] ==> $usersSelected');
    }
  }
}
