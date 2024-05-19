part of 'research_model_bloc.dart';

enum ResearchStatus { success, loading, failure }

class ResearchModelState extends Equatable {
  final ResearchStatus status;
  final List<ResearchModel>? researches;

  const ResearchModelState._(
      {this.status = ResearchStatus.loading, this.researches});

  const ResearchModelState.success({required List<ResearchModel> researches})
      : this._(status: ResearchStatus.success, researches: researches);

  const ResearchModelState.loading() : this._();

  const ResearchModelState.failure() : this._(status: ResearchStatus.failure);

  @override
  List<Object?> get props => [status, researches];
}
