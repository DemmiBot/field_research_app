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
    final response = await client.get(url: 'http://192.168.15.9:8080/polls');

    if (response.statusCode == 200) {
      List<ResearchesModel> researches = [];

      var body = jsonDecode(response.body);

      body.map((item) {
        researches.add(ResearchesModel.fromJson(item));
      }).toList();

      return researches;
    } else {}
    return [];
  }
}
