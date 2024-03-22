import 'package:flutter/material.dart';

class ErrorFeedback {
  static void errorFeddback(var e, var snack, bool text) {
    if (text) {
      snack.showSnackBar(SnackBar(content: Text(e)));
    } else {
      if (e) {
        snack.showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }
}
