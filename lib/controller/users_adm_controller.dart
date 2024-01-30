import 'dart:async';

import 'package:fieldresearch/controller/errors/error_login.dart';
import 'package:fieldresearch/models/users_adm_model.dart';
import 'package:fieldresearch/provider/adm_provider.dart';
import 'package:fieldresearch/repositories/users_repository.dart';

class UsersAdmController {
  final UsersRepository dataProvider = UsersRepository();
  List<UserAdmModel> researchesList = [];
  static List selectedItem = [];
  UsersRepository userAux = UsersRepository();
  List<int> indexes = [];
  List<UserAdmModel> snapshot = [];

  bool convertBool(String text) {
    if (text.toLowerCase() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future<List<UserAdmModel>> fetchUsers() async {
    researchesList = await dataProvider.fetchUsers();
    return researchesList;
  }

  void modifiedUser(email, value) {
    var existingItem =
        selectedItem.indexWhere((item) => item['email'] == email);

    if (existingItem != -1) {
      selectedItem.removeAt(existingItem);
    }

    selectedItem.add({'email': email, 'admin': value});
  }

  void updateUser(var snack) async {
    if (selectedItem.isEmpty) {
      ErrorFeedback.errorFeddback('Nenhuma alteração de usuário', snack, true);
    } else {
      for (var item in selectedItem) {
        String email = item['email'];
        String newAdminStatus = item['admin'];

        try {
          await dataProvider.updateUsers(email, convertBool(newAdminStatus));
        } catch (e) {
          ErrorFeedback.errorFeddback(e, snack, false);
        }
      }
      ErrorFeedback.errorFeddback('Alterações salvas', snack, true);
    }
  }

  List<UserAdmModel> verifyUser(List<UserAdmModel> snapshot) {
    snapshot.removeWhere((user) => user.email == AdmProvider.nameUser.email);

    return snapshot;
  }

  void deleteUsers(var snack) async {
    try {
      for (var i in indexes) {
        await userAux.removeUsers(snapshot[i].email);
      }
    } catch (e) {
      ErrorFeedback.errorFeddback(e, snack, false);
    }

    ErrorFeedback.errorFeddback('Usúarios removidos', snack, true);
  }
}
