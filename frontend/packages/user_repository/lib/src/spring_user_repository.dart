import 'dart:convert';
import 'dart:developer';

import 'package:app_client/app_client.dart';
import 'package:dartz/dartz.dart';
import 'package:user_repository/src/models/user_model.dart';
import 'user_repo.dart';

class SpringUserRepository implements IUserRepository {
  SpringUserRepository({required this.client});

  final IClientHttp client;

  @override
  Future<Either<Failure, UserModel>> getMyUser({required String userId}) async {
    try {
      final response =
          await client.get(url: '${SpringConection.adressIP}/users/$userId');
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      return Right(UserModel.fromJson(jsonData));
    } catch (e) {
      return const Left(Failure(message: ''));
    }
  }

  @override
  Future logOut() {
    throw UnimplementedError();
  }

  @override
  Future resetPassword() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> signIn(
      {required String login, required String password}) async {
    final body = jsonEncode({
      'login': login,
      'password': password,
    });

    final response = await client.post(
        url: '${SpringConection.adressIP}/auth/login', body: body);

    log(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> userData = {
        'userId': jsonData['user']['user_id'],
        'typeUser': jsonData['user']['role']
      };

      return Right(userData);
    } else {
      return Left(jsonData['error']);
    }
  }

  @override
  Future<Either<Failure, String>> signUp(
      {required String login, required String password}) async {
    final body = jsonEncode(
      {
        'login': login,
        'password': password,
        'role': "ADMIN",
      },
    );

    final response = await client.post(
        url: '${SpringConection.adressIP}/auth/register', body: body);
    Map<String, dynamic> jsonData = {};

    if (response.body == '') {
      return const Right('Cadastro realizado com sucesso');
    } else {
      if (response != null && response.body.isNotEmpty) {
        jsonData = jsonDecode(response.body);
        return Left(Failure(message: jsonData['error']));
      } else {
        return const Left(Failure(message: 'Erro ao cadastrar usuário'));
      }
    }
  }
}
