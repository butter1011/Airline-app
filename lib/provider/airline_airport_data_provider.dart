import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sealed_countries/sealed_countries.dart';

/// State class to manage airline and airport data
class AirlineAirportState {
  final List<Map<String, dynamic>> airlineData;
  final List<Map<String, dynamic>> airportData;
  final List<Map<String, dynamic>> airlineScoreData;
  final List<Map<String, dynamic>> airportScoreData;
  final List<Map<String, dynamic>> filteredList;
  final Map<String, Map<String, dynamic>> airportCache;
  final Map<String, Map<String, dynamic>> airlineCache;
  final Map<String, List<Map<String, dynamic>>> sortedListCache;
  final Map<String, Map<String, String>> continentCache;

  const AirlineAirportState({
    this.airlineData = const [],
    this.airportData = const [],
    this.airlineScoreData = const [],
    this.airportScoreData = const [],
    this.filteredList = const [],
    this.airportCache = const {},
    this.airlineCache = const {},
    this.sortedListCache = const {},
    this.continentCache = const {},
  });

  AirlineAirportState copyWith({
    List<Map<String, dynamic>>? airlineData,
    List<Map<String, dynamic>>? airportData,
    List<Map<String, dynamic>>? airlineScoreData,
    List<Map<String, dynamic>>? airportScoreData,
    List<Map<String, dynamic>>? filteredList,
    Map<String, Map<String, dynamic>>? airportCache,
    Map<String, Map<String, dynamic>>? airlineCache,
    Map<String, List<Map<String, dynamic>>>? sortedListCache,
    Map<String, Map<String, String>>? continentCache,
  }) {
    return AirlineAirportState(
      airlineData: airlineData ?? this.airlineData,
      airportData: airportData ?? this.airportData,
      airlineScoreData: airlineScoreData ?? this.airlineScoreData,
      airportScoreData: airportScoreData ?? this.airportScoreData,
      filteredList: filteredList ?? this.filteredList,
      airportCache: airportCache ?? this.airportCache,
      airlineCache: airlineCache ?? this.airlineCache,
      sortedListCache: sortedListCache ?? this.sortedListCache,
      continentCache: continentCache ?? this.continentCache,
    );
  }
}

/// Notifier class to manage airline and airport state
class AirlineAirportNotifier extends StateNotifier<AirlineAirportState> {
  AirlineAirportNotifier() : super(const AirlineAirportState());

