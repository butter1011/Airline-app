import 'package:flutter_riverpod/flutter_riverpod.dart';

class AviationInfoState {
  final String from;
  final String to;
  final String airline;
  final String airport;
  final String selectedClassOfTravel;
  final String? selectedSynchronize;
  final List<dynamic> dateRange;

  AviationInfoState({
    this.from = '',
    this.to = '',
    this.airline = '',
    this.airport = '',
    this.selectedClassOfTravel = '',
    this.selectedSynchronize = '',
    this.dateRange = const [],
  });

  AviationInfoState copyWith({
    String? from,
    String? to,
    String? airline,
    String? airport,
    String? selectedClassOfTravel,
    String? selectedSynchronize,
    List<dynamic>? dateRange,
  }) {
    return AviationInfoState(
      from: from ?? this.from,
      to: to ?? this.to,
      airline: airline ?? this.airline,
      airport: airport ?? this.airport,
      selectedClassOfTravel:
          selectedClassOfTravel ?? this.selectedClassOfTravel,
      selectedSynchronize: selectedSynchronize ?? this.selectedSynchronize,
      dateRange: dateRange ?? this.dateRange,
    );
  }

  bool isValidForAirline() {
    return from.isNotEmpty &&
        to.isNotEmpty &&
        airline.isNotEmpty &&
        selectedClassOfTravel.isNotEmpty &&
        selectedSynchronize != null &&
        selectedSynchronize!.isNotEmpty &&
        dateRange.isNotEmpty;
  }

  bool isValidForAirport() {
    return airline.isNotEmpty &&
        airport.isNotEmpty &&
        selectedClassOfTravel.isNotEmpty &&
        selectedSynchronize != null &&
        selectedSynchronize!.isNotEmpty &&
        dateRange.isNotEmpty;
  }
}

class AirlineInfoNorifier extends StateNotifier<AviationInfoState> {
  AirlineInfoNorifier() : super(AviationInfoState());

  void updateFrom(String value) {
    state = state.copyWith(from: value);
  }

  void updateTo(String value) {
    state = state.copyWith(to: value);
  }

  void updateAirline(String value) {
    state = state.copyWith(airline: value);
  }

  void updateAirport(String value) {
    state = state.copyWith(airport: value);
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

  void resetState() {
    state = AviationInfoState();
  }

  bool isAirlineValid() {
    return state.isValidForAirline();
  }

  bool isAirportValid() {
    return state.isValidForAirport();
  }
}

// Provider for the AirlineInfoNorifier
final aviationInfoProvider =
    StateNotifierProvider<AirlineInfoNorifier, AviationInfoState>((ref) {
  return AirlineInfoNorifier();
});
