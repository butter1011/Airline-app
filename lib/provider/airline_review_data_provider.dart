import 'package:flutter_riverpod/flutter_riverpod.dart';

// Reviews notifier class
class ReviewsAirlineNotifier extends StateNotifier<List<dynamic>> {
  ReviewsAirlineNotifier() : super([]);
  void setReviews(List<dynamic> reviews) {
    state = reviews;
  }

  void clearReviews() {
    state = [];
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
