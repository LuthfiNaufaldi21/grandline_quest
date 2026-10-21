import 'dart:math';

/// Model satu soal pilihan ganda.
class Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const Question({
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  String get correctAnswer => options[correctIndex];

  /// Salinan soal dengan urutan pilihan diacak (indeks jawaban benar ikut disesuaikan).
  Question withShuffledOptions(Random random) {
    final order = List<int>.generate(options.length, (i) => i)..shuffle(random);
    return Question(
      text: text,
      options: [for (final i in order) options[i]],
      correctIndex: order.indexOf(correctIndex),
      explanation: explanation,
    );
  }
}