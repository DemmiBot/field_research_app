part of 'create_form_bloc.dart';

abstract class ICreateFormEvent extends Equatable {
  const ICreateFormEvent();

  @override
  List<Object> get props => [];
}

final class CreateFormRequired extends ICreateFormEvent {
  final Map<String, dynamic> pollData;

  const CreateFormRequired({required this.pollData});
  @override
  List<Object> get props => [pollData];
}

final class ResetStateBloc extends ICreateFormEvent {}
