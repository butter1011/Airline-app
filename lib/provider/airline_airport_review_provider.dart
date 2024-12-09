import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sealed_countries/sealed_countries.dart';

class ReviewState {
  final List<Map<String, dynamic>> reviews;
  final List<Map<String, dynamic>> filteredReviews;
  final List<Map<String, dynamic>> airlineScoreData;
  final List<Map<String, dynamic>> airportScoreData;
  final Map<String, List<Map<String, dynamic>>> sortedListCache;
  final Map<String, Map<String, String>> continentCache;

  const ReviewState({
    this.reviews = const [],
    this.filteredReviews = const [],
    this.airlineScoreData = const [],
    this.airportScoreData = const [],
    this.sortedListCache = const {},
    this.continentCache = const {},
  });

  ReviewState copyWith({
    List<Map<String, dynamic>>? reviews,
    List<Map<String, dynamic>>? filteredReviews,
    List<Map<String, dynamic>>? airlineScoreData,
    List<Map<String, dynamic>>? airportScoreData,
    Map<String, List<Map<String, dynamic>>>? sortedListCache,
    Map<String, Map<String, String>>? continentCache,
  }) {
    return ReviewState(
      reviews: reviews ?? this.reviews,
      filteredReviews: filteredReviews ?? this.filteredReviews,
      airlineScoreData: airlineScoreData ?? this.airlineScoreData,
      airportScoreData: airportScoreData ?? this.airportScoreData,
      sortedListCache: sortedListCache ?? this.sortedListCache,
      continentCache: continentCache ?? this.continentCache,
    );
  }
}

class ReviewsAirlineNotifier extends StateNotifier<ReviewState> {
  ReviewsAirlineNotifier() : super(const ReviewState());

  void setReviewData(Map<String, dynamic> value) {
    final newData = value["data"] as List;
    final newItems = newData
        .where((newItem) {
          if (newItem is! Map<String, dynamic>) return false;
          return !state.reviews
              .any((existingItem) => existingItem['_id'] == newItem['_id']);
        })
        .cast<Map<String, dynamic>>()
        .toList();

    if (newItems.isNotEmpty) {
      state = state.copyWith(
        reviews: [...state.reviews, ...newItems],
      );
    }
  }

  void setAirlineScoreData(List<dynamic> value) {
    state = state.copyWith(
      airlineScoreData: List<Map<String, dynamic>>.from(value),
      sortedListCache: {},
    );
  }

  void setAirportScoreData(List<dynamic> value) {
    state = state.copyWith(
      airportScoreData: List<Map<String, dynamic>>.from(value),
    );
  }

  void addReview(Map<String, dynamic> value) {
    state = state.copyWith(
      reviews: [...state.reviews, value],
      sortedListCache: {},
    );
  }

  void updateReview(Map<String, dynamic> value) {
    final updatedReviews = state.reviews.map((review) {
      if (review['id'] == value['id']) {
        return {...review, 'rating': value['rating']};
      }
      return review;
    }).toList();

    state = state.copyWith(
      reviews: updatedReviews,
      sortedListCache: {},
    );
  }

  List<Map<String, dynamic>> getReviewsByBookMarkId(String bookMarkId) {
    return state.reviews
        .where((review) => review['airline']['_id'] == bookMarkId)
        .toList();
  }

  List<Map<String, dynamic>> getReviewsByUserId(String userId) {
    return state.reviews
        .where((review) => review['reviewer']['_id'] == userId)
        .toList();
  }

  List<Map<String, dynamic>> getTopFiveReviews() {
    var sortedReviews =
        state.reviews.where((review) => review['rating'] != null).toList()
          ..sort((a, b) {
            var ratingA = a['rating'];
            var ratingB = b['rating'];
            if (ratingA is num && ratingB is num) {
              return ratingB.compareTo(ratingA);
            } else if (ratingA is String && ratingB is String) {
              return double.parse(ratingB).compareTo(double.parse(ratingA));
            }
            return 0;
          });

    return sortedReviews.take(5).toList();
  }

  List<Map<String, dynamic>> getAirlineReviewsWithScore() {
    if (state.sortedListCache.containsKey('airlineWithScore')) {
      return state.sortedListCache['airlineWithScore']!;
    }
    final airlineScoreData = state.airlineScoreData;

    final airlineReviews =
        state.reviews.where((review) => review.containsKey("from")).toList();

    final scoreMap = Map.fromEntries(
      airlineScoreData.map((score) => MapEntry(score['airlineId'], {
            'departureArrival': score['departureArrival'],
            'comfort': score['comfort'],
            'cleanliness': score['cleanliness'],
            'onboardService': score['onboardService'],
            'foodBeverage': score['foodBeverage'],
            'entertainmentWifi': score['entertainmentWifi'],
          })),
    );

    final result = airlineReviews.map((item) {
      final scores = scoreMap[item['airline']['_id']] ??
          {
            'departureArrival': 5,
            'comfort': 5,
            'cleanliness': 5,
            'onboardService': 5,
            'foodBeverage': 5,
            'entertainmentWifi': 5,
          };

      return {...item, ...scores};
    }).toList();

    state = state.copyWith(
      sortedListCache: {...state.sortedListCache, 'airlineWithScore': result},
    );
    return result;
  }

