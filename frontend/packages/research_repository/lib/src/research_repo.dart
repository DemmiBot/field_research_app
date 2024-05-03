import 'package:http/http.dart';

import 'models/models.dart';

abstract class IResearchRepository {
  Future<List<ResearchModel>> fetchResearches();

  Future<Response> createPoll({required Map<String, dynamic> pollData});
}
