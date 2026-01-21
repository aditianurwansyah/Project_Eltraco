// class Quiz {
//   final int id;
//   final String title;
//   final String description;
//   final List<Question> questions;

//   Quiz({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.questions,
//   });
// }

// class Question {
//   final String question;
//   final List<String> options;
//   final int answer; // 0 = A, 1 = B, dst

//   Question({
//     required this.question,
//     required this.options,
//     required this.answer,
//   });
// }
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

  // Untuk mengambil data dari Firestore
  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      questions: (map['questions'] as List)
          .map((q) => Question.fromMap(q))
          .toList(),
    );
  }

  // Untuk menyimpan data ke Firestore
  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'questions': questions.map((q) => q.toMap()).toList(),
  };
}

class Question {
  String question;
  List<String> options;
  int answer;

  Question({
    required this.question,
    required this.options,
    required this.answer,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['questionText'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      answer: map['answer'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
    'questionText': question,
    'options': options,
    'answer': answer,
  };
}
