import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_alleck/model/user.dart';
import 'package:frontend_alleck/providers/api_client_provider.dart';
import 'package:frontend_alleck/providers/authentication_provider.dart';
import 'package:frontend_alleck/services/api_client.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final ApiClient apiClient;

  UserRepository(this.apiClient);

  Future<http.Response> fetchUsers() async {
    final response = await apiClient.get('users');
    return response;
  }

  dynamic createUser(User user) async {
    final userData = {
      'email': user.email,
      'username': user.username,
      'password': user.password,
      'role': user.role!.name
    };

    final response = await apiClient.post('auth/register', userData);
    return response;
  }

  Future<bool> login(WidgetRef ref, User user) async {
    final userData = {
      'email': user.email,
      'username': user.username,
      'password': user.password,
    };

    final response = await apiClient.postWithoutToken('auth/login', userData);
    final json = jsonDecode(response);
    final token = json['token'];
    final jsonUser = User.fromJson(json['user']);

    ref.read(tokenNotifierProvider.notifier).setToken(token);
    ref.read(userNotifierProvider.notifier).setUser(jsonUser);
    return true;
  }
}

final userRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return UserRepository(apiClient);
});
