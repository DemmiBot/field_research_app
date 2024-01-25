import 'package:fieldresearch/repositories/account_repository.dart';
import 'package:flutter/material.dart';

class RegisterController {
  static var nameRegister = TextEditingController();
  static var emailRegister = TextEditingController();
  static var passwordRegister = TextEditingController();
  static var repitPassRegister = TextEditingController();
  static AccountRepository repositoryController = AccountRepository();
  static bool loading = false;

  static void cleanText() {
    nameRegister.clear();
    emailRegister.clear();
    passwordRegister.clear();
    repitPassRegister.clear();
  }
}
