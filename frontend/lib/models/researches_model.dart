class ResearchesModel {
  String id;
  late String name;
  late String description;
  late String createdAt;
  late String status;

  ResearchesModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  factory ResearchesModel.fromJson(Map<String, dynamic> json) {
    return ResearchesModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
