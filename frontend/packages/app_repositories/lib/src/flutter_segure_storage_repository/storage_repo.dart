abstract class IStorageRepository {
  Future<void> initializeStorage();

  Future<String?> get isLoggedIn;

  Future<void> setLogin({
    required String login,
    required String password,
  });

  Future<List<String?>> get login;
}
