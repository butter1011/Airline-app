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

  void updateReview(String feedbackId, String userId, int? reactionIndex) {
    state = state.map((review) {
      if (review['_id'] == feedbackId) {
        if (review['rating'] != null) {
          return {
            ...review,
            'rating': {
              ...review['rating'],
              userId: reactionIndex,
            },
          };
        }
      }
      return review;
    }).toList();
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
