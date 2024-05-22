part of 'sign_in_bloc.dart';

abstract class ISignInBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class SignInRequired extends ISignInBlocEvent {
  final String email;
  final String password;

  SignInRequired({required this.email, required this.password});
}

final class SignOutRequired extends ISignInBlocEvent {
  SignOutRequired();
}

final class SignInBiometricRequired extends ISignInBlocEvent {}
