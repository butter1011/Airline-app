import 'package:flutter_riverpod/flutter_riverpod.dart';

// Reviews notifier class
class ReviewsAirlineNotifier extends StateNotifier<List<dynamic>> {
  ReviewsAirlineNotifier() : super([]);

  void setData(Map<String, dynamic> value) {
    final allData = value["data"] as List;
    state = allData;
  }

  void clearReviews() {
    state = [];
  }

  void addReview(Map<String, dynamic> reviewResponse) {
    state = [...state, reviewResponse];
  }

  List<dynamic> getReviewsByUserId(String userId) {
    return state
        .where((review) => review['reviewer']['_id'] == userId)
        .toList();
  }
}

// Provider for reviews data
final reviewsAirlineProvider =
    StateNotifierProvider<ReviewsAirlineNotifier, List<dynamic>>((ref) {
  return ReviewsAirlineNotifier();
});
