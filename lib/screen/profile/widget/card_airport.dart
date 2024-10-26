import 'package:airline_app/screen/profile/widget/cair_category_reviews.dart';

import 'package:airline_app/utils/cairport_list_json.dart';

import 'package:flutter/material.dart';

class CLeaderboardScreen extends StatelessWidget {
  const CLeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List reviews = cairportList[1]['reviews']['Seat Comfort'];
    return Column(
      children: reviews.map((singleReview) {
        return CairCategoryReviews(
          review: singleReview,
        );
      }).toList(),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////
