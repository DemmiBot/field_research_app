import 'models/models.dart';

abstract class IUserRepository {
  Future<Map<String, dynamic>> signIn(
      {required String login, required String password});

  Future logOut();

  Future<String> signUp({required String login, required String password});

  Future resetPassword();

  Future<UserModel> getMyUser({required String userId});
}
