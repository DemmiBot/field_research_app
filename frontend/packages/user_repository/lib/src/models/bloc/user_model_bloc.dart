import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:user_repository/user_repository.dart';

part 'user_model_event.dart';
part 'user_model_state.dart';

class UserModelBloc extends Bloc<IUserModelEvent, UserModelState> {
  final IUserRepository repository;

  UserModelBloc({required this.repository})
      : super(const UserModelState.loading()) {
    on<GetUserData>((event, emit) async {
      final response = await repository.getMyUser(userId: event.userId);
      response.fold(
        (failure) => emit(const UserModelState.failure()),
        (success) => emit(UserModelState.success(user: success)),
      );
    });
  }
}
