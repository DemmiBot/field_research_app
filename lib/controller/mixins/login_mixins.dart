mixin LoginMixin {
  String? isNotEmpty(String? value) {
    if (value!.isEmpty) return 'Campo vazio';
    return null;
  }

  String? emailValidator(String? value) {
    if (value!.contains('@') != true) return 'Email inválido';
    return null;
  }

  String? passwordValidador(String? value) {
    if (value!.length < 8) return 'Senha inválida';
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
