part of 'sign_in_bloc.dart';

abstract class ISignInBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class SignInRequiredAndSave extends ISignInBlocEvent {
  final TextEditingController login;
  final TextEditingController password;

  SignInRequiredAndSave({required this.login, required this.password});

  @override
  List<Object> get props => [login, password];
}

final class SignOutRequired extends ISignInBlocEvent {
  SignOutRequired();
}

final class SignInBiometricRequired extends ISignInBlocEvent {}
