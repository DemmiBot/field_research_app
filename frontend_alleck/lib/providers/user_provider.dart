// lib/providers/user_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/user_repository.dart';

// Create a provider for the UserRepository
final userRepositoryProvider = Provider((ref) => UserRepository());