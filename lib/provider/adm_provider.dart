import 'package:fieldresearch/models/researches_model.dart';
import 'package:fieldresearch/models/user_model.dart';
import 'package:fieldresearch/repositories/account_repository.dart';
import 'package:flutter/material.dart';

class AdmProvider extends ChangeNotifier {
  UserModel nameUser = UserModel(name: '');
  List<ResearchesModel> researchesList = [];

  void getnameUser() async {
    nameUser = await AccountRepository.fetchName();
    notifyListeners();
  }
}
