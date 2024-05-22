part of 'survey_submission_bloc.dart';

abstract class SurveySubmissionEvent extends Equatable {
  const SurveySubmissionEvent();

  @override
  List<Object> get props => [];
}

class SubmitFormRequired extends SurveySubmissionEvent {}

class FetchFormData extends SurveySubmissionEvent {
// oq precisa na rerquisição?
}
