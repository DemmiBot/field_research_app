import 'package:fieldresearch/models/researches_model.dart';
import 'package:fieldresearch/models/users_adm_model.dart';
import 'package:fieldresearch/repositories/account_repository.dart';
import 'package:flutter/material.dart';

class AdmProvider extends ChangeNotifier {
  static UserModel nameUser = UserModel(name: '', email: '');
  List<ResearchesModel> researchesList = [];

  void getnameUser() async {
    nameUser = await AccountRepository.fetchUser();
    notifyListeners();
  }
}
