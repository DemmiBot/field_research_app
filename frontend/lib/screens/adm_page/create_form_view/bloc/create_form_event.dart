part of 'create_form_bloc.dart';

abstract class ICreateFormEvent extends Equatable {
  const ICreateFormEvent();

  @override
  List<Object> get props => [];
}

final class AddNewItem extends ICreateFormEvent {}
