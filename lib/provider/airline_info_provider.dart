import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirlineInfoState {
  final String from;
  final String to;
  final String airline;
  final String selectedClassOfTravel;
  final String? selectedSynchronize;
  final List<dynamic> dateRange;

  AirlineInfoState({
    this.from = '',
    this.to = '',
    this.airline = '',
    this.selectedClassOfTravel = '',
    this.selectedSynchronize = '',
    this.dateRange = const [],
  });

  AirlineInfoState copyWith({
    String? from,
    String? to,
    String? airline,
    String? selectedClassOfTravel,
    String? selectedSynchronize,
    List<dynamic>? dateRange,
  }) {
    return AirlineInfoState(
      from: from ?? this.from,
      to: to ?? this.to,
      airline: airline ?? this.airline,
      selectedClassOfTravel:
          selectedClassOfTravel ?? this.selectedClassOfTravel,
      selectedSynchronize: selectedSynchronize ?? this.selectedSynchronize,
      dateRange: dateRange ?? this.dateRange,
    );
  }

  bool isValid() {
    return from.isNotEmpty &&
        to.isNotEmpty &&
        airline.isNotEmpty &&
        selectedClassOfTravel.isNotEmpty &&
        selectedSynchronize != null &&
        selectedSynchronize!.isNotEmpty &&
        dateRange.isNotEmpty;
  }
}

class AirlineInfoNorifier extends StateNotifier<AirlineInfoState> {
  AirlineInfoNorifier() : super(AirlineInfoState());

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

  void updateDateRange(List<dynamic> value) {
    state = state.copyWith(dateRange: value);
  }

  bool isFormValid() {
    return state.isValid();
  }
}

// Provider for the AirlineInfoNorifier
final airlineInfoProvider =
    StateNotifierProvider<AirlineInfoNorifier, AirlineInfoState>((ref) {
  return AirlineInfoNorifier();
});
