import 'package:equatable/equatable.dart';

class ResearchModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String status;

  const ResearchModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
  });

  /// Empty user witch represents an unauthenticaded user
  static const empty = ResearchModel(
    id: '',
    name: '',
    description: '',
    status: '',
  );

  factory ResearchModel.fromJson(Map<String, dynamic> json) {
    return ResearchModel(
      id: json['poll_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
    );
  }

  //modify userModel parameters
  ResearchModel copyWith({
    String? id,
    String? name,
    String? description,
    String? status,
  }) {
    return ResearchModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [id, name, description, status];
}
