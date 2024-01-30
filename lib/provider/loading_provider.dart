import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool loading = false;

  void loadingConfirm() {
    loading = !loading;
    notifyListeners();
  }
}
