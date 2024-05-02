part of 'create_form_bloc.dart';

abstract class ICreateFormState extends Equatable {
  const ICreateFormState();

  @override
  List<Object> get props => [];
}

final class CreateFormInitial extends ICreateFormState {}

final class CreateFormLoading extends ICreateFormState {}

final class CreateFormSuccess extends ICreateFormState {}

final class CreateFormFailure extends ICreateFormState {}
