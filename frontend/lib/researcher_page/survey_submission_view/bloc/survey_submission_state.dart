part of 'survey_submission_bloc.dart';

abstract class SurveySubmissionState extends Equatable {
  const SurveySubmissionState();

  @override
  List<Object> get props => [];
}

final class SurveySubmissionInitial extends SurveySubmissionState {}

final class SurveySubmissionLoading extends SurveySubmissionState {}

final class SurveySubmissionSuccess extends SurveySubmissionState {
  final String message;

  const SurveySubmissionSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class SurveySubmissionFailure extends SurveySubmissionState {
  final String message;

  const SurveySubmissionFailure({required this.message});

  @override
  List<Object> get props => [message];
}
