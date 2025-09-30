import '../models/quiz_question.dart';
import '../data/progress_store.dart';

class QuizPresenter {
  final List<QuizQuestion> questions;

  int current = 0;
  int score = 0;
  int? selectedIndex;

  QuizPresenter(this.questions);

  QuizQuestion get currentQuestion => questions[current];
  int get total => questions.length;
  bool get hasSelected => selectedIndex != null;

  void selectAnswer(int index) {
    selectedIndex = index;
  }

  void commitAnswer() {
    final i = selectedIndex;
    if (i == null) return;
    if (currentQuestion.correctIndex == i) {
      score++;
    }
  }

  bool nextQuestion() {
    if (current < questions.length - 1) {
      current++;
      selectedIndex = null;
      return true;
    }
    return false;
  }

  Future<void> saveProgress() async {
    await ProgressStore.recordQuizRun(score: score, total: total);
  }
}
