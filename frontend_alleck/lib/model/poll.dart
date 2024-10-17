import 'dart:convert';

class Poll {
  final int pollId;
  final String title;
  final String description;
  final String status;
  final int entryCount;
  final List<Question> questions;

  Poll({
    required this.pollId,
    required this.title,
    required this.description,
    required this.status,
    required this.entryCount,
    required this.questions,
  });

  // Factory method to create a Poll from JSON
  factory Poll.fromJson(Map<String, dynamic> json) {
    // Decode the questions field (which is a string) into a List<Question>
    List<dynamic> questionsJson = jsonDecode(json['questions']);
    List<Question> questions = questionsJson.map((q) => Question.fromJson(q)).toList();

    return Poll(
      pollId: json['pollId'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      entryCount: json['entryCount'],
      questions: questions,
    );
  }
}

class Question {
  String text;
  String type;
  List<String>? enumValues;

  Question({
    required this.text,
    required this.type,
    this.enumValues
  });

  // Factory method to create a Question from JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'],
      type: json['type'],
    );
  }
}