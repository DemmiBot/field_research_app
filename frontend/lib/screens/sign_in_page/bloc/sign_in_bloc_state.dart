part of 'sign_in_bloc.dart';

enum TypeUser { admin, user }

abstract class ISignInState extends Equatable {
  const ISignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends ISignInState {}

final class SignInSuccess extends ISignInState {
  final TypeUser typeUser;

  const SignInSuccess({required this.typeUser});
}

final class SignInFailure extends ISignInState {
  final String? message;

  const SignInFailure({this.message});
}

final class SignInProcess extends ISignInState {}
