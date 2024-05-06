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
  Future<UserModel> getMyUser({required String userId}) async {
    final response =
        await client.get(url: '${SpringConection.adressIP}/users/$userId');
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    return UserModel.fromJson(jsonData);
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
    if (jsonData.containsKey('user')) {
      Map<String, dynamic> userData = {
        'userId': jsonData['user']['user_id'],
        'typeUser': jsonData['user']['role']
      };

      return Right(userData);
    } else {
      return Left(Failure(message: jsonData['error']));
    }
  }

  @override
  Future<String> signUp(
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

    return response.body;
  }
}
