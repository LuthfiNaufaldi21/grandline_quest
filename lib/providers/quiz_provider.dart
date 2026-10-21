import 'package:flutter/foundation.dart';

import '../core/constants/app_constants.dart';
import '../data/models/question.dart';
import '../data/question_bank.dart';

/// Menyimpan seluruh state kuis supaya progres tidak hilang
/// saat layar dirotasi maupun saat berpindah halaman.
class QuizProvider extends ChangeNotifier {
  String _playerName = '';
  List<Question> _questions = [];
  final Map<int, int> _answers = {}; // indeks soal -> indeks pilihan
  int _currentIndex = 0;
  bool _isFinished = false;

  // ---------- Getter ----------
  String get playerName => _playerName;
  List<Question> get questions => List.unmodifiable(_questions);
  int get total => _questions.length;
  int get currentIndex => _currentIndex;
  Question get currentQuestion => _questions[_currentIndex];
  int? get currentAnswer => _answers[_currentIndex];
  int get answeredCount => _answers.length;
  int get unansweredCount => total - answeredCount;

  bool get hasQuiz => _questions.isNotEmpty;
  bool get isFinished => _isFinished;
  bool get isInProgress => hasQuiz && !_isFinished;
  bool get isFirst => _currentIndex == 0;
  bool get isLast => _currentIndex == total - 1;
  bool get allAnswered => hasQuiz && answeredCount == total;

  int? answerOf(int index) => _answers[index];
  bool isAnswered(int index) => _answers.containsKey(index);
  bool isCorrect(int index) =>
      _answers[index] == _questions[index].correctIndex;

  int get score {
    var correct = 0;
    for (var i = 0; i < total; i++) {
      if (isCorrect(i)) correct++;
    }
    return correct;
  }

  int get wrongCount => answeredCount - score;
  int get percentage => total == 0 ? 0 : (score * 100 / total).round();
  int get bounty => score * AppConfig.bountyPerCorrect;

  // ---------- Aksi ----------
  void startQuiz(String name) {
    _playerName = name.trim();
    _questions = QuestionBank.pick(AppConfig.questionsPerRound);
    _answers.clear();
    _currentIndex = 0;
    _isFinished = false;
    notifyListeners();
  }

  void restart() => startQuiz(_playerName);

  void selectAnswer(int optionIndex) {
    _answers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  void next() {
    if (isLast) return;
    _currentIndex++;
    notifyListeners();
  }

  void previous() {
    if (isFirst) return;
    _currentIndex--;
    notifyListeners();
  }

  void goTo(int index) {
    if (index < 0 || index >= total) return;
    _currentIndex = index;
    notifyListeners();
  }

  void finish() {
    _isFinished = true;
    notifyListeners();
  }
}