  /// Sets the initial airline and airport data
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
      sortedListCache: {},
    );
  }

  /// Sets the airline score data
  void setAirlineScoreData(List<dynamic> value) {
    state = state.copyWith(
      airlineScoreData: List<Map<String, dynamic>>.from(value),
      sortedListCache: {},
    );
  }

  /// Sets the airport score data
  void setAirportScoreData(List<dynamic> value) {
    state = state.copyWith(
      airportScoreData: List<Map<String, dynamic>>.from(value),
    );
  }

  /// Retrieves airport data by IATA code
  Map<String, dynamic> getAirportData(String airportCode) {
    return state.airportCache[airportCode] ?? const <String, dynamic>{};
  }

  /// Retrieves airline data by IATA code
  Map<String, dynamic> getAirlineData(String airlineCode) {
    return state.airlineCache[airlineCode] ?? const <String, dynamic>{};
  }

  /// Returns airlines sorted by cleanliness score
  List<Map<String, dynamic>> getAirlineDataSortedByCleanliness() {
    if (state.sortedListCache.containsKey('cleanliness')) {
      return state.sortedListCache['cleanliness']!;
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

    state = state.copyWith(
      sortedListCache: {...state.sortedListCache, 'cleanliness': result},
    );
    return result;
  }

  /// Returns airlines sorted by onboard service score
  List<Map<String, dynamic>> getAirlineDataSortedByOnboardSevice() {
    if (state.sortedListCache.containsKey('onboardService')) {
      return state.sortedListCache['onboardService']!;
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

    state = state.copyWith(
      sortedListCache: {...state.sortedListCache, 'onboardService': result},
    );
    return result;
  }

  /// Combines airline data with their respective scores
  List<Map<String, dynamic>> getAirlineDataWithScore() {
    if (state.sortedListCache.containsKey('airlineWithScore')) {
      return state.sortedListCache['airlineWithScore']!;
    }

    final airlineScoreData = state.airlineScoreData;
    final airlineData = state.airlineData;
    final scoreMap = {
      for (var score in airlineScoreData)
        score['airlineId']: {
          'departureArrival': score['departureArrival'],
          'comfort': score['comfort'],
          'cleanliness': score['cleanliness'],
          'onboardService': score['onboardService'],
          'foodBeverage': score['foodBeverage'],
          'entertainmentWifi': score['entertainmentWifi'],
        }
    };

    final result = airlineData.map((item) {
      final scores = scoreMap[item['_id']] ??
          {
            'departureArrival': 5,
            'comfort': 5,
            'cleanliness': 5,
            'onboardService': 5,
            'foodBeverage': 5,
            'entertainmentWifi': 5,
          };

      return {
        ...item,
        ...scores,
      };
    }).toList();

    state = state.copyWith(
      sortedListCache: {...state.sortedListCache, 'airlineWithScore': result},
    );
    return result;
  }

  /// Combines airport data with their respective scores
  List<Map<String, dynamic>> getAirportDataWithScore() {
    if (state.sortedListCache.containsKey('airportWithScore')) {
      return state.sortedListCache['airportWithScore']!;
    }

    final airportScoreData = state.airportScoreData;
    final airportData = state.airportData;
    final scoreMap = {
      for (var score in airportScoreData)
        score['airportId']: {
          'accessibility': score['accessibility'],
          'waitTimes': score['waitTimes'],
          'helpfulness': score['helpfulness'],
          'ambienceComfort': score['ambienceComfort'],
          'foodBeverage': score['foodBeverage'],
          'amenities': score['amenities'],
        }
    };

    final result = airportData.map((item) {
      final scores = scoreMap[item['_id']] ??
          {
            'accessibility': 5,
            'waitTimes': 5,
            'helpfulness': 5,
            'ambienceComfort': 5,
            'foodBeverage': 5,
            'amenities': 5,
          };

      return {
        ...item,
        ...scores,
      };
    }).toList();

    state = state.copyWith(
      sortedListCache: {...state.sortedListCache, 'airportWithScore': result},
    );
    return result;
  }

  String getAirlineName(String airlineId) {
    final airline = state.airlineData.firstWhere(
      (airline) => airline['_id'] == airlineId,
      orElse: () => {'name': 'Unknown Airline'},
    );
    return airline['name'];
  }

  String getAirlineLogoImage(String airlineId) {
    final airline = state.airlineData.firstWhere(
      (airline) => airline['_id'] == airlineId,
      orElse: () => {'logoImage': ''},
    );
    return airline['logoImage'];
  }

  String getAirlineBackgroundImage(String airlineId) {
    final airline = state.airlineData.firstWhere(
      (airline) => airline['_id'] == airlineId,
      orElse: () => {'backgroundImage': ''},
    );
    return airline['backgroundImage'];
  }

  String getAirportName(String airportId) {
    final airport = state.airportData.firstWhere(
      (airport) => airport['_id'] == airportId,
      orElse: () => {'name': 'Unknown Airport'},
    );
    return airport['name'];
  }

  String getAirportLogoImage(String airportId) {
    final airport = state.airportData.firstWhere(
      (airport) => airport['_id'] == airportId,
      orElse: () => {'logoImage': ''},
    );
    return airport['logoImage'];
  }

  String getAirportBackgroundImage(String airportId) {
    final airport = state.airportData.firstWhere(
      (airport) => airport['_id'] == airportId,
      orElse: () => {'backgroundImage': ''},
    );
    return airport['backgroundImage'];
  }

  /// Filters and sorts data based on multiple criteria
  /// [filterType] - Type of filter to apply (All, Airline, Airport, etc.)
  /// [searchQuery] - Optional search query to filter results
  /// [flyerClass] - Optional class type to sort results
  /// [selectedContinents] - Optional list of continents to filter by
  void getFilteredList(
      String filterType, String? searchQuery, String? flyerClass,
      [List<String>? selectedContinents]) {
    bool checkContinent(Map<String, dynamic> item) {
      if (selectedContinents == null || selectedContinents.isEmpty) return true;

      final countryCode = item['countryCode'];
      if (!state.continentCache.containsKey(countryCode)) {
        state = state.copyWith(
          continentCache: {
            ...state.continentCache,
            countryCode: {
              'continent':
                  WorldCountry.fromCodeShort(countryCode).continent.name
            }
          },
        );
      }

      return selectedContinents
          .contains(state.continentCache[countryCode]!['continent']);
    }

    List<Map<String, dynamic>> filteredList = [];
    final cacheKey =
        '${filterType}_${searchQuery ?? ''}_${flyerClass ?? ''}_${selectedContinents?.join('_') ?? ''}';

    if (state.sortedListCache.containsKey(cacheKey)) {
      state = state.copyWith(filteredList: state.sortedListCache[cacheKey]!);
      return;
    }

    switch (filterType) {
      case 'All':
        filteredList.addAll(getAirlineDataWithScore().where(checkContinent));
        filteredList.addAll(getAirportDataWithScore().where(checkContinent));
        break;
      case 'Airline':
        filteredList.addAll(getAirlineDataWithScore().where(checkContinent));
        break;
      case 'Airport':
        filteredList.addAll(getAirportDataWithScore().where(checkContinent));
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
        filteredList.addAll(getAirlineDataWithScore().where(checkContinent));
        filteredList.addAll(getAirportDataWithScore().where(checkContinent));
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

    state = state.copyWith(
      filteredList: filteredList,
      sortedListCache: {...state.sortedListCache, cacheKey: filteredList},
    );
  }
}

/// Provider for airline and airport data management
final airlineAirportProvider =
    StateNotifierProvider<AirlineAirportNotifier, AirlineAirportState>((ref) {
  return AirlineAirportNotifier();
});
