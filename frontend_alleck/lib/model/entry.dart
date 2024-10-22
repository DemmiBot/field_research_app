

class Entry {
  final int pollId;
  final List<String> responses;

  Entry({required this.pollId, required this.responses});

  // Factory method to create an Entry from JSON
  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      pollId: json['pollId'],
      responses: List<String>.from(json['responses']),
    );
  }

  // Method to convert Entry to JSON
  Map<String, dynamic> toJson() {
    return {
      'pollId': pollId,
      'responses': responses,
    };
  }
}
