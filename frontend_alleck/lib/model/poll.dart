
/*
  Poll possui várias questões e várias entradas (forms preenchidos), e cada entrada possui várias respostas
*/

class Poll{
  const Poll({
    required this.poll_id,
    required this.name,
    required this.description,
    required this.status,
    required this.questions
  });

  final String poll_id;
  final String name;
  final String description;
  final Status status;
  final List<Question> questions;
}

enum Status {
  open,
  closed
}


class Question{
  const Question({required this.id, required this.label, required this.poll_id, required this.questionType, this.imageList});

  final String id;
  final String poll_id;
  final String label;
  final QuestionType questionType;
  final List<String>? imageList;
}

//Tipos aceitos
enum QuestionType {
  string,
  integer,
  boolean,
  images
}

// Entradas / Respostas da pesquisa
class Entry{
  Entry({required this.id, required this.answers, required this.poll_id});

  final String id;
  final String poll_id;
  final List<Answer> answers;
}

class Answer {
  const Answer({required this.id, required this.question_id, required this.value});

  final String id;
  final String question_id;
  final String value;
}
