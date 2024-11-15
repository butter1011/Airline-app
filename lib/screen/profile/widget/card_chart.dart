import 'package:airline_app/screen/profile/widget/review_button.dart';

import 'package:flutter/material.dart';

class CardChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use a Container with a fixed height or let GridView take its own space
          Container(
            height: MediaQuery.of(context).size.height *
                0.5, // Adjust height as needed
            child: GridView.count(
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                ReviewButton(
                  iconUrl: 'assets/icons/reviewmessage.png',
                  label: 'Top Reviewer',
                ),
                ReviewButton(
                  iconUrl: 'assets/icons/review_icon_comfort.png',
                  label: 'Badge name',
                ),
                ReviewButton(
                  iconUrl: 'assets/icons/review_icon_cleanliness.png',
                  label: 'Badge name goes\n here',
                ),
                ReviewButton(
                  iconUrl: 'assets/icons/review_icon_onboard.png',
                  label: 'Badge name goes\n here',
                ),
                ReviewButton(
                  iconUrl: 'assets/icons/review_icon_food.png',
                  label: 'Badge name',
                ),
                ReviewButton(
                  iconUrl: 'assets/icons/review_icon_entertainment.png',
                  label: 'Badge name',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
