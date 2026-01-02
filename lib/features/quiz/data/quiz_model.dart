class Quiz {
  final int id;
  final String title;
  final String description;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });
}

class Question {
  final String question;
  final List<String> options;
  final int answer; // 0 = A, 1 = B, dst

  Question({
    required this.question,
    required this.options,
    required this.answer,
  });
}
