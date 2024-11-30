import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sealed_countries/sealed_countries.dart';

class AirlineAirportState {
  final List<Map<String, dynamic>> airlineData;
  final List<Map<String, dynamic>> airportData;
  final List<Map<String, dynamic>> airlineScoreData;
  final List<Map<String, dynamic>> filteredList;
  final Map<String, Map<String, dynamic>> airportCache;
  final Map<String, Map<String, dynamic>> airlineCache;

  const AirlineAirportState({
    this.airlineData = const [],
    this.airportData = const [],
    this.airlineScoreData = const [],
    this.filteredList = const [],
    this.airportCache = const {},
    this.airlineCache = const {},
  });

  AirlineAirportState copyWith({
    List<Map<String, dynamic>>? airlineData,
    List<Map<String, dynamic>>? airportData,
    List<Map<String, dynamic>>? airlineScoreData,
    List<Map<String, dynamic>>? filteredList,
    Map<String, Map<String, dynamic>>? airportCache,
    Map<String, Map<String, dynamic>>? airlineCache,
    bool? isLoading,
  }) {
    return AirlineAirportState(
      airlineData: airlineData ?? this.airlineData,
      airportData: airportData ?? this.airportData,
      airlineScoreData: airlineScoreData ?? this.airlineScoreData,
      filteredList: filteredList ?? this.filteredList,
      airportCache: airportCache ?? this.airportCache,
      airlineCache: airlineCache ?? this.airlineCache,
    );
  }
}

class AirlineAirportNotifier extends StateNotifier<AirlineAirportState> {
  AirlineAirportNotifier() : super(const AirlineAirportState());

  void setData(Map<String, dynamic> value) {
    final allData = List<Map<String, dynamic>>.from(value["data"] as List);
    final airlineData = <Map<String, dynamic>>[];
    final airportData = <Map<String, dynamic>>[];
    final airlineCache = <String, Map<String, dynamic>>{};
    final airportCache = <String, Map<String, dynamic>>{};

    for (final element in allData) {
      if (element['isAirline'] == true) {
        airlineData.add(element);
        airlineCache[element['iataCode']] = element;
      } else {
        airportData.add(element);
        airportCache[element['iataCode']] = element;
      }
    }

    state = state.copyWith(
      airlineData: airlineData,
      airportData: airportData,
      airlineCache: airlineCache,
      airportCache: airportCache,
    );
  }

  void setAirlineScoreData(List<dynamic> value) {
    state = state.copyWith(
      airlineScoreData: List<Map<String, dynamic>>.from(value),
    );
  }

  Map<String, dynamic> getAirportData(String airportCode) {
    return state.airportCache[airportCode] ?? const <String, dynamic>{};
  }

  Map<String, dynamic> getAirlineData(String airlineCode) {
    return state.airlineCache[airlineCode] ?? const <String, dynamic>{};
  }

  final Map<String, List<Map<String, dynamic>>> _sortedListCache = {};

  List<Map<String, dynamic>> getAirlineDataSortedByCleanliness() {
    if (_sortedListCache.containsKey('cleanliness')) {
      return _sortedListCache['cleanliness']!;
    }

    final airlineScoreData = state.airlineScoreData;
    final airlineData = state.airlineData;
    final scoreMap = {
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
    _sortedListCache['cleanliness'] = result;
    return result;
  }

  List<Map<String, dynamic>> getAirlineDataSortedByOnboardSevice() {
    if (_sortedListCache.containsKey('onboardService')) {
      return _sortedListCache['onboardService']!;
    }

    final airlineScoreData = state.airlineScoreData;
    final airlineData = state.airlineData;
    final scoreMap = {
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
    _sortedListCache['onboardService'] = result;
    return result;
  }

  final Map<String, Map<String, String>> _continentCache = {};

  void getFilteredList(
      String filterType, String? searchQuery, String? flyerClass,
      [List<String>? selectedContinents]) {
    final airlineData = state.airlineData;
    final airportData = state.airportData;
    List<Map<String, dynamic>> filteredList = [];

    bool checkContinent(Map<String, dynamic> item) {
      if (selectedContinents == null || selectedContinents.isEmpty) return true;
      
      final countryCode = item['countryCode'];
      if (!_continentCache.containsKey(countryCode)) {
        _continentCache[countryCode] = {
          'continent': WorldCountry.fromCodeShort(countryCode).continent.name
        };
      }
      
      return selectedContinents.contains(_continentCache[countryCode]!['continent']);
    }

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
        filteredList
            .addAll(getAirlineDataSortedByCleanliness().where(checkContinent));
        break;
      case 'Onboard':
        filteredList.addAll(
            getAirlineDataSortedByOnboardSevice().where(checkContinent));
        break;
      default:
        filteredList.addAll(airlineData.where(checkContinent));
        filteredList.addAll(airportData.where(checkContinent));
    }

    if (flyerClass != null && flyerClass != 'All') {
      final sortKey = flyerClass == "Business" 
          ? 'businessClass'
          : flyerClass == "Premium economy" 
              ? 'pey' 
              : 'economyClass';
      
      filteredList.sort((a, b) => b[sortKey].compareTo(a[sortKey]));
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filteredList = filteredList.where((item) {
        final name = item['name'].toString().toLowerCase();
        final perksBio = item['perksBio'].toString().toLowerCase();
        final trendingBio = item['trendingBio'].toString().toLowerCase();

        return name.contains(query) ||
            perksBio.contains(query) ||
            trendingBio.contains(query);
      }).toList();
    }

    state = state.copyWith(filteredList: filteredList);
  }
}

final airlineAirportProvider =
    StateNotifierProvider<AirlineAirportNotifier, AirlineAirportState>((ref) {
  return AirlineAirportNotifier();
});
