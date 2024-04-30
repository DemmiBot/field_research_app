import 'package:email_validator/email_validator.dart';

mixin RegisterMixin {
  String? isNotEmpty(String? value) {
    if (value!.isEmpty) return 'Campo vazio';
    return null;
  }

  String? emailValidator(String? value) {
    if (EmailValidator.validate(value!) == false) return 'Email inválido';

    return null;
  }

  String? passwordValidador(String? value) {
    if (value!.length < 8) return 'Senha inválida';
    return null;
  }

  // String? repeatPassword(String? value) {
  //   if (RegisterController.passwordRegister.text !=
  //       RegisterController.repitPassRegister.text) {
  //     return 'As senhas não são iguais. Tente novamente.'; // Totalmente profissional agora meu nobre 😎👍
  //   }
  //   return null;
  // }

  String? combine(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }
    return null;
  }
}
