abstract class IBiometricRepository {
  Future<void> authenticate(Function function);

  Future<bool> isBiometricAvailable();
}
