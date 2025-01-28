import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/screen/leaderboard/widgets/feedback_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class CLeaderboardScreen extends ConsumerWidget {
  const CLeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);
    final reviewsNotifier = ref.watch(reviewsAirlineProvider.notifier);

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 17.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  AppLocalizations.of(context).translate('Recent Contribution'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              // Expanded(child: ReviewScore())
            ],
          ),
        ),
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
              if (singleReview != null) {
                final reviewer = singleReview['reviewer'];
                final airline = singleReview['airline'];

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
                      if (index != userReviews.length - 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: [
                              SizedBox(height: 9),
                              Divider(
                                thickness: 2,
                                color: Colors.black,
                              ),
                              SizedBox(height: 24),
                            ],
                          ),
                        ),
                    ],
                  );
                }
              }
              return const SizedBox.shrink();
            }).toList(),
          ),
      ],
    );
  }
}

// class ReviewScore extends StatefulWidget {
//   const ReviewScore({super.key});

//   @override
//   State<ReviewScore> createState() => _ReviewScoreState();
// }

// class _ReviewScoreState extends State<ReviewScore> {
//   String? _selectedItem;
//   // final List<dynamic> _items = [
//   //   'Highest Score',
//   //   'Lowest Score',
//   // ];

//   @override
//   void initState() {
//     super.initState();
//     // _selectedItem = _items[0];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: _selectedItem,
//           isExpanded: true,
//           icon: Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: Icon(
//               Icons.expand_more,
//               color: Colors.grey.shade600,
//             ),
//           ),
//           style: TextStyle(
//               color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600),
//           menuMaxHeight: 600,
//           elevation: 8,
//           dropdownColor: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           onChanged: (String? newValue) {
//             if (newValue != null) {
//               setState(() {
//                 _selectedItem = newValue;
//               });
//             }
//           },
//           // items: _items.map<DropdownMenuItem<String>>((dynamic value) {
//           //   return DropdownMenuItem<String>(
//           //     value: value,
//           //     child: Container(
//           //       padding: EdgeInsets.symmetric(vertical: 8.0),
//           //       decoration: BoxDecoration(
//           //         borderRadius: BorderRadius.circular(24),
//           //         color: Colors.transparent,
//           //       ),
//           //       child: Text(
//           //         AppLocalizations.of(context).translate(value) ?? value,
//           //         style: TextStyle(
//           //           color: Colors.black,
//           //           fontSize: 16,
//           //         ),
//           //       ),
//           //     ),
//           //   );
//           // }).toList(),
//         ),
//       ),
//     );
//   }
// }
