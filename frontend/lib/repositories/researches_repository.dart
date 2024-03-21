import 'dart:convert';
import 'package:fieldresearch/http/http_client.dart';
import 'package:fieldresearch/models/researches_model.dart';

abstract class IResearchesRepository {
  Future<List<ResearchesModel>> getResearches();
}

class ResearchesRepository implements IResearchesRepository {
  final IClientHttp client;

  ResearchesRepository({required this.client});

  @override
  Future<List<ResearchesModel>> getResearches() async {
    final response = await client.get(url: 'http://26.146.172.113:8080/polls');

    if (response.statusCode == 200) {
      List<ResearchesModel> researches = [];
      print(response.body);
      var body = jsonDecode(response.body);

      body.map((item) {
        researches.add(ResearchesModel.fromJson(item));
      }).toList();
      print('Lista carregada');
      return researches;
    } else {
      print(response.statusCode);
    }
    return [];
  }
}
