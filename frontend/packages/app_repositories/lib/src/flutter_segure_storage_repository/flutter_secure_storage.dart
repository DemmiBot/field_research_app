import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'storage_repo.dart';

class FlutterSecureStorageRepository implements IStorageRepository {
  final String _isLoggedInKey = 'isLoggedIn';
  final String _usernameKey = 'username';
  final String _passwordKey = 'password';

  late FlutterSecureStorage storage;

  FlutterSecureStorageRepository() {
    initializeStorage();
  }

  @override
  Future<void> setLogin({
    required String login,
    required String password,
  }) async {
    await storage.write(key: _usernameKey, value: login);
    await storage.write(key: _passwordKey, value: password);
    await storage.write(key: _isLoggedInKey, value: 'true');
  }

  @override
  Future<void> initializeStorage() async {
    storage = const FlutterSecureStorage();
    log('log[initializeStorage] storage initialized');
  }

  @override
  Future<String?> get isLoggedIn async =>
      await storage.read(key: _isLoggedInKey);

  @override
  Future<List<String?>> get login async {
    final username = await storage.read(key: _usernameKey);
    final password = await storage.read(key: _passwordKey);
    return [username, password];
  }
}
