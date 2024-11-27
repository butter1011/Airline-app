import 'package:flutter_riverpod/flutter_riverpod.dart';

// Reviews notifier class
class ReviewsAirlineNotifier extends StateNotifier<List<dynamic>> {
  ReviewsAirlineNotifier() : super([]);
  void setReviews(List<dynamic> reviews) {
    print(reviews);
    print("------------------");
    state = reviews;
  }

  void clearReviews() {
    state = [];
  }

  void addReview(Map<String, dynamic> reviewResponse) {
    final allData = reviewResponse;
    print(allData); 
    state = [...state, allData];
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
