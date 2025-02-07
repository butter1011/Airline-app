import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/screen/leaderboard/widgets/feedback_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:flutter/material.dart';

class CLeaderboardScreen extends ConsumerWidget {
  const CLeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);
    final reviewsNotifier = ref.watch(reviewsAirlineAirportProvider.notifier);

    if (userData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final userId = userData['userData']['_id'];

    if (userId == null) {
      return const Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Center(child: Text("User ID not found")),
      );
    }

    final userReviews = reviewsNotifier.getReviewsByUserId(userId);
    return Column(
      children: [
        if (userReviews.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Center(child: Text("No reviews found")),
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: userReviews.asMap().entries.map((entry) {
              final index = entry.key;
              final singleReview = entry.value;
              final reviewer = singleReview['reviewer'];
              final airline = singleReview['airline'];
              print("This is the single review: $singleReview");

              if (reviewer != null && airline != null) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: FeedbackCard(
                        thumbnailHeight: 260,
                        singleFeedback: singleReview,
                      ),
                    ),
                    Divider(
                      indent: 24,
                      endIndent: 24,
                      thickness: 2,
                      color: Colors.grey.shade100,
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }).toList(),
          ),
      ],
    );
  }
}
