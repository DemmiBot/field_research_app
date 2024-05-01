part of 'user_model_bloc.dart';

abstract class IUserModelEvent extends Equatable {
  const IUserModelEvent();

  @override
  List<Object> get props => [];
}

final class GetUserData extends IUserModelEvent {
  final String userId;

  const GetUserData({required this.userId});

  @override
  List<Object> get props => [userId];
}
