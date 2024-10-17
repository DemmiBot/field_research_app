import 'package:http/http.dart' as http;

class UserRepository {
  final String baseUrl = 'http://10.0.2.2:8080/users';

  Future<http.Response> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    return response;
  }

  Future<http.Response> createUser(String name) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: '{"name": "$name"}',
    );
    return response;
  }
}
