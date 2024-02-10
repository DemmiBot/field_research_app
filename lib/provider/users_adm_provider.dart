import 'package:flutter/material.dart';

class UsersAdmProvider extends ChangeNotifier {
  bool clicked = false;
  bool refresh = false;

  void checkBox() {
    clicked = !clicked;
    notifyListeners();
  }

  Future<void> updateList() async {
    refresh = !refresh;
    notifyListeners();
  }
}
