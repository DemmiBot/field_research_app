import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'storage_repo.dart';

class FlutterSecureStorageRepository implements IStorageRepository {
  final String _isLoggedInKey = 'isLoggedIn';
  final String _usernameKey = 'isLoggedIn';
  final String _passwordKey = 'isLoggedIn';

  late FlutterSecureStorage storage;

  FlutterSecureStorageRepository() {
    initializeStorage();
  }

  @override
  Future<void> setLogin({
    required TextEditingController login,
    required TextEditingController password,
  }) async {
    await storage.write(key: _usernameKey, value: login.text.trim());
    await storage.write(key: _passwordKey, value: password.text.trim());
    await storage.write(key: _isLoggedInKey, value: 'true');
  }

  @override
  Future<void> initializeStorage() async {
    storage = const FlutterSecureStorage();
  }

  @override
  Future<String?> get isLoggedIn async =>
      await storage.read(key: _isLoggedInKey);

  @override
  Future<List<String?>> get login async {
    List<String?> login = [];

    login.add(await storage.read(key: _usernameKey));
    login.add(await storage.read(key: _passwordKey));

    return login;
  }
}
