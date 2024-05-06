import 'package:app_client/app_client.dart';
import 'package:dartz/dartz.dart';

import 'models/models.dart';

abstract class IResearchRepository {
  Future<Either<Failure, List<ResearchModel>>> fetchResearches();

  Future<Either<Failure, String>> createPoll({
    required Map<String, dynamic> pollData,
  });
}
