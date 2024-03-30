import 'package:fieldresearch/models/users_model.dart';
import 'package:fieldresearch/repositories/user_repository.dart';
import 'package:flutter/material.dart';

//feedback/errors
//dps q tiver feedback tirar o try catch
class LoginController {
  final IUserRepository repository;
  LoginController({required this.repository});
  static var emailController = TextEditingController();
  static var passwordController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  late UserModel userInfo;

  Future userLogin() async {
    isLoading.value = true;
    try {
      userInfo = await repository.userLogin(
          login: emailController.text.trim(),
          password: passwordController.text.trim());
      isLoading.value = false;
      return userInfo;
    } catch (e) {}
  }

  UserModel get getCurrentUser => userInfo;

  void cleanText() {
    emailController.clear();
    passwordController.clear();
  }

  void switchPage(BuildContext context, var userInfo) async {
    if (userInfo.adm == 'ADMIN') {
      Navigator.pushNamed(
        context,
        '/adm',
        arguments: userInfo,
      );

      cleanText();
    }
    if (userInfo.adm == 'USER') {
      Navigator.pushNamed(context, '/researcher');

      cleanText();
    }
  }
}
