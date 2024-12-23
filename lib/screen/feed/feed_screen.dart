import 'package:airline_app/controller/airline_review_controller.dart';
import 'package:airline_app/controller/airport_review_controller.dart';
import 'package:airline_app/controller/get_airline_score_controller.dart';
import 'package:airline_app/controller/get_airport_score_controller.dart';
import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:airline_app/screen/app_widgets/bottom_nav_bar.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';

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
  late bool selectedAll = true;
  late bool selectedAirline = false;
  late bool selectedAirport = false;
  late bool selectedCleanliness = false;
  late bool selectedOnboard = false;
  bool isLoading = false;
  String filterType = 'All';
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
    ref
        .read(reviewsAirlineProvider.notifier)
        .getFilteredReviews(filterType, null, null, null);
    ref.read(reviewsAirlineProvider.notifier).getAirlineReviewsWithScore();
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

    final reviewAirlineController = AirlineReviewController();
    final airlineResult = await reviewAirlineController.getAirlineReviews();
    if (airlineResult['success']) {
      ref
          .read(reviewsAirlineProvider.notifier)
          .setReviewData(airlineResult['data']);
    }
    final reviewAirportController = AirportReviewController();
    final airportResult = await reviewAirportController.getAirportReviews();
    if (airportResult['success']) {
      ref
          .read(reviewsAirlineProvider.notifier)
          .setReviewData(airportResult['data']);
    }
    final airlineScoreController = GetAirlineScoreController();
    final airportScoreController = GetAirportScoreController();
    final airlineScore = await airlineScoreController.getAirlineScore();
    if (airlineScore['success']) {
      ref
          .read(reviewsAirlineProvider.notifier)
          .setAirlineScoreData(airlineScore['data']['data']);
    }
    final airportScore = await airportScoreController.getAirportScore();
    if (airportScore['success']) {
      ref
          .read(reviewsAirlineProvider.notifier)
          .setAirportScoreData(airportScore['data']['data']);
    }

    ref
        .read(reviewsAirlineProvider.notifier)
        .getFilteredReviews("All", null, null, null);

    setState(() {
      isLoading = false;
    });
  }

  @override
  // ignore: unused_element
  Widget build(BuildContext context) {
    final reviewList = ref.watch(reviewsAirlineProvider).filteredReviews;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
        return false;
      },
      child: Scaffold(
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
                      Navigator.pushNamed(context, AppRoutes.feedfilterscreen);
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
                      isSelected: buttonStates[buttonText]!,
                      onTap: () => toggleButton(buttonText),
                    ),
                  );
                }).toList(), 
              ),
            ),
            const SizedBox(height: 14),
            Container(height: 4, color: AppStyles.littleBlackColor),
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
                                      : reviewList.asMap().entries.map((entry) {
                                          final index = entry.key;
                                          final singleReview = entry.value;
                                          if (singleReview != null) {
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
    );
  }
}
