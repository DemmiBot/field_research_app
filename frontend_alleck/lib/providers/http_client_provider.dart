// lib/providers/http_client_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// Provide a single instance of http.Client throughout the app
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});
