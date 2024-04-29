
class UserModel {
  late String login;
  late String token;
  late Role role;
  UserModel({required this.login, required this.token, required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['user']['login'] ?? '',
      token: json['token'] ?? '',
      role: Role.fromJson(json['user']['role'])
    );
  }

}

enum Role {
  ADMIN,
  USER;

  static Role fromJson(String json) => values.byName(json);
}