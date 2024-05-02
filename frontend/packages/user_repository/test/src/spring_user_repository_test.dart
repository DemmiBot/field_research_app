import 'package:flutter_test/flutter_test.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  late SpringUserRepository spring;

  setUp(() => spring = SpringUserRepository(client: HttpClient()));

  group('Validação de requisições', () {
    test(' Teste de Login ', () async {
      final resultToken = await spring.signIn(
        login: 'gabrielfelix20211@hotmail.com',
        password: '123456789',
      );
      expect(resultToken, isNotNull);
    });

    test('Teste de Registro', () async {
      final String resultToken =
          await spring.signUp(login: 'neguinho', password: '123456789');

      expect(resultToken, equals(''));
    });
  });

  group('Requisição de dados do usuário', () {
    test('Retorno de requisição', () async {
      final resultToken = await spring.getMyUser(
          userId: '46df25f3-ef5b-465f-a894-8717b4e5c6d9');

      expect(resultToken, isNotEmpty);
    });
  });
}
