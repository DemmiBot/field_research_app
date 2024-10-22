import 'package:flutter_riverpod/flutter_riverpod.dart';

// Token Notifier
class TokenNotifier extends StateNotifier<String?> {
  TokenNotifier() : super(null);

  void setToken(String token) {
    state = token;
  }

  void clearToken() {
    state = null;
  }
}

// Provider for TokenNotifier
final tokenNotifierProvider = StateNotifierProvider<TokenNotifier, String?>((ref) {
  return TokenNotifier();
});
