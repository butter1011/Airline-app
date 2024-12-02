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
      if (review['id'] == value['id']) {
        print('💍💍🏓🏓$review');
        review['rating'] = value['rating'];
      }
      return review;
    }).toList();
  }

  List<dynamic> getReviewsByUserId(String userId) {
    return state
        .where((review) => review['reviewer']['_id'] == userId)
        .toList();
  }

  List<dynamic> getReviewsByBookMarkId(String BookMarkId) {
    return state
        .where((review) => review['airline']['_id'] == BookMarkId)
        .toList();
  }

  List<dynamic> getTopFiveReviews() {
    var sortedReviews =
        state.where((review) => review['rating'] != null).toList()
          ..sort((a, b) {
            var ratingA = a['rating'];
            var ratingB = b['rating'];
            if (ratingA is num && ratingB is num) {
              return ratingB.compareTo(ratingA);
            } else if (ratingA is String && ratingB is String) {
              return double.parse(ratingB).compareTo(double.parse(ratingA));
            } else {
              return 0;
            }
          });

    return sortedReviews.take(5).toList();
  }
}

// Provider for reviews data
final reviewsAirlineProvider =
    StateNotifierProvider<ReviewsAirlineNotifier, List<dynamic>>((ref) {
  return ReviewsAirlineNotifier();
});
