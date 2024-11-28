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
    final allData = value["data"] as List;

    state = state.copyWith(
      airlineData:
          allData.where((element) => element['isAirline'] == true).toList(),
      airportData:
          allData.where((element) => element['isAirline'] == false).toList(),
    );
  }

  Map getAirportData(String airportCode) {
    final airportData = state.airportData;
    final airport = airportData.firstWhere(
      (airport) => airport['iataCode'] == airportCode,
      orElse: () => null,
    );
    return airport ?? {};
  }

  Map getAirlineData(String airlineCode) {
    final airlineData = state.airlineData;
    final airline = airlineData.firstWhere(
      (airline) => airline['iataCode'] == airlineCode,
      orElse: () => null,
    );
    return airline ?? {};
  }

  List getAirlineDataSortedByCleanliness(List airlineScoreData) {
    final airlineData = state.airlineData;
    final airlineDataSortedByCleanliness = airlineData.map((item) {
      final cleanlinessScore = airlineScoreData.firstWhere(
        (score) => score['airlineId'] == item['_id'],
        orElse: () => {'cleanliness': 5},
      )['cleanliness'];
      return {
        ...item,
        'cleanliness': cleanlinessScore,
      };
    }).toList();
    airlineDataSortedByCleanliness
        .sort((a, b) => b['cleanliness'].compareTo(a['cleanliness']));
    return airlineDataSortedByCleanliness;
  }

  List getAirlineDataSortedByOnboardSevice(List airlineScoreData) {
    final airlineData = state.airlineData;
    final airlineDataSortedByOnboardService = airlineData.map((item) {
      final onboardServiceScore = airlineScoreData.firstWhere(
        (score) => score['airlineId'] == item['_id'],
        orElse: () => {'onboardService': 5},
      )['onboardService'];
      return {
        ...item,
        'onboardService': onboardServiceScore,
      };
    }).toList();
    airlineDataSortedByOnboardService
        .sort((a, b) => b['onboardService'].compareTo(a['onboardService']));
    print(
        "This is airlineData sorted by OnboardService🎁🎁=====>${airlineDataSortedByOnboardService.map((item) => item['onboardService'])}");
    return airlineDataSortedByOnboardService;
  }
}

final airlineAirportProvider =
    StateNotifierProvider<AirlineAirportNotifier, AirlineAirportState>((ref) {
  return AirlineAirportNotifier();
});
