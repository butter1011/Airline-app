import 'package:airline_app/controller/get_airline_score_controller.dart';
import 'package:airline_app/controller/get_airport_score_controller.dart';
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
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:airline_app/controller/get_airline_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/airline_airport_review_provider.dart';

import 'package:airline_app/controller/get_reviews_airline_controller.dart';

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int expandedItems = 5;
  late IOWebSocketChannel _channel;
  bool isLeaderboardLoading = true;
  final airlineController = GetAirlineAirportController();
  final airlineScoreController = GetAirlineScoreController();
  final airportScoreController = GetAirportScoreController();
  List airlineDataSortedByCleanliness = [];
  List airlineDataSortedByOnboardSevice = [];

  String filterType = 'All';
  List<Map<String, dynamic>> leaderBoardList = [];
  Map<String, bool> buttonStates = {
    "All": true,
    "Airline": false,
    "Airport": false,
    "Cleanliness": false,
    "Onboard": false,
  };

  void toggleButton(String buttonText) {
    setState(() {
      buttonStates.updateAll((key, value) => false);
      buttonStates[buttonText] = true;
      filterType = buttonText;
    });
    ref
        .read(airlineAirportProvider.notifier)
        .getFilteredList(filterType, null, null);
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await Future.wait([
      connectWebSocket(),
      fetchLeaderboardData(),
    ]);
    setState(() {
      isLeaderboardLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _channel.sink.close();
    super.dispose();
  }

  Future<void> fetchLeaderboardData() async {
    final reviewsController = GetReviewsAirlineController();
    final futures = await Future.wait([
      reviewsController.getReviews(),
      airlineController.getAirlineAirport(),
      airlineScoreController.getAirlineScore(),
      airportScoreController.getAirportScore(),
    ]);

    if (futures[0]['success']) {
      ref
          .read(reviewsAirlineProvider.notifier)
          .setReviewData(futures[0]['data']);
    }
    if (futures[1]['success']) {
      ref.read(airlineAirportProvider.notifier).setData(futures[1]['data']);
    }
    if (futures[2]['success']) {
      ref
          .read(airlineAirportProvider.notifier)
          .setAirlineScoreData(futures[2]['data']['data']);
    }
    if (futures[3]['success']) {
      ref
          .read(airlineAirportProvider.notifier)
          .setAirportScoreData(futures[3]['data']['data']);
    }

    ref
        .read(airlineAirportProvider.notifier)
        .getFilteredList("All", null, null);
  }

  Future<void> connectWebSocket() async {
    try {
      _channel = IOWebSocketChannel.connect(Uri.parse('ws://$backendUrl/ws'));
      _channel.stream.listen(
        (message) {
          final data = json.decode(message);
          if (data['type'] == 'airlineAirport') {
            ref
                .read(airlineAirportProvider.notifier)
                .setData(Map<String, dynamic>.from(data));
            // Add setState to trigger UI refresh
            ref
                .read(airlineAirportProvider.notifier)
                .getFilteredList(filterType, _searchQuery, null);
            
            setState(() {});
          }
        },
        onError: (_) {},
        onDone: () {},
      );
    } catch (_) {}
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  SystemNavigator.pop(animated: true);
                  _goToHomeScreen();
                },
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void _goToHomeScreen() {
    SystemNavigator.pop();
    SystemChannels.platform.invokeMethod('SystemNavigator.home');
  }

  @override
  Widget build(BuildContext context) {
    final trendingreviews =
        ref.watch(reviewsAirlineProvider.notifier).getTopFiveReviews();

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                    child: Center(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.toLowerCase();
                          });
                          ref
                              .read(airlineAirportProvider.notifier)
                              .getFilteredList(filterType, _searchQuery, null);
                        },
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
                    AppLocalizations.of(context)
                        .translate('Filter by category'),
                    style: AppStyles.textStyle_15_500
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MainButton(
                    text: "All",
                    isSelected: buttonStates["All"]!,
                    onTap: () => toggleButton("All"),
                  ),
                  SizedBox(width: 8),
                  MainButton(
                    text: "Airline",
                    isSelected: buttonStates["Airline"]!,
                    onTap: () => toggleButton("Airline"),
                  ),
                  SizedBox(width: 8),
                  MainButton(
                    text: "Airport",
                    isSelected: buttonStates["Airport"]!,
                    onTap: () => toggleButton("Airport"),
                  ),
                  SizedBox(width: 8),
                  MainButton(
                    text: "Cleanliness",
                    isSelected: buttonStates["Cleanliness"]!,
                    onTap: () => toggleButton("Cleanliness"),
                  ),
                  SizedBox(width: 8),
                  MainButton(
                    text: "Onboard",
                    isSelected: buttonStates["Onboard"]!,
                    onTap: () => toggleButton("Onboard"),
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
                                  AppLocalizations.of(context).translate(
                                      'Trending Airlines & Airports'),
                                  style: AppStyles.textStyle_16_600.copyWith(
                                    color: Color(0xff38433E),
                                  ),
                                ),
                                _AirportListSection(
                                  leaderBoardList: ref
                                      .watch(airlineAirportProvider)
                                      .filteredList,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: trendingreviews.map(
                                      (singleFeedback) {
                                        return SizedBox(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 16),
                                            child: SizedBox(
                                              width: 299,
                                              child: FeedbackCard(
                                                  singleFeedback:
                                                      singleFeedback),
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
    return leaderBoardList.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Center(
              child: Text(
                'Nothing to show here',
                style: AppStyles.textStyle_14_600,
              ),
            ),
          )
        : Column(
            children: [
              Column(
                children: leaderBoardList.asMap().entries.map((entry) {
                  int index = entry.key;

                  Map<String, dynamic> singleAirport = entry.value;
                  if (index < expandedItems) {
                    return AirportList(
                      airportData: {
                        ...singleAirport,
                        'index': index,
                      },
                    );
                  }
                  return const SizedBox.shrink();
                }).toList(),
              ),
              SizedBox(height: 19),
              if (expandedItems < leaderBoardList.length)
                Center(
                  child: GestureDetector(
                    onTap: onExpand,
                    child: IntrinsicWidth(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              AppLocalizations.of(context)
                                  .translate('Expand more'),
                              style: AppStyles.textStyle_18_600
                                  .copyWith(fontSize: 15)),
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
