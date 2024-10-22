import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_alleck/providers/http_client_provider.dart';
import '../services/api_client.dart';
import 'authentication_provider.dart'; // Import the token provider

// Create a provider for the ApiClient
final apiClientProvider = Provider<ApiClient>((ref) {
  final client = ref.watch(httpClientProvider);
  final token = ref.watch(tokenNotifierProvider); // Watch the token from TokenNotifier
  return ApiClient(baseUrl: 'http://10.0.2.2:8080', client: client, token: token);
});
