import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_alleck/repository/poll_repository.dart';

final pollDataProvider = FutureProvider((ref) async {
  final pollRepository = ref.watch(pollRepositoryProvider);
  return await pollRepository.fetchPolls();
});