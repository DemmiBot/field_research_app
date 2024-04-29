import 'dart:convert';
import 'package:fieldresearch/http/http_client.dart';
import 'package:fieldresearch/models/researches_model.dart';
import 'package:fieldresearch/utils/repository_utils.dart';

abstract class IResearchesRepository {
  Future<List<ResearchesModel>> getResearches();
}

class ResearchesRepository implements IResearchesRepository {
  final IClientHttp client;
  final SpringConection spConection = SpringConection();

  ResearchesRepository({required this.client});

  @override
  Future<List<ResearchesModel>> getResearches() async {
    final response = await client.get(url: '${spConection.adressIP}/polls');

    if (response.statusCode == 200) {
      List<ResearchesModel> researches = [];

      var body = jsonDecode(response.body);

      body.map((item) {
        researches.add(ResearchesModel.fromJson(item));
      }).toList();

      return researches;
    }
    return [];
  }
}