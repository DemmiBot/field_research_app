import 'dart:convert';

import 'package:app_client/app_client.dart';
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
  Future<Map<String, dynamic>> signIn(
      {required String login, required String password}) async {
    final body = jsonEncode({
      'login': login,
      'password': password,
    });

    final response = await client.post(
        url: '${SpringConection.adressIP}/auth/login', body: body);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    return jsonData;
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
