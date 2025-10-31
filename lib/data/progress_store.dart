// lib/data/progress_store.dart (or progress.dart)
import 'package:shared_preferences/shared_preferences.dart';

// Data class to hold progress info
class ProgressData {
  final int quizzesTaken;
  final int bestScore;
  final int bestScoreOutOf;
  final bool soundOn;
  final String playerName; // NEW

  const ProgressData({
    required this.quizzesTaken,
    required this.bestScore,
    required this.bestScoreOutOf,
    required this.soundOn,
    required this.playerName, // NEW
  });
}

// Store for reading/writing progress info
class ProgressStore {
  static const _kQuizzesTaken = 'quizzes_taken';
  static const _kBestScore = 'best_score';
  static const _kBestOutOf = 'best_out_of';
  static const _kSoundOn = 'sound_on';
  static const _kPlayerName = 'player_name'; // NEW

  static Future<SharedPreferences> _prefs() async =>
      await SharedPreferences.getInstance();

  static Future<ProgressData> read() async {
    final p = await _prefs();
    return ProgressData(
      quizzesTaken: p.getInt(_kQuizzesTaken) ?? 0,
      bestScore: p.getInt(_kBestScore) ?? 0,
      bestScoreOutOf: p.getInt(_kBestOutOf) ?? 0,
      soundOn: p.getBool(_kSoundOn) ?? true,
      playerName: p.getString(_kPlayerName) ?? 'Player', // NEW default
    );
  }

  // Record a quiz run, updating quizzes taken and best score 
  static Future<void> recordQuizRun({required int score, required int total}) async {
    final p = await _prefs();
    final taken = (p.getInt(_kQuizzesTaken) ?? 0) + 1;
    final best = p.getInt(_kBestScore) ?? 0;
    final bestOut = p.getInt(_kBestOutOf) ?? 0;

    final oldPct = bestOut == 0 ? 0.0 : best / bestOut;
    final newPct = total == 0 ? 0.0 : score / total;
    final isBetter = newPct > oldPct || (newPct == oldPct && score > best);

    await p.setInt(_kQuizzesTaken, taken);
    if (isBetter) {
      await p.setInt(_kBestScore, score);
      await p.setInt(_kBestOutOf, total);
    }
  }

  // Sound setting
  static Future<void> setSound(bool value) async {
    final p = await _prefs();
    await p.setBool(_kSoundOn, value);
  }

  // NEW: save player name
  static Future<void> setPlayerName(String name) async {
    final p = await _prefs();
    await p.setString(_kPlayerName, name);
  }

  // Reset all progress (keeps player name)
  static Future<void> reset() async {
    final p = await _prefs();
    await p.remove(_kQuizzesTaken);
    await p.remove(_kBestScore);
    await p.remove(_kBestOutOf);
    await p.remove(_kSoundOn);
    // intentionally NOT removing _kPlayerName
  }
}
