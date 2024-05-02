import 'models/models.dart';

abstract class IResearchRepository {
  Future<List<ResearchModel>> fetchResearches();
}
