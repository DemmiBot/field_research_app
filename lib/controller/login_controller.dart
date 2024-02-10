import 'package:fieldresearch/provider/adm_provider.dart';
import 'package:fieldresearch/repositories/account_repository.dart';
import 'package:flutter/material.dart';

class LoginController {
  static var emailController = TextEditingController();
  static var passwordController = TextEditingController();

  static AccountRepository repositoryController = AccountRepository();
  static AdmProvider providerController = AdmProvider();

  static void cleanText() {
    emailController.clear();
    passwordController.clear();
  }

  static void switchPage(BuildContext context) async {
    if (await AccountRepository.admimVerification()) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/adm');
      LoginController.cleanText();
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/researcher');
      LoginController.cleanText();
    }
  }
}
