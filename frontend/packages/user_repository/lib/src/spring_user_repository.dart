import 'dart:convert';
import 'dart:developer';
import 'package:app_client/app_client.dart';
import 'package:dartz/dartz.dart';
import 'package:user_repository/src/models/user_model.dart';
import 'user_repo.dart';

class SpringUserRepository implements IUserRepository {
  SpringUserRepository({required this.client});

  final IClientHttp client;

  @override
  Future<Either<Failure, UserModel>> getMyUser({required String userId}) async {
    try {
      final response =
          await client.get(url: '${SpringConection.adressIP}/users/$userId');
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(UserModel.fromJson(jsonData));
      } else {
        return const Left(Failure(message: ''));
      }
    } catch (e) {
      return const Left(Failure(message: ''));
    }
  }

  @override
  Future logOut() {
    throw UnimplementedError();
  }

  @override
  Future resetPassword() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signIn(
      {required String login, required String password}) async {
    final body = jsonEncode({
      'email': login,
      'password': password,
    });
    try {
      final response = await client.post(
          url: '${SpringConection.adressIP}/auth/login', body: body);

      log(response.body.toString());

      Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        UserModel user = UserModel.empty;

        return Right(
          user.copyWith(
            id: jsonData['user']['user_id'],
            adm: jsonData['user']['role'],
            name: jsonData['user']['username'],
            email: jsonData['user']['email'],
          ),
        );
      } else {
        return Left(Failure(message: jsonData['error']));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    final body = jsonEncode(
      {
        'email': email,
        'username': username,
        'password': password,
        'role': "ADMIN",
      },
    );
    try {
      final response = await client.post(
          url: '${SpringConection.adressIP}/auth/register', body: body);
      Map<String, dynamic> jsonData = {};

      if (response.body == '') {
        return const Right('Cadastro realizado com sucesso');
      } else {
        if (response != null && response.body.isNotEmpty) {
          jsonData = jsonDecode(response.body);
          return Left(Failure(message: jsonData['error']));
        } else {
          return const Left(Failure(message: 'Erro ao cadastrar usuário'));
        }
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> fetchUsers() async {
    try {
      final response =
          await client.get(url: '${SpringConection.adressIP}/users');

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> jsonData = jsonDecode(response.body);
        List<UserModel> users = jsonData.map((e) {
          return UserModel.fromJson(e);
        }).toList();
        return Right(users);
      } else {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        return Left(Failure(message: jsonData['error']));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteUser({required String userId}) async {
    try {
      final response =
          await client.delete(url: '${SpringConection.adressIP}/users/$userId');
      if (response.statusCode == 200) {
        return Right(response.body);
      } else {
        return Left(Failure(message: response.body));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
