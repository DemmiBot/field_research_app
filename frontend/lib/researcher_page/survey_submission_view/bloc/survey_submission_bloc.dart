import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_repository/research_repository.dart';

part 'survey_submission_event.dart';
part 'survey_submission_state.dart';

class SurveySubmissionBloc
    extends Bloc<SurveySubmissionEvent, SurveySubmissionState> {
  final IResearchRepository _researchRepository;
  SurveySubmissionBloc({required IResearchRepository researchRepository})
      : _researchRepository = researchRepository,
        super(SurveySubmissionInitial()) {
    on<SubmitFormRequired>((event, emit) {});

    on<FetchFormData>((event, emit) {});
  }
}
