import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_alleck/providers/api_client_provider.dart';
import 'package:frontend_alleck/services/api_client.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final ApiClient apiClient;

  UserRepository(this.apiClient);

  Future<http.Response> fetchUsers() async {
    final response = await apiClient.get('users');
    return response;
  }

  Future<http.Response> createUser(User user) async {
    final response = await apiClient.post('', );
    return response;
  }
}

final userRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return UserRepository(apiClient);
});