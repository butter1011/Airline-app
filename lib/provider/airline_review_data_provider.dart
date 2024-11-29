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

  void addReview(Map<String, dynamic> value) {
    state = [...state, value];
  }

  void updateReview(Map<String, dynamic> value) {
    state = state.map((review) {
      if (review['_id'] == value['id']) {
        review['rating'] = value['rating'];
      }
      return review;
    }).toList();
  }

  List<dynamic> getReviewsByUserId(String userId) {
    return state.where((review) => review['id'] == userId).toList();
  }
}

// Provider for reviews data
final reviewsAirlineProvider =
    StateNotifierProvider<ReviewsAirlineNotifier, List<dynamic>>((ref) {
  return ReviewsAirlineNotifier();
});
