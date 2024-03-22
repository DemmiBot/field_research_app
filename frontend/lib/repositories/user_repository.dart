import 'dart:convert';
import 'package:fieldresearch/http/http_client.dart';
import 'package:fieldresearch/models/users_model.dart';

abstract class IUserRepository {
  Future userLogin({required String login, required String password});
  Future userRegister({required String login, required String password});
}

class UserRepository implements IUserRepository {
  final IClientHttp client;
  UserModel userRepository = UserModel(username: '', adm: '');

  UserRepository({required this.client});

  @override
  userLogin({required String login, required String password}) async {
    final body = jsonEncode({
      'login': login,
      'password': password,
    });
    final response = await client.post(
        url: 'http://192.168.15.9:8080/auth/login', body: body);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      userRepository = UserModel.fromJson(jsonData);
      return userRepository;
    } else {
      return userRepository;
    }
  }

  @override
  Future userRegister({required String login, required String password}) async {
    final body = jsonEncode(
      {
        'login': login,
        'password': password,
        'role': "USER",
      },
    );
    final response = await client.post(
        url: 'http://192.168.15.9:8080/auth/register', body: body);

    if (response.statusCode == 200) {
    } else {}
  }
}
