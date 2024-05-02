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
}