  List<Map<String, dynamic>> getAirportReviewsWithScore() {
    if (state.sortedListCache.containsKey('airportWithScore')) {
      return state.sortedListCache['airportWithScore']!;
    }

    final airportScoreData = state.airportScoreData;

    final airportReviews =
        state.reviews.where((review) => !review.containsKey("from")).toList();

    final scoreMap = Map.fromEntries(
      airportScoreData.map((score) => MapEntry(score['airportId'], {
            'accessibility': score['accessibility'],
            'waitTimes': score['waitTimes'],
            'helpfulness': score['helpfulness'],
            'ambienceComfort': score['ambienceComfort'],
            'foodBeverage': score['foodBeverage'],
            'amenities': score['amenities'],
          })),
    );

    final result = airportReviews.map((item) {
      final scores = scoreMap[item['airport']['_id']] ??
          {
            'accessibility': 5,
            'waitTimes': 5,
            'helpfulness': 5,
            'ambienceComfort': 5,
            'foodBeverage': 5,
            'amenities': 5,
          };

      return {...item, ...scores};
    }).toList();

    state = state.copyWith(
      sortedListCache: {...state.sortedListCache, 'airportWithScore': result},
    );
    return result;
  }

  List<Map<String, dynamic>> getAirlineReviewsSortedByCleanliness() {
    final airlineReviews = getAirlineReviewsWithScore();

    return List.from(airlineReviews)
      ..sort((a, b) => b['cleanliness'].compareTo(a['cleanliness']));
  }

  List<Map<String, dynamic>> getAirlineReviewsSortedByOnboardService() {
    final airlineReviews = getAirlineReviewsWithScore();

    return List.from(airlineReviews)
      ..sort((a, b) => b['onboardService'].compareTo(a['onboardService']));
  }

  void getFilteredReviews(
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

    final cacheKey =
        '${filterType}_${flyerClass ?? ''}_${selectedContinents?.join('_') ?? ''}';

    if (state.sortedListCache.containsKey(cacheKey)) {
      state = state.copyWith(filteredReviews: state.sortedListCache[cacheKey]!);
      return;
    }

    List<Map<String, dynamic>> filteredReviews = [];

    switch (filterType) {
      case 'All':
        filteredReviews = [
          ...getAirlineReviewsWithScore().where(checkContinent),
          ...getAirportReviewsWithScore().where(checkContinent),
        ];
        break;
      case 'Airline':
        filteredReviews =
            getAirlineReviewsWithScore().where(checkContinent).toList();
        break;
      case 'Airport':
        filteredReviews =
            getAirportReviewsWithScore().where(checkContinent).toList();
        break;
      case 'Cleanliness':
        filteredReviews = getAirlineReviewsSortedByCleanliness()
            .where(checkContinent)
            .toList();
        break;
      case 'Onboard':
        filteredReviews = getAirlineReviewsSortedByOnboardService()
            .where(checkContinent)
            .toList();
        break;
      default:
        filteredReviews = [
          ...getAirlineReviewsWithScore().where(checkContinent),
          ...getAirportReviewsWithScore().where(checkContinent),
        ];
    }

    if (flyerClass != null && flyerClass != 'All') {
      final sortKey = flyerClass == "Business"
          ? 'businessClass'
          : flyerClass == "Premium economy"
              ? 'pey'
              : 'economyClass';

      filteredReviews = filteredReviews.where((item) {
        if (item.containsKey("from")) {
          return item['airline'][sortKey] != null;
        } else {
          return item['airport'][sortKey] != null;
        }
      }).toList();

      if (filteredReviews.isNotEmpty) {
        if (filteredReviews[0].containsKey("from")) {
          filteredReviews.sort((a, b) => (b['airline'][sortKey] ?? 0)
              .compareTo(a['airline'][sortKey] ?? 0));
        } else {
          filteredReviews.sort((a, b) => (b['airport'][sortKey] ?? 0)
              .compareTo(a['airport'][sortKey] ?? 0));
        }
      }
    }

    state = state.copyWith(
      filteredReviews: filteredReviews,
      sortedListCache: {...state.sortedListCache, cacheKey: filteredReviews},
    );
  }
}

final reviewsAirlineProvider =
    StateNotifierProvider<ReviewsAirlineNotifier, ReviewState>((ref) {
  return ReviewsAirlineNotifier();
});
