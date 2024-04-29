import 'package:fieldresearch/models/users_model.dart';
import 'package:fieldresearch/repositories/auth_repository.dart';
import 'package:fieldresearch/utils/utils.dart';
import 'package:flutter/material.dart';

//feedback/errors
//dps q tiver feedback tirar o try catch
class LoginController {
  final IUserRepository iUserRepository;
  LoginController({required this.iUserRepository});
  static var emailController = TextEditingController();
  static var passwordController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  late UserModel userInfo;

  Future userLogin(BuildContext context) async {
    isLoading.value = true;
    try {
      userInfo = await iUserRepository.userLogin(
          login: emailController.text.trim(),
          password: passwordController.text.trim()
      );
      isLoading.value = false;
      return userInfo;
    } catch (e) {
      print("An error ocurred: $e");
    }
  }

  UserModel get getCurrentUser => userInfo;

  void cleanText() {
    emailController.clear();
    passwordController.clear();
  }

  void switchPage(BuildContext context, var user) async {
    if (user == null) {return;}
      
    if (user.role == Role.ADMIN) {
      Navigator.pushNamed(
        context,
        '/adm',
        arguments: user,
      );

      cleanText();
    }
    if (user.role == Role.USER) {
      Navigator.pushNamed(context, '/researcher');

      cleanText();
    }
  }
}