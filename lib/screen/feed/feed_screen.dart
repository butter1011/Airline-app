import 'package:airline_app/controller/feedback_controller.dart';
import 'package:airline_app/provider/airline_review_data_provider.dart';
import 'package:airline_app/screen/app_widgets/bottom_nav_bar.dart';

import 'package:airline_app/screen/feed/widgets/feed_filter_button.dart';
import 'package:airline_app/screen/leaderboard/widgets/feedback_card.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  late bool selectedAll = true;
  late bool selectedAirline = false;
  late bool selectedAirport = false;
  late bool selectedCleanliness = false;
  late bool selectedOnboard = false;

  @override
  Widget build(BuildContext context) {
    final reviewList = ref.watch(reviewsAirlineProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
      body: Column(
        children: [
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
                    color: Colors.white,
                    border: Border.all(width: 2, color: Colors.black),
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
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.filterscreen);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.black),
                      boxShadow: const [
                        BoxShadow(color: Colors.black, offset: Offset(2, 2))
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset('assets/icons/setting.png'),
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
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FeedFilterButton(
                  text: "All",
                  onSelectionChanged: (value) {
                    setState(() {
                      selectedAll = value;
                    });
                  },
                ),
                SizedBox(width: 8),
                FeedFilterButton(
                  text: "Airline",
                  onSelectionChanged: (value) {
                    setState(() {
                      selectedAirline = value;
                    });
                  },
                ),
                SizedBox(width: 8),
                FeedFilterButton(
                  text: "Airport",
                  onSelectionChanged: (value) {
                    setState(() {
                      selectedAirport = value;
                    });
                  },
                ),
                SizedBox(width: 8),
                FeedFilterButton(
                  text: "Cleanliness",
                  onSelectionChanged: (value) {
                    setState(() {
                      selectedCleanliness = value;
                    });
                  },
                ),
                SizedBox(width: 8),
                FeedFilterButton(
                  text: "Onboard",
                  onSelectionChanged: (value) {
                    setState(() {
                      selectedOnboard = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(height: 4, color: AppStyles.littleBlackColor),
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
                        children: reviewList.map((singleFeedback) {
                      return FeedbackCard(singleFeedback: singleFeedback);
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
