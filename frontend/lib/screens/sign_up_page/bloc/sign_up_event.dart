part of 'sign_up_bloc.dart';

abstract class ISignUpEvent extends Equatable {
  const ISignUpEvent();
  @override
  List<Object> get props => [];
}

final class SignUpRequired extends ISignUpEvent {
  final String email;
  final String username;
  final String password;

  const SignUpRequired({
    required this.email,
    required this.username,
    required this.password,
  });
}
