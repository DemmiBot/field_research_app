import 'package:flutter/material.dart';

mixin FormMixin {
  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  String? isNotEmpty(String? value) {
    if (value!.isEmpty) return 'Campo vazio';
    return null;
  }

  String? isNotEmptyFlutterForm(String? value) {
    if (value == null) return 'Campo vazio';
    if (value.isEmpty) return 'Campo vazio';
    return null;
  }

  String? emailValidator(String? value) {
    if (!_emailRegExp.hasMatch(value!)) return 'Email inválido';

    return null;
  }

  String? passwordValidador(String? value) {
    if (value!.length < 8) return 'Senha inválida';
    return null;
  }

  String? repeatPassword(
      {required String? value,
      required TextEditingController password,
      required TextEditingController passwordagain}) {
    if (password.text != passwordagain.text) {
      return 'As senhas não são iguais. Tente novamente.';
    }
    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }
    return null;
  }
}
