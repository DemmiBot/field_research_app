import 'dart:convert';
import 'package:fieldresearch/http/http_client.dart';
import 'package:fieldresearch/models/users_model.dart';
import 'package:fieldresearch/utils/repository_utils.dart';

abstract class IUsersRepository {
  Future fetchUsers();
}

class UsersRepository implements IUsersRepository {
  final IClientHttp client;
  final SpringConection spConection = SpringConection();
  UsersRepository({required this.client});

  @override
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    var response = await client.get(url: '${spConection.adressIP}/users');
    var userList = jsonDecode(response.body);
    List<Map<String, dynamic>> usersList =
        userList.cast<Map<String, dynamic>>();
    return usersList;
  }
}

class UsersRepositoryy {
  static List<UserAdmModel> usersList = [];

  // Future<List<UserAdmModel>> fetchUsers() async {
  // final data =
  //   await supabase.from('users').select().order('name', ascending: true);
  // = data.map((data) => UserAdmModel.fromJson(data)).toList();

  // return usersList;
  // }

  Future<void> updateUsers(String email, bool admin) async {
    // await supabase.from('users').update({'is_admin': admin}).eq('email', email);
  }

  static Future<void> removeUsers(String email) async {
    //await await supabase.from('users').delete().match({'email': email});
  }
}
