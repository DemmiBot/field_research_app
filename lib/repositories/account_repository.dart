import 'package:fieldresearch/controller/login_controller.dart';
import 'package:fieldresearch/controller/errors/error_login.dart';
import 'package:fieldresearch/controller/register_controller.dart';
import 'package:fieldresearch/models/user_model.dart';
import 'package:fieldresearch/utils/repository_utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountRepository {
  static var supabase = Supabase.instance.client;
  static var response;
  static late String name;

  //connect the app to the database
  static void inicializeSupabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    var key = SupabaseKey();
    await Supabase.initialize(
      url: key.linkSupa,
      anonKey: key.anonKeySupa,
    );
  }

  //login verification based on the provided information end feedback error.
  Future<bool> signInAccount(var snack) async {
    bool validSign = false;
    try {
      response = await supabase.auth.signInWithPassword(
          email: LoginController.emailController.text.trim(),
          password: LoginController.passwordController.text.trim());
      validSign = true;
      return validSign;
    } catch (e) {
      ErrorFeedback.errorFeddback(e, snack, false);

      return validSign;
    }
  }

  static Future<bool> admimVerification() async {
    final data = await supabase
        .from('users')
        .select('is_admin')
        .eq('email', LoginController.emailController.text);

    if (data[0]['is_admin']) {
      return true;
    } else {
      return false;
    }
  }

  static Future<UserModel> fetchName() async {
    final data = await supabase
        .from('users')
        .select('name')
        .eq('email', LoginController.emailController.text);
    return UserModel(name: data[0]['name'] ?? 'User');
  }

  // talvez gere users extras por erro do usuário, dps vejo uma solução
  Future<void> createUser(String email, String password, var snack) async {
    try {
      await supabase.from('users').insert({
        'name': RegisterController.nameRegister.text.trim(),
        'email': email,
        'is_admin': false,
      });
      response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      ErrorFeedback.errorFeddback('Verifique seu email', snack, true);
    } catch (e) {
      ErrorFeedback.errorFeddback(e, snack, false);
    }
  }
}
