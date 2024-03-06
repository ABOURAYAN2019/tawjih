class QuestionModel {
  final String question;
  final List<Choice> choices;
  final String niveau;

  const QuestionModel({
    required this.question,
    required this.choices,
    required this.niveau,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'] as String,
      choices: (json['choix'] as List)
          .map((choice) => Choice.fromJson(choice))
          .toList(),
      niveau: json['niveau'] as String,
    );
  }
}

class Choice {
  final String texte;
  final bool correcte;

  const Choice({
    required this.texte,
    required this.correcte,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      texte: json['texte'] as String,
      correcte: json['correcte'] as bool,
    );
  }
}
