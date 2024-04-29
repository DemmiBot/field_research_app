import 'dart:convert';
import 'package:fieldresearch/http/http_client.dart';
import 'package:fieldresearch/models/users_model.dart';
import 'package:fieldresearch/utils/repository_utils.dart';

abstract class IUserRepository {
  Future userLogin({required String login, required String password});
  Future userRegister({required String login, required String password});
}

class UserRepository implements IUserRepository {
  final IClientHttp client;
  final SpringConection springConnection = SpringConection();
  UserModel user = UserModel(login: '', token: '', role: Role.USER);

  UserRepository({required this.client});

  @override
  userLogin({required String login, required String password}) async {
    final body = jsonEncode({
      'login': login,
      'password': password,
    });
    final response = await client.post(
        url: '${springConnection.adressIP}/auth/login', body: body);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      user = UserModel.fromJson(jsonData);
      return user;
    } else {
      print(response.body);
      return user;
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
        url: '${springConnection.adressIP}auth/register', body: body);

    if (response.statusCode == 200) {
    } else {}
  }
}
