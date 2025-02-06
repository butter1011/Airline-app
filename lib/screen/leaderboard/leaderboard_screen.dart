import 'dart:ffi';

import 'package:airline_app/controller/get_review_airport_controller.dart';
import 'package:airline_app/controller/get_airline_score_controller.dart';
import 'package:airline_app/controller/get_airport_score_controller.dart';
import 'package:airline_app/provider/filter_button_provider.dart';
import 'package:airline_app/screen/app_widgets/bottom_nav_bar.dart';
import 'package:airline_app/screen/app_widgets/custom_search_appbar.dart';
import 'package:airline_app/screen/app_widgets/divider_widget.dart';
import 'package:airline_app/screen/app_widgets/keyboard_dismiss_widget.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/screen/app_widgets/search_field.dart';
import 'package:airline_app/screen/leaderboard/widgets/feedback_card.dart';
import 'package:airline_app/screen/leaderboard/widgets/airport_list.dart';
import 'package:airline_app/screen/leaderboard/widgets/mainButton.dart';
import 'package:airline_app/screen/leaderboard/widgets/scoring_info_dialog.dart';
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
import 'package:airline_app/controller/get_review_airline_controller.dart';

bool _isWebSocketConnected = false;

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  final airlineController = GetAirlineAirportController();
  List airlineDataSortedByCleanliness = [];
  List airlineDataSortedByOnboardSevice = [];
  final airlineScoreController = GetAirlineScoreController();
  final airportScoreController = GetAirportScoreController();
  Map<String, bool> buttonStates = {
    "Airline": false,
    "Airport": false,
  };

  int expandedItems = 5;
  String filterType = 'All';
  bool isLeaderboardLoading = true;
  List<Map<String, dynamic>> leaderBoardList = [];
  double leftPadding = 24.0;

  late IOWebSocketChannel _channel;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    _channel.sink.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void toggleButton(String buttonText) {
    setState(() {
      buttonStates.updateAll((key, value) => false);
      buttonStates[buttonText] = true;
      filterType = buttonText;
      expandedItems = 5;
    });
    ref.read(filterButtonProvider.notifier).setFilterType(buttonText);
    ref
        .read(airlineAirportProvider.notifier)
        .getFilteredList(filterType, null, null, null);
  }

  Future<void> fetchLeaderboardData() async {
    if (!mounted) return;

    final airlineReviewController = GetReviewAirlineController();
    final airportReviewController = GetReviewAirportController();

    try {
      final futures = await Future.wait([
        airlineReviewController.getAirlineReviews(),
        airlineController.getAirlineAirport(),
        airlineScoreController.getAirlineScore(),
        airportScoreController.getAirportScore(),
        airportReviewController.getAirportReviews(),
      ]);

      if (!mounted) return;

      if (futures[0]['success']) {
        ref
            .read(reviewsAirlineAirportProvider.notifier)
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
      if (futures[4]['success']) {
        ref
            .read(reviewsAirlineAirportProvider.notifier)
            .setReviewData(futures[4]['data']);
      }

      if (!mounted) return;

      ref
          .read(airlineAirportProvider.notifier)
          .getFilteredList("All", null, null, null);
    } catch (e) {
      print('Error fetching leaderboard data: $e');
    }
  }

  Future<void> connectWebSocket() async {
    if (_isWebSocketConnected) return;

    try {
      _channel = IOWebSocketChannel.connect(Uri.parse('ws://$backendUrl/ws'));
      _channel.stream.listen(
        (data) {
          final jsonData = jsonDecode(data);
          if (jsonData['type'] == 'airlineAirport') {
            ref
                .read(airlineAirportProvider.notifier)
                .setData(Map<String, dynamic>.from(jsonData));
            ref
                .read(airlineAirportProvider.notifier)
                .getFilteredList(filterType, _searchQuery, null, null);

            setState(() {});
          }
        },
        onError: (_) {
          _isWebSocketConnected = false;
        },
        onDone: () {
          _isWebSocketConnected = false;
        },
      );
      _isWebSocketConnected = true;
    } catch (_) {
      _isWebSocketConnected = false;
    }
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
        ref.watch(reviewsAirlineAirportProvider.notifier).getTopFiveReviews();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomSearchAppBar(
          searchController: _searchController,
          filterType: filterType,
          onSearchChanged: (value) {
            setState(() {
              _searchQuery = value.toLowerCase();
            });
            ref
                .read(airlineAirportProvider.notifier)
                .getFilteredList(filterType, _searchQuery, null, null);
          },
          buttonStates: buttonStates,
          onButtonToggle: toggleButton,
          selectedFilterButton: ref.watch(filterButtonProvider),
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: const BottomNavBar(
          currentIndex: 0,
        ),
        body: KeyboardDismissWidget(
          child: Column(
            children: [
              Expanded(
                child: isLeaderboardLoading
                    ? const Center(
                        child: LoadingWidget(),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('Top Ranked  Airlines'),
                                        style:
                                            AppStyles.textStyle_16_600.copyWith(
                                          color: const Color(0xff38433E),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.info_outline),
                                        onPressed: () {
                                          final RenderBox button = context
                                              .findRenderObject() as RenderBox;
                                          final Offset offset =
                                              button.localToGlobal(Offset.zero);
                                          showDialog(
                                            context: context,
                                            barrierColor: Colors.transparent,
                                            builder: (BuildContext context) {
                                              return ScoringInfoDialog(
                                                  offset: offset);
                                            },
                                          );
                                        },
                                      ),
                                    ],
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
                                  const SizedBox(height: 28),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('Trending Feedback'),
                                    style: AppStyles.textStyle_16_600.copyWith(
                                      color: const Color(0xff38433E),
                                    ),
                                  ),
                                  const SizedBox(height: 17),
                                ],
                              ),
                            ),
                            NotificationListener<ScrollNotification>(
                              onNotification: (scrollNotification) {
                                if (scrollNotification
                                    is ScrollUpdateNotification) {
                                  setState(() {
                                    leftPadding =
                                        scrollNotification.metrics.pixels > 0
                                            ? 0
                                            : 24.0;
                                  });
                                }
                                return true;
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: leftPadding),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: trendingreviews.map(
                                      (singleFeedback) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 16),
                                          child: Container(
                                            width: 299,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: FeedbackCard(
                                                thumbnailHeight: 189,
                                                singleFeedback: singleFeedback,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
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
                                  const Icon(Icons.arrow_forward)
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AirportListSection extends StatelessWidget {
  const _AirportListSection({
    required this.leaderBoardList,
    required this.expandedItems,
    required this.onExpand,
  });

  final int expandedItems;
  final List<Map<String, dynamic>> leaderBoardList;
  final VoidCallback onExpand;

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
