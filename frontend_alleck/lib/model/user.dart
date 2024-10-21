
class User {
  final String email;
  final String username;
  final String password;
  final UserRole role;
  final bool enabled;

  User({required this.email, required this.enabled, required this.password, required this.role, required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(email: json['email'],
      enabled: json['enabled'], password: json['password'], role: json['role'], username: json['username']);
  }
}

enum UserRole {
  USER,
  ADMIN
}

    // public User(String email, String username, String password, UserRole role) {
    //     this.email = email;
    //     this.username = username;
    //     this.password = password;
    //     this.role = role;
    //     this.enabled = true;
    // }

  //     factory Question.fromJson(Map<String, dynamic> json) {
  //   String? enumString = json['listValues'];


  //   List<String>? enumList = enumString != null ? enumString.split(',').map((e) => e.trim()).toList() : null;

  //   return Question(
  //     label: json['label'],
  //     type: json['type'],
  //     listValues: enumList,
  //     min: json['min'],
  //     max: json['max'],
  //   );
  // }