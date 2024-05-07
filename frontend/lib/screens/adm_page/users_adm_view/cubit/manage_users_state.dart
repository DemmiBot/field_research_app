part of 'manage_users_cubit.dart';

enum UsersState { success, failure, loading }

class ManageUsersState extends Equatable {
  final UsersState state;
  final List<UserModel>? users;
  final String? message;

  const ManageUsersState._({
    this.state = UsersState.loading,
    this.users,
    this.message,
  });

  const ManageUsersState.success({required List<UserModel> users})
      : this._(state: UsersState.success, users: users);

  const ManageUsersState.failure({required String message})
      : this._(state: UsersState.failure, message: message);

  const ManageUsersState.loading() : this._();

  @override
  List<Object?> get props => [state, users];
}
