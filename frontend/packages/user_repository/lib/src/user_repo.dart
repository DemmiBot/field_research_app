import 'models/models.dart';

abstract class IUserRepository {
  Future<String> signIn({required String login, required String password});

  Future logOut();

  Future<String> signUp({required String login, required String password});

  Future resetPassword();

  Future<UserModel> getMyUser();
}
