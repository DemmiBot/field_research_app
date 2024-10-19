import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client client;

  ApiClient({required this.baseUrl, required this.client});

  Future<dynamic> get(String endpoint) async {
    final response = await client.get(Uri.parse('$baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // Posso utilizar isso para lidar com a segurança do Oauth JWT
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await client.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await client.delete(Uri.parse('$baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // Common function to handle response and errors
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      
      return response.body;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}