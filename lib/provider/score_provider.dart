import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreNotifier extends StateNotifier<double?> {
  ScoreNotifier() : super(null);

  void updateScore(dynamic newScore) {
    if (newScore != null) {
      state = double.parse(newScore.toString());
    }
  }
}

final scoreProvider = StateNotifierProvider<ScoreNotifier, double?>((ref) {
  return ScoreNotifier();
});
