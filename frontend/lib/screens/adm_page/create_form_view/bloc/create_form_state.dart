part of 'create_form_bloc.dart';

abstract class ICreateFormState extends Equatable {
  const ICreateFormState();

  @override
  List<Object> get props => [];
}

final class CreateFormInitial extends ICreateFormState {}

final class CreateFormLoading extends ICreateFormState {}

final class CreateFormSuccess extends ICreateFormState {
  final String message;

  const CreateFormSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class CreateFormFailure extends ICreateFormState {
  final String message;

  const CreateFormFailure({required this.message});

  @override
  List<Object> get props => [message];
}
