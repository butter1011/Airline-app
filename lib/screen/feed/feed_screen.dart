import 'package:airline_app/controller/get_review_airline_controller.dart';
import 'package:airline_app/controller/get_review_airport_controller.dart';
import 'package:airline_app/controller/get_airline_score_controller.dart';
import 'package:airline_app/controller/get_airport_score_controller.dart';
import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:airline_app/screen/app_widgets/bottom_nav_bar.dart';
import 'package:airline_app/screen/app_widgets/divider_widget.dart';
import 'package:airline_app/screen/app_widgets/keyboard_dismiss_widget.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/screen/app_widgets/search_field.dart';

import 'package:airline_app/screen/leaderboard/widgets/feedback_card.dart';
import 'package:airline_app/screen/leaderboard/widgets/mainButton.dart';
import 'package:airline_app/utils/app_localizations.dart';
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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late bool selectedAll = true;
  late bool selectedAirline = false;
  late bool selectedAirport = false;
  late bool selectedCleanliness = false;
  late bool selectedOnboard = false;
  bool isLoading = false;
  String filterType = 'All';
  Map<String, bool> buttonStates = {
    // "All": true,
    "Airline": false,
    "Airport": false,
  };
  void toggleButton(String buttonText) {
    setState(() {
      buttonStates.updateAll((key, value) => false);
      buttonStates[buttonText] = true;
      filterType = buttonText;
    });
    ref
        .read(reviewsAirlineAirportProvider.notifier)
        .getFilteredReviews(filterType, null, null, null);
    ref
        .read(reviewsAirlineAirportProvider.notifier)
        .getAirlineReviewsWithScore();
  }

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    setState(() {
      isLoading = true;
    });

    final reviewAirlineController = GetReviewAirlineController();
    final airlineResult = await reviewAirlineController.getAirlineReviews();
    if (airlineResult['success']) {
      ref
          .read(reviewsAirlineAirportProvider.notifier)
          .setReviewData(airlineResult['data']);
    }
    final reviewAirportController = GetReviewAirportController();
    final airportResult = await reviewAirportController.getAirportReviews();
    if (airportResult['success']) {
      ref
          .read(reviewsAirlineAirportProvider.notifier)
          .setReviewData(airportResult['data']);
    }
    final airlineScoreController = GetAirlineScoreController();
    final airportScoreController = GetAirportScoreController();
    final airlineScore = await airlineScoreController.getAirlineScore();
    if (airlineScore['success']) {
      ref
          .read(reviewsAirlineAirportProvider.notifier)
          .setAirlineScoreData(airlineScore['data']['data']);
    }
    final airportScore = await airportScoreController.getAirportScore();
    if (airportScore['success']) {
      ref
          .read(reviewsAirlineAirportProvider.notifier)
          .setAirportScoreData(airportScore['data']['data']);
    }

    ref
        .read(reviewsAirlineAirportProvider.notifier)
        .getFilteredReviews("All", null, null, null);

    setState(() {
      isLoading = false;
    });
  }

  @override
  // ignore: unused_element
  Widget build(BuildContext context) {
    final reviewList = ref.watch(reviewsAirlineAirportProvider).filteredReviews;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
        return false;
      },
      child: KeyboardDismissWidget(
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavBar(currentIndex: 1),
          body: Column(
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
                    SearchBarWidget(
                      searchController: _searchController,
                      filterType: filterType,
                      onSearchChanged: (value) {
                        setState(() {
                          _searchQuery = value.toLowerCase();
                        });
                        ref
                            .read(reviewsAirlineAirportProvider.notifier)
                            .getFilteredReviews(
                                filterType, _searchQuery, null, null);
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.feedfilterscreen);
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: buttonStates.keys.map((buttonText) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: MainButton(
                        text: buttonText,
                        isSelected: buttonStates[buttonText]!,
                        onTap: () => toggleButton(buttonText),
                      ),
                    );
                  }).toList(),
                ),
              ),
              DividerWidget(),
              Expanded(
                  child: isLoading
                      ? const LoadingWidget()
                      : SingleChildScrollView(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Column(
                                    children: reviewList.isEmpty
                                        ? [
                                            Text(
                                              "No reviews available",
                                              style: AppStyles.textStyle_14_600,
                                            )
                                          ]
                                        : reviewList
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                            final index = entry.key;
                                            final singleReview = entry.value;
                                            final reviewer =
                                                singleReview['reviewer'];
                                            final airline =
                                                singleReview['airline'];

                                            if (reviewer != null &&
                                                airline != null) {
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 24.0),
                                                    child: FeedbackCard(
                                                      thumbnailHeight: 260,
                                                      singleFeedback:
                                                          singleReview,
                                                    ),
                                                  ),
                                                  if (index !=
                                                      reviewList.length - 1)
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 24.0),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 9,
                                                          ),
                                                          Divider(
                                                            thickness: 2,
                                                            color: Colors.black,
                                                          ),
                                                          SizedBox(
                                                            height: 24,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              );
                                            }
                                            return const SizedBox.shrink();
                                          }).toList(),
                                  ),
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
        ),
      ),
    );
  }
}
