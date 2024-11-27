import 'package:airline_app/screen/app_widgets/bottom_nav_bar.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/screen/leaderboard/widgets/feedback_card.dart';
import 'package:airline_app/screen/leaderboard/widgets/airport_list.dart';
import 'package:airline_app/screen/leaderboard/widgets/mainButton.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:airline_app/utils/global_variable.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/airline_review_data_provider.dart';

import 'package:airline_app/controller/get_reviews_airline_controller.dart';

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  int expandedItems = 5;
  late IOWebSocketChannel _channel;
  bool isLeaderboardLoading = true;

  @override
  void initState() {
    super.initState();
    connectWebSocket();
    fetchLeaderboardData();
    setState(() {
      isLeaderboardLoading = false;
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  Future<void> fetchLeaderboardData() async {
    final reviewsController = GetReviewsAirlineController();
    final reviewsResult = await reviewsController.getReviews();
    if (reviewsResult['success']) {
      ref
          .read(reviewsAirlineProvider.notifier)
          .setReviews(reviewsResult['data']);
    }
  }

  Future<void> connectWebSocket() async {
    try {
      _channel = IOWebSocketChannel.connect(
        Uri.parse('ws://$backendUrl/ws'),
      );

      print('WebSocket connected');

      _channel.stream.listen((message) {
        final data = json.decode(message);
        if (data['type'] == 'airlineAirport') {
          ref
              .read(airlineAirportProvider.notifier)
              .setData(Map<String, dynamic>.from(data));
        }
      }, onError: (error) {
        print("WebSocket error: $error");
      }, onDone: () {
        print("WebSocket connection closed");
      });
    } catch (e) {
      print("Error connecting to WebSocket: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final airlineAirportState = ref.watch(airlineAirportProvider);
    final reviews = ref.watch(reviewsAirlineProvider);

    final List<Map<String, dynamic>> leaderBoardList = [
      ...airlineAirportState.airlineData
          .map((e) => Map<String, dynamic>.from(e)),
      ...airlineAirportState.airportData
          .map((e) => Map<String, dynamic>.from(e)),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
      ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context).translate('Filter by category'),
                  style:
                      AppStyles.textStyle_15_500.copyWith(color: Colors.black),
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
                ),
                SizedBox(width: 8),
                MainButton(
                  text: "Airline",
                ),
                SizedBox(width: 8),
                MainButton(
                  text: "Airport",
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
          Expanded(
            child: isLeaderboardLoading
                ? Center(
                    child: LoadingWidget(),
                  )
                : SingleChildScrollView(
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
                                AppLocalizations.of(context)
                                    .translate('Trending Airlines & Airports'),
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
                              ),
                              SizedBox(height: 28),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('Trending Feedback'),
                                style: AppStyles.textStyle_16_600.copyWith(
                                  color: Color(0xff38433E),
                                ),
                              ),
                              SizedBox(height: 17),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: reviews.map(
                                    (singleFeedback) {
                                      return SizedBox(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 16),
                                          child: SizedBox(
                                            width: 299,
                                            child: FeedbackCard(
                                                singleFeedback: singleFeedback),
                                          ),
                                        ),
                                      );
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
                                      AppLocalizations.of(context)
                                          .translate('See all feedback'),
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
                isIncreasing: singleAirport['isIncreasing'],
                totalReviews: singleAirport['totalReviews'],
                logoImage: singleAirport['logoImage'],
                perksBio: singleAirport['perksBio'],
                trendingBio: singleAirport['trendingBio'],
                backgroundImage: singleAirport['backgroundImage'],
                descriptionBio: singleAirport['descriptionBio'],
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
                    Text(AppLocalizations.of(context).translate('Expand more'),
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
