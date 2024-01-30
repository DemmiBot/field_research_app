import 'package:flutter/material.dart';

class UsersAdmProvider extends ChangeNotifier {
  bool clicked = false;

  void checkBox() {
    clicked = !clicked;
    notifyListeners();
  }
}
