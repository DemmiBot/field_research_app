part of 'sign_up_bloc.dart';

abstract class ISignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SignUpInitial extends ISignUpState {}

final class SignUpSuccess extends ISignUpState {
  final String message;

  SignUpSuccess({required this.message});
}

final class SignUpFailure extends ISignUpState {
  final String message;

  SignUpFailure({required this.message});
}

final class SignUpProcess extends ISignUpState {}
