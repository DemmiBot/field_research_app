import 'package:fieldresearch/models/researches_model.dart';
import 'package:fieldresearch/repositories/data_repository.dart';

class DataController {
  final DataRepository dataProvider = DataRepository();
  List<ResearchesModel> researchesList = [];

  Future<List<ResearchesModel>> fetchData() async {
    researchesList = await dataProvider.fetchResearches();
    return researchesList;
  }
}
