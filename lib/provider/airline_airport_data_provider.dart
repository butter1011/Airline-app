import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirlineAirportState {
  final List<dynamic> airlineData;
  final List<dynamic> airportData;

  AirlineAirportState({
    this.airlineData = const [],
    this.airportData = const [],
  });

  AirlineAirportState copyWith({
    List<dynamic>? airlineData,
    List<dynamic>? airportData,
    bool? isLoading,
  }) {
    return AirlineAirportState(
      airlineData: airlineData ?? this.airlineData,
      airportData: airportData ?? this.airportData,
    );
  }
}

class AirlineAirportNotifier extends StateNotifier<AirlineAirportState> {
  AirlineAirportNotifier() : super(AirlineAirportState());

  void setData(Map<String, dynamic> value) {
    final allData = value["data"]["data"] as List;

    state = state.copyWith(
      airlineData:
          allData.where((element) => element['isAirline'] == true).toList(),
      airportData:
          allData.where((element) => element['isAirline'] == false).toList(),
    );
  }

  String getAirportId(String airportName) {
    final airportData = state.airportData;
    final airport = airportData.firstWhere(
      (airport) => airport['name'] == airportName,
      orElse: () => null,
    );
    return airport?['_id'] ?? '';
  }

  String getAirlineId(String airlineName) {
    final airlineData = state.airlineData;
    final airport = airlineData.firstWhere(
      (airport) => airport['name'] == airlineName,
      orElse: () => null,
    );
    return airport?['_id'] ?? '';
  }
}

final airlineAirportProvider =
    StateNotifierProvider<AirlineAirportNotifier, AirlineAirportState>((ref) {
  return AirlineAirportNotifier();
});
