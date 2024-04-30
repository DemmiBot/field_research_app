import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  late SpringUserRepository spring;

  setUp(() => spring = SpringUserRepository(client: HttpClient()));

  group('Validação de requisições', () {
    test(' Teste de Login ', () async {
      try {
        final resultToken = await spring.signIn(
          login: 'gabrielfelix20211@hotmail.com',
          password: '123456789',
        );
        expect(resultToken, isNotNull);
      } catch (e) {
        log('logggg => ${e.toString()}');
      }
    });
  });
}
