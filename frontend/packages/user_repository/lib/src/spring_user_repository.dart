import 'dart:convert';

import 'package:user_repository/src/models/user_model.dart';

import 'http/http_client.dart';
import 'user_repo.dart';

class SpringConection {
  SpringConection._();
  static String adressIP = 'http://192.168.15.11:8080';
}

class SpringUserRepository implements IUserRepository {
  SpringUserRepository({required this.client});

  final IClientHttp client;

  @override
  Future<UserModel> getMyUser() {
    throw UnimplementedError();
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
    // if (response.statusCode == 200) {
    //   Map<String, dynamic> jsonData = jsonDecode(response.body);
    //   userRepository = UserModel.fromJson(jsonData);
    //   return userRepository;
    // } else {
    //   return userRepository;
    // }
  }

  @override
  Future<Map<String, dynamic>> signUp(
      {required String login, required String password}) async {
    final body = jsonEncode(
      {
        'login': login,
        'password': password,
        'role': "USER",
      },
    );

    final response = await client.post(
        url: '${SpringConection.adressIP}/auth/register', body: body);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    return jsonData;
  }
}
