import 'package:frontend_alleck/providers/api_client_provider.dart';
import 'package:frontend_alleck/services/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PollRepository {
  final ApiClient apiClient;

  PollRepository(this.apiClient);

  Future<List<dynamic>> fetchPolls() async {
    return await apiClient.get('polls');
  }

  Future<void> createPoll(Map<String, dynamic> pollData) async {
    await apiClient.post('polls', pollData);
  }
}

// Create a provider for PollRepository that uses ApiClient
final pollRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return PollRepository(apiClient);
});