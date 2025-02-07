import 'package:airline_app/controller/get_review_airport_controller.dart';
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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/controller/get_review_airline_controller.dart';
import 'package:airline_app/provider/filter_button_provider.dart';
import 'package:airline_app/provider/leaderboard_filter_provider.dart';
import 'package:airline_app/controller/leaderboard_service.dart';

bool _isWebSocketConnected = false;

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  List airlineDataSortedByCleanliness = [];
  List airlineDataSortedByOnboardSevice = [];
  bool hasMore = true;
  bool isLoading = false;
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
    // _channel.sink.close();
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

    // Update filter type in providers
    ref.read(filterButtonProvider.notifier).setFilterType(buttonText);
    ref.read(leaderboardFilterProvider.notifier).setFilters(
          airType: buttonText,
          flyerClass: ref.read(leaderboardFilterProvider).flyerClass,
          category: ref.read(leaderboardFilterProvider).category,
          continents: ref.read(leaderboardFilterProvider).continents,
        );

    // Fetch new data with updated filter
    fetchLeaderboardData(page: 1);
  }

  Future<void> fetchLeaderboardData({int? page}) async {
    setState(() {
      isLoading = true;
    });
    final LeaderboardService _leaderboardService = LeaderboardService();
    final filterState = ref.read(leaderboardFilterProvider);

    try {
      final result = await _leaderboardService.getFilteredLeaderboard(
        airType: filterState.airType,
        flyerClass: filterState.flyerClass,
        category: filterState.category,
        continents: filterState.continents,
        page: page ?? filterState.currentPage, // Use page from provider
      );

      if (page == 1) {
        ref.read(airlineAirportProvider.notifier).setData(result);
      } else {
        ref.read(airlineAirportProvider.notifier).appendData(result);
      }

      setState(() {
        hasMore = result['hasMore'];
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching leaderboard data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Handle load more data
  void loadMoreData() {
    if (hasMore) {
      // Increment page in provider
      ref.read(leaderboardFilterProvider.notifier).incrementPage();
      fetchLeaderboardData();
    }
  }

  // Future<void> connectWebSocket() async {
  //   if (_isWebSocketConnected) return;

  //   try {
  //     _channel = IOWebSocketChannel.connect(Uri.parse('ws://$backendUrl/ws'));
  //     _channel.stream.listen(
  //       (data) {
  //         final jsonData = jsonDecode(data);
  //         if (jsonData['type'] == 'airlineAirport') {
  //           ref
  //               .read(airlineAirportProvider.notifier)
  //               .setData(Map<String, dynamic>.from(jsonData));
  //           setState(() {});
  //         }
  //       },
  //       onError: (_) {
  //         _isWebSocketConnected = false;
  //       },
  //       onDone: () {
  //         _isWebSocketConnected = false;
  //       },
  //     );
  //     _isWebSocketConnected = true;
  //   } catch (_) {
  //     _isWebSocketConnected = false;
  //   }
  // }

  Future<void> _initializeData() async {
    await Future.wait([
      // connectWebSocket(),
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
    final trendingreviews = [];

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
          },
          buttonStates: buttonStates,
          onButtonToggle: toggleButton,
          selectedFilterButton: ref.watch(filterButtonProvider),
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: const BottomNavBar(
          currentIndex: 0,
        ),
        body: Stack(
          children: [
            KeyboardDismissWidget(
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                    'Top Ranked  Airlines'),
                                            style: AppStyles.textStyle_16_600
                                                .copyWith(
                                              color: const Color(0xff38433E),
                                            ),
                                          ),
                                          IconButton(
                                            icon:
                                                const Icon(Icons.info_outline),
                                            onPressed: () {
                                              final RenderBox button =
                                                  context.findRenderObject()
                                                      as RenderBox;
                                              final Offset offset = button
                                                  .localToGlobal(Offset.zero);
                                              showDialog(
                                                context: context,
                                                barrierColor:
                                                    Colors.transparent,
                                                builder:
                                                    (BuildContext context) {
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
                                            .allData,
                                        expandedItems: expandedItems,
                                        onExpand: () {
                                          setState(() {
                                            expandedItems += 5;
                                          });
                                        },
                                        hasMore: hasMore,
                                        loadMoreData: loadMoreData,
                                      ),
                                      const SizedBox(height: 28),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('Trending Feedback'),
                                        style:
                                            AppStyles.textStyle_16_600.copyWith(
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
                                            scrollNotification.metrics.pixels >
                                                    0
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
                                              padding: const EdgeInsets.only(
                                                  right: 16),
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
                                                    singleFeedback:
                                                        singleFeedback,
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
            if (isLoading)
              Container(
                color: Colors.grey.withOpacity(0.2),
                child: const Center(
                  child: LoadingWidget(),
                ),
              ),
          ],
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
    required this.hasMore,
    required this.loadMoreData,
  });

  final int expandedItems;
  final List<Map<String, dynamic>> leaderBoardList;
  final VoidCallback onExpand;
  final bool hasMore;
  final VoidCallback loadMoreData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: leaderBoardList.map((singleAirport) {
            return AirportList(
              airportData: singleAirport,
            );
          }).toList(),
        ),
        const SizedBox(height: 19),
        if (hasMore)
          Center(
            child: GestureDetector(
              onTap: loadMoreData,
              child: IntrinsicWidth(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context).translate('Expand more'),
                        style:
                            AppStyles.textStyle_18_600.copyWith(fontSize: 15)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_downward),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
