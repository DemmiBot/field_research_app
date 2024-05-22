import 'package:flutter/material.dart';

abstract class IStorageRepository {
  Future<void> initializeStorage();

  Future<String?> get isLoggedIn;

  Future<void> setLogin({
    required TextEditingController login,
    required TextEditingController password,
  });

  Future<List<String?>> get login;
}
