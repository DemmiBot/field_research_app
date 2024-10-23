import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client client;
  final String? token; // Optional bearer token

  ApiClient({required this.baseUrl, required this.client, this.token});

  Future<dynamic> get(String endpoint) async {
    final response = await client.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: _buildHeaders(),
    );
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await client.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: _buildHeaders(contentType: true),
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  Future<dynamic> postWithoutToken(String endpoint, Map<String, dynamic> data) async {
    final response = await client.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/$endpoint'),
      headers: _buildHeaders(),
    );
    return _handleResponse(response);
  }

  // Build headers and include Authorization if token is provided
  Map<String, String> _buildHeaders({bool contentType = false}) {
    final headers = <String, String>{};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    if (contentType) {
      headers['Content-Type'] = 'application/json; charset=utf-8';
    }
    return headers;
  }

  // Handle response and errors
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
