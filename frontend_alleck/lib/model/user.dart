
class User {
  final String? email;
  final String? username;
  final String? password;
  final UserRole? role;
  final bool? enabled;

  User({this.email, this.enabled, this.password, this.role, this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(email: json['email'],
      enabled: json['enabled'], password: json['password'], role: UserRole.values.byName(json['role']), username: json['username']);
  }
}

enum UserRole {
  USER,
  ADMIN
}