import 'package:airline_app/provider/button_expand_provider.dart';
import 'package:airline_app/screen/app_widgets/bottom_nav_bar.dart';
import 'package:airline_app/screen/leaderboard/widgets/feedback_card.dart';
import 'package:airline_app/screen/leaderboard/widgets/airport_list.dart';
import 'package:airline_app/screen/leaderboard/widgets/mainButton.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<Map<String, dynamic>> airportReviewList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAirportLineList();
  }

  Future<void> fetchAirportLineList() async {
    final response = await http.get(Uri.parse(
        'https://airline-backend-pi.vercel.app/api/v2/airline-airport'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        airportReviewList = List<Map<String, dynamic>>.from(data);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load airport reviews');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
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
                                  airportReviewList:
                                      airportReviewList), // Your custom widget
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
                                  children: trendingFeedbackList.map(
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
  final List<Map<String, dynamic>> airportReviewList;
  const _AirportListSection({required this.airportReviewList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: airportReviewList.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> singleAirport = entry.value;
            if (index < 5) {
              return AirportList(
                country: singleAirport['country'],
                reviewStatus: singleAirport['reviewStatus'],
                logo: singleAirport['logo'],
                index: index,
              );
            }
            return const SizedBox.shrink();
          }).toList(),
        ),
        SizedBox(height: 19),
        Center(
          child: InkWell(
            onTap: () {
              // Expand more logic
            },
            child: IntrinsicWidth(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Expand more",
                      style: AppStyles.textStyle_18_600.copyWith(fontSize: 15)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_downward),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
