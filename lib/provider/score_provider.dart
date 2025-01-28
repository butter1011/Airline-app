import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreNotifier extends StateNotifier<Map<String, double?>> {
  ScoreNotifier() : super({'airlineScore': null, 'airportScore': null});

  void updateAirlineScore(dynamic newScore) {
    if (newScore != null) {
      state = {...state, 'airlineScore': double.parse(newScore.toString())};
    }
  }

  void updateAirportScore(dynamic newScore) {
    if (newScore != null) {
      state = {...state, 'airportScore': double.parse(newScore.toString())};
    }
  }
}

final scoreProvider = StateNotifierProvider<ScoreNotifier, Map<String, double?>>((ref) {
  return ScoreNotifier();
});