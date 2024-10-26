import 'package:airline_app/screen/feed/widgets/feed_card.dart';
import 'package:airline_app/screen/feed/widgets/feed_filter_button.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // This section will always stay at the top
          SizedBox(
            height: 44,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 271,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white, // Background color
                    border: Border.all(
                        width: 2, color: Colors.black), // Border color
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(2, 2))
                    ],
                  ),
                  child: const Center(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                            fontFamily: 'Clash Grotesk', fontSize: 14),
                        contentPadding: EdgeInsets.all(0),
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none, // Remove the underline
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.filterscreen);
                  },
                  child: Container(
                    width: 40, // Diameter of the circular avatar
                    height: 40, // Diameter of the circular avatar
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, // Background color
                      border: Border.all(
                          width: 2, color: Colors.black), // Border color
                      boxShadow: const [
                        BoxShadow(color: Colors.black, offset: Offset(2, 2))
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                          'assets/icons/setting.png'), // Local image asset
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Text(
                  'Filter by category',
                  style: TextStyle(
                      fontFamily: 'Clash Grotesk',
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ],
            ),
          ),
          const SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FeedFilterButton(
                  text: "All",
                ),
                SizedBox(width: 8),
                FeedFilterButton(
                  text: "Airline",
                ),
                SizedBox(width: 8),
                FeedFilterButton(
                  text: "Airports",
                ),
                SizedBox(width: 8),
                FeedFilterButton(
                  text: "Cleanliness",
                ),
                SizedBox(width: 8),
                FeedFilterButton(
                  text: "Onboard",
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(height: 4, color: AppStyles.littleBlackColor),

          // The rest of your content goes here inside a scrollable area
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        children: trendingFeedbackList.map((singleFeedback) {
                      return FeedCard(
                          singleFeedback: singleFeedback); // Your custom widget
                    }).toList()),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
            ],
          )))
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////

