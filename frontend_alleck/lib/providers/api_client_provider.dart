import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_alleck/providers/http_client_provider.dart';
import '../services/api_client.dart';

// Create a provider for the ApiClient
final apiClientProvider = Provider<ApiClient>((ref) {
  final client = ref.watch(httpClientProvider);
  return ApiClient(baseUrl: 'http://10.0.2.2:8080', client: client);
});
