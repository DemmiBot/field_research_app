import 'dart:convert';
import 'package:fieldresearch/http/http_client.dart';
import 'package:fieldresearch/models/users_model.dart';

abstract class IUserRepository {
  Future userLogin({required String login, required String password});
}

class LoginRepository implements IUserRepository {
  final IClientHttp client;
  UserModel userRepository = UserModel(username: '', adm: '');

  LoginRepository({required this.client});

  @override
  userLogin({required String login, required String password}) async {
    final body = jsonEncode({
      'login': login,
      'password': password,
    });
    final response = await client.post(
        url: 'http://26.146.172.113:8080/auth/login', body: body);

    if (response.statusCode == 200) {
      print('login realizado com sucesso');
      print(response.body);
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      userRepository = UserModel.fromJson(jsonData);
      return userRepository;
    } else {
      print('login deu ruim = ${response.statusCode}');
      return userRepository;
    }
  }
}
