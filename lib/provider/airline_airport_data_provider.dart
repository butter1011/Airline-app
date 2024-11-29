import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sealed_countries/sealed_countries.dart';

class AirlineAirportState {
  final List<Map<String, dynamic>> airlineData;
  final List<Map<String, dynamic>> airportData;
  final List<Map<String, dynamic>> airlineScoreData;
  final List<Map<String, dynamic>> filteredList;

  const AirlineAirportState({
    this.airlineData = const [],
    this.airportData = const [],
    this.airlineScoreData = const [],
    this.filteredList = const [],
  });

  AirlineAirportState copyWith({
    List<Map<String, dynamic>>? airlineData,
    List<Map<String, dynamic>>? airportData,
    List<Map<String, dynamic>>? airlineScoreData,
    List<Map<String, dynamic>>? filteredList,
    bool? isLoading,
  }) {
    return AirlineAirportState(
      airlineData: airlineData ?? this.airlineData,
      airportData: airportData ?? this.airportData,
      airlineScoreData: airlineScoreData ?? this.airlineScoreData,
      filteredList: filteredList ?? this.filteredList,
    );
  }
}

class AirlineAirportNotifier extends StateNotifier<AirlineAirportState> {
  AirlineAirportNotifier() : super(const AirlineAirportState());

  void setData(Map<String, dynamic> value) {
    final allData = List<Map<String, dynamic>>.from(value["data"] as List);
    final airlineData = <Map<String, dynamic>>[];
    final airportData = <Map<String, dynamic>>[];
    for (final element in allData) {
      if (element['isAirline'] == true) {
        airlineData.add(element);
      } else {
        airportData.add(element);
      }
    }

    state = state.copyWith(
      airlineData: airlineData,
      airportData: airportData,
    );
  }

  void setAirlineScoreData(List<dynamic> value) {
    state = state.copyWith(
      airlineScoreData: List<Map<String, dynamic>>.from(value),
    );
  }

  Map<String, dynamic> getAirportData(String airportCode) {
    return state.airportData.firstWhere(
      (airport) => airport['iataCode'] == airportCode,
      orElse: () => const <String, dynamic>{},
    );
  }

  Map<String, dynamic> getAirlineData(String airlineCode) {
    return state.airlineData.firstWhere(
      (airline) => airline['iataCode'] == airlineCode,
      orElse: () => const <String, dynamic>{},
    );
  }

  List<Map<String, dynamic>> getAirlineDataSortedByCleanliness() {
    final airlineScoreData = state.airlineScoreData;
    final airlineData = state.airlineData;
    final Map<String, dynamic> scoreMap = {
      for (var score in airlineScoreData)
        score['airlineId']: score['cleanliness']
    };

    final result = airlineData.map((item) {
      return {
        ...item,
        'cleanliness': scoreMap[item['_id']] ?? 5,
      };
    }).toList();

    result.sort((a, b) => b['cleanliness'].compareTo(a['cleanliness']));
    return result;
  }

  List<Map<String, dynamic>> getAirlineDataSortedByOnboardSevice() {
    final airlineScoreData = state.airlineScoreData;
    final airlineData = state.airlineData;
    final Map<String, dynamic> scoreMap = {
      for (var score in airlineScoreData)
        score['airlineId']: score['onboardService']
    };

    final result = airlineData.map((item) {
      return {
        ...item,
        'onboardService': scoreMap[item['_id']] ?? 5,
      };
    }).toList();

    result.sort((a, b) => b['onboardService'].compareTo(a['onboardService']));
    return result;
  }

  void getFilteredList(String filterType, String? searchQuery, [List<String>? selectedContinents]) {
    final airlineData = state.airlineData;
    final airportData = state.airportData;
    List<Map<String, dynamic>> filteredList = [];

    bool checkContinent(Map<String, dynamic> item) {
      if (selectedContinents == null || selectedContinents.isEmpty) return true;
      final continent = WorldCountry.fromCodeShort(item['countryCode']).continent.name;
      return selectedContinents.contains(continent);
    }

    // First apply category filter
    switch (filterType) {
      case 'All':
        filteredList.addAll(airlineData.where(checkContinent));
        filteredList.addAll(airportData.where(checkContinent));
        break;
      case 'Airline':
        filteredList.addAll(airlineData.where(checkContinent));
        break;
      case 'Airport':
        filteredList.addAll(airportData.where(checkContinent));
        break;
      case 'Cleanliness':
        filteredList.addAll(getAirlineDataSortedByCleanliness().where(checkContinent));
        break;
      case 'Onboard':
        filteredList.addAll(getAirlineDataSortedByOnboardSevice().where(checkContinent));
        break;
      default:
        filteredList.addAll(airlineData.where(checkContinent));
        filteredList.addAll(airportData.where(checkContinent));
    }

    // Then apply search filter if query exists
    if (searchQuery != null && searchQuery.isNotEmpty) {
      filteredList = filteredList.where((item) {
        final name = item['name'].toString().toLowerCase();
        final perksBio = item['perksBio'].toString().toLowerCase();
        final trendingBio = item['trendingBio'].toString().toLowerCase();
        final query = searchQuery.toLowerCase();
        
        return name.contains(query) || 
               perksBio.contains(query) || 
               trendingBio.contains(query);
      }).toList();
    }

    state = state.copyWith(filteredList: filteredList);
  }}

final airlineAirportProvider =
    StateNotifierProvider<AirlineAirportNotifier, AirlineAirportState>((ref) {
  return AirlineAirportNotifier();
});
