class UserAdmModel {
  late String name = 'User';
  late String email;
  late bool adm;
  UserAdmModel({required this.name, required this.email, required this.adm});

  factory UserAdmModel.fromJson(Map<String, dynamic> json) {
    return UserAdmModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      adm: json['is_admin'] ?? '',
    );
  }
}

class UserModel {
  late String name = 'User';
  late String email;
  UserModel({required this.name, required this.email});
}
