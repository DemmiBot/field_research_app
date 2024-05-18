part of 'user_model_bloc.dart';

enum GetStatus { success, loading, failure }

class UserModelState extends Equatable {
  final GetStatus status;
  final UserModel? user;

  const UserModelState._({this.status = GetStatus.loading, this.user});

  const UserModelState.loading() : this._();

  const UserModelState.success({required UserModel user})
      : this._(status: GetStatus.success, user: user);

  const UserModelState.failure() : this._(status: GetStatus.failure);

  @override
  List<Object?> get props => [status, user];
}
