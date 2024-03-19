class ResearchesModel {
  late String pollId;
  late String name;
  late String description;
  late String status;

  ResearchesModel({
    required this.pollId,
    required this.name,
    required this.description,
    required this.status,
  });

  factory ResearchesModel.fromJson(Map<String, dynamic> json) {
    return ResearchesModel(
      pollId: json['poll_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
