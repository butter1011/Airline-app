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

  List<Map<String, dynamic>> getAirlineDataSorted(String airlineSortKey) {
    if (state.sortedListCache.containsKey(airlineSortKey)) {
      return state.sortedListCache[airlineSortKey]!;
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
   print("🎈🎈$scoreMap");

    final result = airlineData.map((item) {
         final scores = scoreMap[item['_id']] ??
          {
            'departureArrival': 5.0,
            'comfort': 5.0,
            'cleanliness': 5.0,
            'onboardService': 5.0,
            'foodBeverage': 5.0,
            'entertainmentWifi': 5.0,
          };
      return {
        ...item,
        ...scores,
       
      };
    }).toList();

    result.sort((a, b) => b[airlineSortKey].compareTo(a[airlineSortKey]));

    state = state.copyWith(
      sortedListCache: {...state.sortedListCache, airlineSortKey: result},
    );
    return result;
  }

  List<Map<String, dynamic>> getAirportDataSorted(String airportSortKey) {
    if (state.sortedListCache.containsKey(airportSortKey)) {
      return state.sortedListCache[airportSortKey]!;
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
            'accessibility': 5.0,
            'waitTimes': 5.0,
            'helpfulness': 5.0,
            'ambienceComfort': 5.0,
            'foodBeverage': 5.0,
            'amenities': 5.0,
          };
      return {
        ...item,
        ...scores,
      };
    }).toList();

    result.sort((a, b) => b[airportSortKey].compareTo(a[airportSortKey]));

    state = state.copyWith(
      sortedListCache: {...state.sortedListCache, airportSortKey: result},
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
            'departureArrival': 5.0,
            'comfort': 5.0,
            'cleanliness': 5.0,
            'onboardService': 5.0,
            'foodBeverage': 5.0,
            'entertainmentWifi': 5.0,
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
            'accessibility': 5.0,
            'waitTimes': 5.0,
            'helpfulness': 5.0,
            'ambienceComfort': 5.0,
            'foodBeverage': 5.0,
            'amenities': 5.0,
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

  void getFilteredList(String filterType, String? searchQuery,
      String? flyerClass, String? selectedCategory,
      [List<dynamic>? selectedContinents]) {
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
        '${filterType}_${searchQuery ?? ''}_${flyerClass ?? ''}_${selectedCategory ?? ''}_${selectedContinents?.join('_') ?? ''}';

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
      case 'Flight Experience':
        filteredList.addAll(
            getAirlineDataSorted("departureArrival").where(checkContinent));
        break;
      case 'Comfort':
        filteredList.addAll(
            getAirlineDataSorted("comfort").where(checkContinent));
        break;
      case 'Cleanliness':
        filteredList
            .addAll(getAirlineDataSorted("cleanliness").where(checkContinent));
        break;
      case 'Onboard':
        filteredList.addAll(
            getAirlineDataSorted("onboardService").where(checkContinent));
        break;
      case 'Food & Beverage':
        filteredList
            .addAll(getAirlineDataSorted("foodBeverage").where(checkContinent));
        break;
      case 'Entertainment & WiFi':
        filteredList.addAll(
            getAirlineDataSorted("entertainmentWifi").where(checkContinent));
        break;
      case 'Accessibility':
        filteredList.addAll(
            getAirportDataSorted("accessibility").where(checkContinent));
        break;
      case 'Wait Times':
        filteredList
            .addAll(getAirportDataSorted("waitTimes").where(checkContinent));
        break;
      case 'Helpfulness':
        filteredList
            .addAll(getAirportDataSorted("helpfulness").where(checkContinent));
        break;
      case 'Ambience':
        filteredList.addAll(
            getAirportDataSorted("ambienceComfort").where(checkContinent));
        break;
      case 'Amenities':
        filteredList
            .addAll(getAirportDataSorted("amenities").where(checkContinent));
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
    if (selectedCategory != null && selectedCategory.isNotEmpty) {
      final sortKey = switch (selectedCategory) {
        "Departure & Arrival Experience" => 'departureArrival',
        "Comfort" => 'comfort',
        "Cleanliness" => 'cleanliness',
        "Onboard Service" => 'onboardService',
        "Food & Beverage" => 'foodBeverage',
        "Entertainment & WiFi" => 'entertainmentWifi',
        "Accessibility" => 'accessibility',
        "Wait Times" => 'waitTimes',
        "Helpfulness" => 'helpfulness',
        "Ambience" => 'ambienceComfort',
        "Amenities and Facilities" => 'amenities',
        _ => 'departureArrival'
      };
      filteredList
          .sort((a, b) => (b[sortKey] ?? 0.0).compareTo(a[sortKey] ?? 0.0));
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
