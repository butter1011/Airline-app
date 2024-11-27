import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/boarding_pass.dart';

final boardingPassesProvider =
    StateNotifierProvider<BoardingPassesNotifier, List<BoardingPass>>((ref) {
  return BoardingPassesNotifier();
});

class BoardingPassesNotifier extends StateNotifier<List<BoardingPass>> {
  BoardingPassesNotifier() : super([]);

  void setData(List<BoardingPass> boardingPasses) {
    state = boardingPasses;
  }

  // void addBoardingPass(BoardingPass pass) {
  //   state = [...state, pass];
  // }

  BoardingPass markFlightAsReviewed(int index) {
    final updatedPass = state[index].copyWith(isFlightReviewed: true);
    print("🏅🏅🏅Updated pass: ${updatedPass.toJson()}");
    state = [
      ...state.sublist(0, index),
      updatedPass,
      ...state.sublist(index + 1)
    ];
    return state[index];
  }

  void markAirportAsReviewed(int index, bool isDeparture) {
    final updatedPass = isDeparture
        ? state[index].copyWith(isDepartureAirportReviewed: true)
        : state[index].copyWith(isArrivalAirportReviewed: true);

    state = [
      ...state.sublist(0, index),
      updatedPass,
      ...state.sublist(index + 1)
    ];
  }

  bool hasFlightNumber(String flightNumber) {
    return state.any((pass) => pass.flightNumber == flightNumber);
  }
}
