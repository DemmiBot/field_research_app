part of 'research_model_bloc.dart';

abstract class IResearchModelEvent extends Equatable {
  const IResearchModelEvent();

  @override
  List<Object> get props => [];
}

class GetAllResearches extends IResearchModelEvent {}
