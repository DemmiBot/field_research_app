import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? adm;
  const UserModel(
      {required this.id, required this.email, required this.name, this.adm});

  // Empty user witch represents an unauthenticaded user
  static const empty = UserModel(id: '', email: '', name: '', adm: '');

  //modify userModel parameters
  UserModel copyWith({String? id, String? email, String? name, String? adm}) {
    return UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        adm: adm ?? this.adm);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['user_id'] ?? '',
        name: json['username'] ?? '',
        email: json['login'] ?? '',
        adm: json['role'] ?? '');
  }

  // Convenience getter to determine whether the current user is empty
  bool get isEmpty => this == UserModel.empty;
  // Convenience getter to determine whether the current user is not empty
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [id, email, name, adm];
}
