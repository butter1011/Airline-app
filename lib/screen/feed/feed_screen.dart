import 'package:airline_app/controller/get_review_airline_controller.dart';
import 'package:airline_app/controller/get_review_airport_controller.dart';
import 'package:airline_app/screen/app_widgets/bottom_nav_bar.dart';
import 'package:airline_app/screen/app_widgets/custom_search_appbar.dart';
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
  }

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {}

  @override
  // ignore: unused_element
  Widget build(BuildContext context) {
    final reviewList = [];
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
        return false;
      },
      child: KeyboardDismissWidget(
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
            selectedFilterButton: filterType,
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavBar(currentIndex: 1),
          body: Column(
            children: [
              Expanded(
                  child: isLoading
                      ? const LoadingWidget()
                      : SingleChildScrollView(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
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
