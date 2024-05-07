import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'manage_users_state.dart';

class ManageUsersCubit extends Cubit<ManageUsersState> {
  ManageUsersCubit({required IUserRepository userRepository})
      : _userRepository = userRepository,
        super(const ManageUsersState.loading());

  final IUserRepository _userRepository;

  Future<void> fetchUsers() async {
    final response = await _userRepository.fetchUsers();

    response.fold(
      (failure) => emit(ManageUsersState.failure(message: failure.message)),
      (success) => emit(ManageUsersState.success(users: success)),
    );
  }
}
