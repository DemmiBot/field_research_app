import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_client.dart';

// Create a provider for the ApiClient
final apiClientProvider = Provider((ref) => ApiClient(baseUrl: 'http://10.0.2.2:8080'));