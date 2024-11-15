// leaderboard

import 'package:airline_app/screen/app_widgets/bottom_nav_bar.dart';
import 'package:airline_app/screen/leaderboard/widgets/feedback_card.dart';
import 'package:airline_app/screen/leaderboard/widgets/airport_list.dart';
import 'package:airline_app/screen/leaderboard/widgets/mainButton.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<Map<String, dynamic>> leaderBoardList = [];
  List<Map<String, dynamic>> reviewList = [];
  bool isLeaderboardLoading = true;
  bool isReviewsLoading = true;
  int expandedItems = 5;

  @override
  void initState() {
    super.initState();
    fetchLeaderboard();
    fetchReviews();
  }

  /// Fetch the leaderboard data
  Future<void> fetchLeaderboard() async {
    try {
      final response = await http.get(Uri.parse(
          'https://airline-backend-pi.vercel.app/api/v2/airline-airport'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];
        setState(() {
          leaderBoardList = List<Map<String, dynamic>>.from(data);
          isLeaderboardLoading = false;
        });
      } else {
        setState(() {
          isLeaderboardLoading = false;
        });
        throw Exception('Failed to load leaderboard datas');
      }
    } catch (e) {
      setState(() {
        isLeaderboardLoading = false;
      });
    }
  }

  /// Fetch the reviews data
  Future<void> fetchReviews() async {
    try {
      final response = await http.get(Uri.parse(
          'https://airline-backend-pi.vercel.app/api/v2/airline-reviews'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          reviewList = List<Map<String, dynamic>>.from(data);
          isReviewsLoading = false;
        });
      } else {
        setState(() {
          isReviewsLoading = false;
        });
        throw Exception('Failed to load reviews');
      }
    } catch (e) {
      setState(() {
        isReviewsLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
      ),
      body: isReviewsLoading || isLeaderboardLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                // This section will always stay at the top
                SizedBox(
                  height: 44,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                              BoxShadow(
                                  color: Colors.black, offset: Offset(2, 2))
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        'Filter by category',
                        style: AppStyles.textStyle_15_500
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MainButton(
                        text: "All",
                      ), // Replace with your button widget
                      SizedBox(width: 8),
                      MainButton(
                        text: "Airline",
                      ),
                      SizedBox(width: 8),
                      MainButton(
                        text: "Airports",
                      ),
                      SizedBox(width: 8),
                      MainButton(
                        text: "Cleanliness",
                      ),
                      SizedBox(width: 8),
                      MainButton(
                        text: "Onboard",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Container(
                  height: 5,
                  decoration: BoxDecoration(color: AppStyles.littleBlackColor),
                ),
                // Divider(thickness: 5, color: AppStyles.littleBlackColor),

                // The rest of your content goes here inside a scrollable area
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Trending Airlines & Airports',
                                style: AppStyles.textStyle_16_600.copyWith(
                                  color: Color(0xff38433E),
                                ),
                              ),

                              _AirportListSection(
                                leaderBoardList: leaderBoardList,
                                expandedItems: expandedItems,
                                onExpand: () {
                                  setState(() {
                                    expandedItems += 5;
                                  });
                                },
                              ), // Your custom widget
                              SizedBox(height: 28),
                              Text(
                                'Trending Feedback',
                                style: AppStyles.textStyle_16_600.copyWith(
                                  color: Color(0xff38433E),
                                ),
                              ),
                              SizedBox(height: 17),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: reviewList.map(
                                    (singleFeedback) {
                                      return FeedbackCard(
                                          singleFeedback:
                                              singleFeedback); // Your custom widget
                                    },
                                  ).toList(),
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),

                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.feedscreen);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "See all feedback",
                                      style: AppStyles.textStyle_15_600,
                                    ),
                                    Icon(Icons.arrow_forward)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////
class _AirportListSection extends StatelessWidget {
  final List<Map<String, dynamic>> leaderBoardList;

  final int expandedItems;
  final VoidCallback onExpand;

  const _AirportListSection({
    required this.leaderBoardList,
    required this.expandedItems,
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: leaderBoardList.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> singleAirport = entry.value;
            if (index < expandedItems) {
              return AirportList(
                name: singleAirport['name'],
                isAirline: singleAirport['isAirline'],
                // logo: singleAirport['logo'],
                index: index,
              );
            }
            return const SizedBox.shrink();
          }).toList(),
        ),
        SizedBox(height: 19),
        if (expandedItems < leaderBoardList.length)
          Center(
            child: InkWell(
              onTap: onExpand,
              child: IntrinsicWidth(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Expand more",
                        style:
                            AppStyles.textStyle_18_600.copyWith(fontSize: 15)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_downward),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
