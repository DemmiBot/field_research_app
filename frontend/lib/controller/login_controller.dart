import 'package:fieldresearch/models/users_model.dart';
import 'package:fieldresearch/repositories/login_repository.dart';
import 'package:flutter/material.dart';

class LoginController {
  final IUserRepository repository;
  LoginController({required this.repository});
  static var emailController = TextEditingController();
  static var passwordController = TextEditingController();
  final ValueNotifier<bool> isloading = ValueNotifier(false);
  UserModel userInfo = UserModel(username: '', adm: '');

  void userLogin() async {
    isloading.value = true;
    try {
      print('iniciandoooo');
      userInfo = await repository.userLogin(
          login: emailController.text.trim(),
          password: passwordController.text.trim());
      print('iniciandoooo');
    } catch (e) {
      print(e.toString());
    }
    isloading.value = false;
  }

  void cleanText() {
    emailController.clear();
    passwordController.clear();
  }

  //se o usuario voltar na tela de login o valor do adm é do outro, model n tá recebendo valor dnv
  void switchPage(BuildContext context) async {
    if (userInfo.adm == 'ADMIN') {
      Navigator.pushNamed(
        context,
        '/adm',
        arguments: userInfo,
      );
      cleanText();
    } else if (userInfo.adm == 'USER') {
      Navigator.pushNamed(context, '/researcher');
      cleanText();
    }
  }
}
//feedback/errors