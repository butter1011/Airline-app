import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/boarding_pass.dart';

final boardingPassesProvider =
    StateNotifierProvider<BoardingPassesNotifier, List<BoardingPass>>((ref) {
  return BoardingPassesNotifier();
});

class BoardingPassesNotifier extends StateNotifier<List<BoardingPass>> {
  BoardingPassesNotifier() : super([]);

  void addBoardingPass(BoardingPass pass) {
    state = [...state, pass];
  }

  void removeBoardingPass(int index) {
    state = [...state]..removeAt(index);
  }
}
