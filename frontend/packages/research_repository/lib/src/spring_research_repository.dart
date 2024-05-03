import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
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

  @override
  Future<Response> createPoll({required Map<String, dynamic> pollData}) async {
    List<Map<String, dynamic>> drops = [];

    List<Map<String, dynamic>> fieldItem = [];

    List<Map<String, dynamic>> options = [];

    pollData.forEach((key, value) {
      if (key.startsWith('fieldItem')) {
        fieldItem.add({key: value});
      } else if (key.startsWith('drop')) {
        drops.add({key: value});
      }
    });

    List<String> keysDrops =
        drops.map((mapa) => mapa.keys).expand((chaves) => chaves).toList();

    List<String> keysField =
        fieldItem.map((mapa) => mapa.keys).expand((chaves) => chaves).toList();

    for (int i = 0; i < fieldItem.length; i++) {
      if (drops[i][keysDrops[i]] == 'INTEIRO') {
        options.add({
          "optionName": fieldItem[i][keysField[i]],
          "optionType": "int4",
        });
      } else if (drops[i][keysDrops[i]] == 'TEXTO') {
        options.add({
          "optionName": fieldItem[i][keysField[i]],
          "optionType": "varchar",
        });
      }
    }
    final body = jsonEncode({
      "name": pollData['name'],
      "description": pollData['description'],
      "status": "OPEN",
      "options": options,
    });
    log('log[body]==> $body');
    final response =
        await client.post(url: '${SpringConection.adressIP}/polls', body: body);
    log('log[createPoll]==> ${response.body}');
    return response;
  }
}


//   {
//     "name": "Nome Da Pesquisa",
//     "description": "Descricao da Pesquisa",
//     "status": "OPEN",
//     "options": [
//         {
//             "optionName": "nome",
//             "optionType": "varchar"
//         }
//     ]
// }