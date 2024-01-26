import 'package:fieldresearch/models/users_adm_model.dart';
import 'package:fieldresearch/repositories/users_repository.dart';

class UsersAdmController {
  final UsersRepository dataProvider = UsersRepository();
  List<UserAdmModel> researchesList = [];
  static List selectedItem = [];

  Future<List<UserAdmModel>> fetchUsers() async {
    researchesList = await dataProvider.fetchUsers();
    return researchesList;
  }

  void modifiedUser(email, value) {
    // Verificar se o email já está na lista
    var existingItem =
        selectedItem.indexWhere((item) => item['email'] == email);

    // Se o email já estiver na lista, remova o item
    if (existingItem != -1) {
      selectedItem.removeAt(existingItem);
    }

    // Adicionar o novo item à lista
    selectedItem.add({'email': email, 'admin': value});

    selectedItem.forEach((item) {
      print('Email: ${item['email']}, Admin: ${item['admin']}');
    });
  }
}
