import 'package:airline_app/controller/get_review_airport_controller.dart';
import 'package:airline_app/controller/get_airline_score_controller.dart';
import 'package:airline_app/controller/get_airport_score_controller.dart';
import 'package:airline_app/provider/filter_button_provider.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/screen/app_widgets/bottom_nav_bar.dart';
import 'package:airline_app/screen/app_widgets/keyboard_dismiss_widget.dart';
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
import 'package:airline_app/provider/live_feed_review_provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:airline_app/controller/get_airline_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:airline_app/controller/get_review_airline_controller.dart';

final selectedEmojiNumberProvider =
    StateProvider.family<int, String>((ref, feedbackId) => 0);
final selectedEmojiProvider =
    StateProvider.family<int, String>((ref, feedbackId) => 0);
bool _isWebSocketConnected = false;

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
  List<LiveFeedItem> liveFeedItems = [];
  double leftPadding = 24.0;
  String filterType = 'All';
  List<Map<String, dynamic>> leaderBoardList = [];
  Map<String, bool> buttonStates = {
    "All": true,
    "Airline": false,
    "Airport": false,
    "Flight Experience": false,
    "Comfort": false,
    "Cleanliness": false,
    "Onboard": false,
    "Food & Beverage": false,
    "Entertainment & WiFi": false,
    "Accessibility": false,
    "Wait Times": false,
    "Helpfulness": false,
    "Ambience": false,
    "Amenities": false,
  };

  void toggleButton(String buttonText) {
    setState(() {
      buttonStates.updateAll((key, value) => false);
      buttonStates[buttonText] = true;
      filterType = buttonText;
    });
    ref.read(filterButtonProvider.notifier).setFilterType(buttonText);
    ref
        .read(airlineAirportProvider.notifier)
        .getFilteredList(filterType, null, null, null);
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
    // Cancel any pending operations before disposing
    if (mounted) {
      ref.invalidate(reviewsAirlineProvider);
      ref.invalidate(airlineAirportProvider);
      ref.invalidate(filterButtonProvider);
      ref.invalidate(liveFeedProvider);
    }
    super.dispose();
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
      if (futures[4]['success']) {
        ref
            .read(reviewsAirlineProvider.notifier)
            .setReviewData(futures[4]['data']);
      }

      if (!mounted) return;

      ref
          .read(airlineAirportProvider.notifier)
          .getFilteredList("All", null, null, null);

      final ratingList = ref.read(reviewsAirlineProvider).reviews;

      final UserId = ref.read(userDataProvider)?['userData']['_id'];

      for (var ratingreview in ratingList) {
        if (!mounted) return;
        ref
            .read(
                selectedEmojiNumberProvider(ratingreview['_id'] ?? '').notifier)
            .state = ratingreview['rating']?.length ?? 0;
        if (ratingreview['reviewer']?['_id'] == UserId &&
            ratingreview['rating'] != null) {
          ref
              .read(selectedEmojiProvider(ratingreview['_id'] ?? '').notifier)
              .state = ratingreview['rating'][UserId] ?? 0;
        }
      }
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
            final review = jsonData['review'];
            final newFeedItem = LiveFeedItem(
              userName: review['reviewer']['name'] ?? 'Anonymous',
              entityName: jsonData['data'][0]['name'] ?? 'Anonymous',
              type: jsonData['data'][0]['isAirline'] ? 'airline' : 'airport',
              rating: review['score'] ?? 0,
              comment: review['comment'] ?? '',
              timeStamp: jsonData['date'] ?? DateTime.now(),
            );
            ref.read(liveFeedProvider.notifier).addFeedItem(newFeedItem);
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
    final selectedFilterButton = ref.watch(filterButtonProvider);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavBar(
          currentIndex: 0,
        ),
        body: KeyboardDismissWidget(
          child: Column(
            children: [
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
                                .getFilteredList(
                                    filterType, _searchQuery, null, null);
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
                  children: buttonStates.keys.map((buttonText) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: MainButton(
                        text: buttonText,
                        isSelected: buttonText == selectedFilterButton,
                        onTap: () => toggleButton(buttonText),
                      ),
                    );
                  }).toList(),
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
                                  // Text(
                                  //   AppLocalizations.of(context)
                                  //       .translate('Live Feed'),
                                  //   style: AppStyles.textStyle_16_600.copyWith(
                                  //     color: Color(0xff38433E),
                                  //   ),
                                  // ),
                                  // SizedBox(height: 17),
                                  // Container(
                                  //   height: 270,
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.grey[50],
                                  //     borderRadius: BorderRadius.circular(12),
                                  //     border:
                                  //         Border.all(color: Colors.grey[200]!),
                                  //   ),
                                  //   child: Consumer(
                                  //     builder: (context, ref, child) {
                                  //       final liveFeedItems =
                                  //           ref.watch(liveFeedProvider);
                                  //       return liveFeedItems.isEmpty
                                  //           ? Center(
                                  //               child: Column(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment.center,
                                  //                 children: [
                                  //                   Icon(
                                  //                     Icons.feed_outlined,
                                  //                     size: 32,
                                  //                     color: Colors.grey[400],
                                  //                   ),
                                  //                   SizedBox(height: 8),
                                  //                   Text(
                                  //                     'No live feed data available',
                                  //                     style: AppStyles
                                  //                         .textStyle_14_400
                                  //                         .copyWith(
                                  //                       color: Colors.grey[600],
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             )
                                  //           : AnimatedList(
                                  //               key: GlobalKey<
                                  //                   AnimatedListState>(),
                                  //               initialItemCount:
                                  //                   liveFeedItems.length,
                                  //               padding: EdgeInsets.symmetric(
                                  //                   vertical: 8),
                                  //               itemBuilder:
                                  //                   (context, index, animation) {
                                  //                 final item =
                                  //                     liveFeedItems[index];
                                  //                 return SlideTransition(
                                  //                   position: animation.drive(
                                  //                     Tween<Offset>(
                                  //                       begin: Offset(0.0,
                                  //                           -1.0), // Slide from top
                                  //                       end: Offset.zero,
                                  //                     ).chain(CurveTween(
                                  //                         curve: Curves.easeOut)),
                                  //                   ),
                                  //                   child: FadeTransition(
                                  //                     opacity: animation.drive(
                                  //                       Tween<double>(
                                  //                               begin: 0.0,
                                  //                               end: 1.0)
                                  //                           .chain(CurveTween(
                                  //                               curve: Curves
                                  //                                   .easeOut)),
                                  //                     ),
                                  //                     child: Container(
                                  //                       margin:
                                  //                           EdgeInsets.symmetric(
                                  //                               horizontal: 12,
                                  //                               vertical: 4),
                                  //                       padding:
                                  //                           EdgeInsets.all(12),
                                  //                       decoration: BoxDecoration(
                                  //                         color: Colors.white,
                                  //                         borderRadius:
                                  //                             BorderRadius
                                  //                                 .circular(8),
                                  //                         boxShadow: [
                                  //                           BoxShadow(
                                  //                             color: Colors.black
                                  //                                 .withOpacity(
                                  //                                     0.05),
                                  //                             blurRadius: 4,
                                  //                             offset:
                                  //                                 Offset(0, 2),
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                       child: Row(
                                  //                         crossAxisAlignment:
                                  //                             CrossAxisAlignment
                                  //                                 .start,
                                  //                         children: [
                                  //                           Container(
                                  //                             padding:
                                  //                                 EdgeInsets.all(
                                  //                                     8),
                                  //                             decoration:
                                  //                                 BoxDecoration(
                                  //                               color: item.type ==
                                  //                                       'airline'
                                  //                                   ? Colors
                                  //                                       .blue[50]
                                  //                                   : Colors
                                  //                                       .green[50],
                                  //                               borderRadius:
                                  //                                   BorderRadius
                                  //                                       .circular(
                                  //                                           8),
                                  //                             ),
                                  //                             child: Text(
                                  //                               item.type ==
                                  //                                       'airline'
                                  //                                   ? '✈️'
                                  //                                   : '🛫',
                                  //                               style: TextStyle(
                                  //                                   fontSize: 16),
                                  //                             ),
                                  //                           ),
                                  //                           SizedBox(width: 12),
                                  //                           Expanded(
                                  //                             child: Column(
                                  //                               crossAxisAlignment:
                                  //                                   CrossAxisAlignment
                                  //                                       .start,
                                  //                               children: [
                                  //                                 Row(
                                  //                                   mainAxisAlignment:
                                  //                                       MainAxisAlignment
                                  //                                           .spaceBetween,
                                  //                                   children: [
                                  //                                     Expanded(
                                  //                                       child:
                                  //                                           Row(
                                  //                                         children: [
                                  //                                           Text(
                                  //                                             item.userName,
                                  //                                             style:
                                  //                                                 AppStyles.textStyle_14_600.copyWith(
                                  //                                               color: Colors.black87,
                                  //                                             ),
                                  //                                           ),
                                  //                                           Expanded(
                                  //                                             child:
                                  //                                                 Text(
                                  //                                               ' rated ${item.entityName}',
                                  //                                               style: AppStyles.textStyle_14_400.copyWith(
                                  //                                                 color: Colors.black54,
                                  //                                               ),
                                  //                                               overflow: TextOverflow.ellipsis,
                                  //                                             ),
                                  //                                           ),
                                  //                                         ],
                                  //                                       ),
                                  //                                     ),
                                  //                                     Text(
                                  //                                       DateTime.now().difference(item.timeStamp).inMinutes <
                                  //                                               60
                                  //                                           ? '${DateTime.now().difference(item.timeStamp).inMinutes}m ago'
                                  //                                           : DateTime.now().difference(item.timeStamp).inHours < 24
                                  //                                               ? '${DateTime.now().difference(item.timeStamp).inHours}h ago'
                                  //                                               : '${DateTime.now().difference(item.timeStamp).inDays}d ago',
                                  //                                       style: AppStyles
                                  //                                           .textStyle_12_600
                                  //                                           .copyWith(
                                  //                                         color: Colors
                                  //                                             .grey,
                                  //                                       ),
                                  //                                     ),
                                  //                                   ],
                                  //                                 ),
                                  //                                 SizedBox(
                                  //                                     height: 4),
                                  //                                 Row(
                                  //                                   children: [
                                  //                                     Container(
                                  //                                       padding:
                                  //                                           EdgeInsets
                                  //                                               .symmetric(
                                  //                                         horizontal:
                                  //                                             8,
                                  //                                         vertical:
                                  //                                             2,
                                  //                                       ),
                                  //                                       decoration:
                                  //                                           BoxDecoration(
                                  //                                         color: Colors
                                  //                                             .amber[100],
                                  //                                         borderRadius:
                                  //                                             BorderRadius.circular(12),
                                  //                                       ),
                                  //                                       child:
                                  //                                           Text(
                                  //                                         '${item.rating}/10',
                                  //                                         style: AppStyles
                                  //                                             .textStyle_14_600
                                  //                                             .copyWith(
                                  //                                           color:
                                  //                                               Colors.amber[900],
                                  //                                         ),
                                  //                                       ),
                                  //                                     ),
                                  //                                     if (item
                                  //                                         .comment
                                  //                                         .isNotEmpty) ...[
                                  //                                       SizedBox(
                                  //                                           width:
                                  //                                               8),
                                  //                                       Expanded(
                                  //                                         child:
                                  //                                             Text(
                                  //                                           '"${item.comment}"',
                                  //                                           style: AppStyles
                                  //                                               .textStyle_14_400
                                  //                                               .copyWith(
                                  //                                             color:
                                  //                                                 Colors.black54,
                                  //                                             fontStyle:
                                  //                                                 FontStyle.italic,
                                  //                                           ),
                                  //                                           overflow:
                                  //                                               TextOverflow.ellipsis,
                                  //                                         ),
                                  //                                       ),
                                  //                                     ],
                                  //                                   ],
                                  //                                 ),
                                  //                               ],
                                  //                             ),
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 );
                                  //               },
                                  //             );
                                  //     },
                                  //   ),
                                  // ),
                                  SizedBox(height: 28),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('Trending Feedback'),
                                    style: AppStyles.textStyle_16_600.copyWith(
                                      color: Color(0xff38433E),
                                    ),
                                  ),
                                  SizedBox(height: 17),
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
                                              borderRadius: BorderRadius.circular(
                                                  8), // Adjust the border radius as needed
                                              boxShadow: [
                                                // BoxShadow(
                                                //   color: Colors.black
                                                //       .withOpacity(0.1),
                                                //   spreadRadius: 2,
                                                //   blurRadius: 4,
                                                //   offset: Offset(0,
                                                //       2), // changes position of shadow
                                                // ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  8), // Adjust the border radius as needed
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
                            SizedBox(
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
