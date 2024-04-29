part of 'sign_up_bloc.dart';

abstract class ISignUpEvent extends Equatable {
  const ISignUpEvent();
  @override
  List<Object> get props => [];
}

final class SignUpRequired extends ISignUpEvent {
  final String login;
  final String password;

  const SignUpRequired({required this.login, required this.password});
}
