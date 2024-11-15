import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlightInputState {
  final String from;
  final String to;
  final String airline;
  final String selectedClassOfTravel;
  final String? selectedSynchronize;

  FlightInputState({
    this.from = '',
    this.to = '',
    this.airline = '',
    this.selectedClassOfTravel = '',
    this.selectedSynchronize,
  });

  FlightInputState copyWith({
    String? from,
    String? to,
    String? airline,
    String? selectedClassOfTravel,
    String? selectedSynchronize,
  }) {
    return FlightInputState(
      from: from ?? this.from,
      to: to ?? this.to,
      airline: airline ?? this.airline,
      selectedClassOfTravel:
          selectedClassOfTravel ?? this.selectedClassOfTravel,
      selectedSynchronize: selectedSynchronize ?? this.selectedSynchronize,
    );
  }
}

class FlightInputNotifier extends StateNotifier<FlightInputState> {
  FlightInputNotifier() : super(FlightInputState());

  void updateFrom(String value) {
    state = state.copyWith(from: value);
  }

  void updateTo(String value) {
    state = state.copyWith(to: value);
  }

  void updateAirline(String value) {
    state = state.copyWith(airline: value);
  }

  void updateClassOfTravel(String value) {
    state = state.copyWith(selectedClassOfTravel: value);
  }

  void updateSynchronize(String value) {
    state = state.copyWith(selectedSynchronize: value);
  }
}

// Provider for the FlightInputNotifier
final flightInputProvider =
    StateNotifierProvider<FlightInputNotifier, FlightInputState>((ref) {
  return FlightInputNotifier();
});
