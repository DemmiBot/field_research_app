class UserAdmModel {
  late String name;
  late String email;
  late String adm;
  int index;
  UserAdmModel(
      {required this.name,
      required this.email,
      required this.adm,
      required this.index});

  factory UserAdmModel.fromJson(Map<String, dynamic> json, int index) {
    return UserAdmModel(
      name: json['login'] ?? '',
      email: json['email'] ?? '',
      adm: json['role'] ?? '',
      index: index,
    );
  }
}

class UserModel {
  late String username;
  late String adm;
  UserModel({required this.username, required this.adm});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['user']['username'] ?? '',
      adm: json['user']['role'] ?? '',
    );
  }
}
