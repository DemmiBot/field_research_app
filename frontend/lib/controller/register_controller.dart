import 'package:fieldresearch/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class RegisterController {
  final IUserRepository repository;
  RegisterController({required this.repository});
  var nameRegister = TextEditingController();
  var emailRegister = TextEditingController();
  static var passwordRegister = TextEditingController();
  static var repitPassRegister = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  get repitPassword => repitPassRegister;

  void userRegister() async {
    isLoading.value = true;
    try {
      await repository.userRegister(
          login: nameRegister.text.trim(),
          password: passwordRegister.text.trim());
    } catch (e) {}
    isLoading.value = false;
  }

  void cleanText() {
    nameRegister.clear();
    emailRegister.clear();
    passwordRegister.clear();
    repitPassRegister.clear();
  }
}
