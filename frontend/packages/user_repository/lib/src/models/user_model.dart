import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;

  const UserModel({required this.id, required this.email, required this.name});

  // Empty user witch represents an unauthenticaded user
  static const empty = UserModel(id: '', email: '', name: '');

  //modify userModel parameters
  UserModel copyWith({String? id, String? email, String? name}) {
    return UserModel(
        id: id ?? this.id, email: email ?? this.email, name: name ?? this.name);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user_id'] ?? '',
      name: json['username'] ?? '',
      email: json['login'] ?? '',
    );
  }

  // Convenience getter to determine whether the current user is empty
  bool get isEmpty => this == UserModel.empty;
  // Convenience getter to determine whether the current user is not empty
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [id, email, name];
}
