import 'package:flutter/material.dart';

class RegisterController {
  static var nameRegister = TextEditingController();
  static var emailRegister = TextEditingController();
  static var passwordRegister = TextEditingController();
  static var repitPassRegister = TextEditingController();

  static bool loading = false;

  static void cleanText() {
    nameRegister.clear();
    emailRegister.clear();
    passwordRegister.clear();
    repitPassRegister.clear();
  }
}
