import 'package:app_client/app_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:research_repository/research_repository.dart';

void main() {
  late SpringResearchRepository spring;

  setUp(() => spring = SpringResearchRepository(client: HttpClient()));
  group('Validação de requisições', () {
    test(' Teste de Login ', () async {
      final resultToken = await spring.fetchResearches();
      expect(resultToken, equals(''));
    });
  });

  test('Salvar pesquisa', () async {
    final resultToken = await spring.createPoll(pollData: {
      "name": null,
      "description": null,
      "fieldItem-1": "opa",
      "drop-1": "INTEIRO",
      "required-1": null,
      "fieldItem0": "tudo",
      "drop0": "TEXTO",
      "required0": null,
      "fieldItem1": "bem",
      "drop1": "INTEIRO",
      "required1": null,
      "intMin1": null,
      "intMAx1": null,
      "intMin-1": null,
      "intMAx-1": null,
      "fieldItem2": "com",
      "drop2": "TEXTO",
      "required2": null,
      "fieldItem3": "voce",
      "drop3": "TEXTO",
      "required3": null,
      "fieldItem4": "?",
      "drop4": "TEXTO",
      "required4": null
    });

    expect(resultToken, equals(''));
  });
}
