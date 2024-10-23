import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_alleck/model/user.dart';

// Token Notifier
class TokenNotifier extends StateNotifier<String?> {
  TokenNotifier() : super(null);

  void setToken(String token) {
    state = token;
    print(token);
  }

  void clearToken() {
    state = null;
  }
}

// Provider for TokenNotifier
final tokenNotifierProvider = StateNotifierProvider<TokenNotifier, String?>((ref) {
  return TokenNotifier();
});

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void setUser(User user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}

// Provider for UserNotifier
final userNotifierProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});