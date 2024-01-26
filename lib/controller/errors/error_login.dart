import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ErrorLogin {
  static void errorFeddback(var e, var snack, bool text) {
    if (text) {
      snack.showSnackBar(SnackBar(content: Text(e)));
    } else {
      if (e is AuthException) {
        snack.showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }
}
