// lib/providers/user_data_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:frontend_alleck/providers/user_provider.dart';

// Create a FutureProvider to fetch user data
final userDataProvider = FutureProvider((ref) async {
  final userRepository = ref.watch(userRepositoryProvider);
  final response = await userRepository.fetchUsers();

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load users');
  }
});
