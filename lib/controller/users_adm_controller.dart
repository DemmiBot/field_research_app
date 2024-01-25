import 'package:fieldresearch/models/users_adm_model.dart';
import 'package:fieldresearch/repositories/users_repository.dart';

class UsersAdmController {
  final UsersRepository dataProvider = UsersRepository();
  List<UserAdmModel> researchesList = [];

  Future<List<UserAdmModel>> fetchUsers() async {
    researchesList = await dataProvider.fetchUsers();
    return researchesList;
  }
}
