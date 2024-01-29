import 'package:fieldresearch/models/users_adm_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsersRepository {
  static List<UserAdmModel> usersList = [];
  static var supabase = Supabase.instance.client;

  Future<List<UserAdmModel>> fetchUsers() async {
    final data =
        await supabase.from('users').select().order('name', ascending: true);

    usersList = data.map((data) => UserAdmModel.fromJson(data)).toList();

    return usersList;
  }



  Future<void> updateUsers(String email, bool admin) async {
    await supabase.from('users').update({'is_admin': admin}).eq('email', email);
  }

}
