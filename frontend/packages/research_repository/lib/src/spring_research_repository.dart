import 'dart:convert';
import 'dart:developer';

import 'package:research_repository/research_repository.dart';

class SpringConection {
  SpringConection._();
  static String adressIP = 'http://192.168.15.3:8080';
}

class SpringResearchRepository implements IResearchRepository {
  SpringResearchRepository({required this.client});

  final IClientHttp client;

  @override
  Future<List<ResearchModel>> fetchResearches() async {
    final response = await client.get(url: '${SpringConection.adressIP}/polls');
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      List<ResearchModel> researchList = responseData.map((itemJson) {
        return ResearchModel.fromJson(itemJson);
      }).toList();
      log('log[fetchResearches] ==> $researchList');
      return researchList;
    } else {
      throw Exception('Failed to fetch researches');
    }
  }
}
