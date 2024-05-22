import 'package:app_repositories/src/biometric_repository/biometric_repo.dart';
import 'package:app_repositories/src/flutter_segure_storage_repository/storage_repo.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class BiometricRepository implements IBiometricRepository {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  bool isAuthenticated = false;

  final IStorageRepository _storage;

  BiometricRepository({
    required IStorageRepository storage,
  }) : _storage = storage;

  @override
  Future<void> authenticate(Function function) async {
    if (await isBiometricAvailable() && await _storage.isLoggedIn == 'true') {
      isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: ' ',
        options: const AuthenticationOptions(stickyAuth: true),
        authMessages: <AuthMessages>[
          const AndroidAuthMessages(
            signInTitle: 'SurveyApp ',
            biometricHint: 'Desbloqueie seu celular',
          ),
        ],
      );
      if (isAuthenticated) {
        function();
      }
    }
  }

  @override
  Future<bool> isBiometricAvailable() async {
    try {
      bool isAvaliable = await _localAuthentication.canCheckBiometrics;
      return isAvaliable;
    } catch (e) {
      return false;
    }
  }
}
