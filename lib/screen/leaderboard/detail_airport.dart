import 'dart:convert';

import 'package:airline_app/provider/airline_review_data_provider.dart';
import 'package:airline_app/provider/button_expand_provider.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/screen/leaderboard/widgets/category_rating_options.dart';
import 'package:airline_app/screen/leaderboard/widgets/feedback_card.dart';

import 'package:airline_app/screen/leaderboard/widgets/reviewStatus.dart';
import 'package:airline_app/screen/leaderboard/widgets/share_to_social.dart';

import 'package:airline_app/screen/reviewsubmission/reviewsubmission_screen.dart';

import 'package:airline_app/utils/app_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DetailAirport extends ConsumerStatefulWidget {
  const DetailAirport({super.key});

  @override
  ConsumerState<DetailAirport> createState() => _DetailAirportState();
}

class _DetailAirportState extends ConsumerState<DetailAirport> {
  bool _clickedBookmark = false;
  bool isExpanded = false;
  Map<String, List<String>> _bookmarkItems = {};

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? bookmarksJson = prefs.getString('bookmarks');
    if (bookmarksJson != null) {
      setState(() {
        _bookmarkItems = Map<String, List<String>>.from(
          jsonDecode(bookmarksJson).map(
            (key, value) => MapEntry(key, List<String>.from(value)),
          ),
        );
      });
    }
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bookmarks', json.encode(_bookmarkItems));
  }

  Future<void> _sharedBookMarkSaved(String bookMarkId) async {
    final userId = ref.watch(userDataProvider)?['userData']['_id'];

    if (userId != null) {
      setState(() {
        if (!_bookmarkItems.containsKey(userId)) {
          _bookmarkItems[userId] = [];
        }

        if (_clickedBookmark) {
          if (!_bookmarkItems[userId]!.contains(bookMarkId)) {
            _bookmarkItems[userId]!.add(bookMarkId);
          }
        } else {
          _bookmarkItems[userId]!.remove(bookMarkId);
          if (_bookmarkItems[userId]!.isEmpty) {
            _bookmarkItems.remove(userId);
          }
        }
      });

      await _saveBookmarks();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(userDataProvider)?['userData']['_id'];
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    final String name = args['name'];
    final String descriptionBio = args['descriptionBio'];
    final String perksBio = args['perksBio'];
    final String trendingBio = args['trendingBio'];
    final String backgroundImage = args['backgroundImage'];
    final String bookMarkId = args['bookMarkId'];
    final int totalReviews = args['totalReviews'];
    final bool isIncreasing = args['isIncreasing'];
    final num overallScore = args['overall'];
    final airlineReviewLists = ref
        .watch(reviewsAirlineProvider.notifier)
        .getReviewsByBookMarkId(bookMarkId);
    print('🥻🥻🥻👜👝👝👜👛$airlineReviewLists');
    print('🥻🥻🥻$bookMarkId');
    if (userId != null &&
        _bookmarkItems[userId]?.contains(bookMarkId) == true) {
      _clickedBookmark = true;
    }

    // List reviews = airportReviewList[airportIndex]['reviews']['Seat Comfort'];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 315,
            leading: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      backgroundImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            // No color at the top
                            Colors.black.withOpacity(0.8),
                            Colors
                                .transparent, // Gradient color from 30px downwards
                          ],
                          stops: const [
                            0.1,
                            1
                          ], // Adjust stops to control where the gradient starts and ends
                        ),
                      ),
                      // Start the gradient 30px from the top
                    ),
                  ),
                  Positioned(
                    top: 67,
                    right: 12,
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () async {
                              await BottomSheetHelper.showScoreBottomSheet(
                                  context);
                            },
                            icon: Image.asset('assets/icons/share_white.png')),
                        IconButton(
                          onPressed: () {},
                          icon: IconButton(
                            onPressed: () {
                              setState(() {
                                _clickedBookmark = !_clickedBookmark;
                              });
                              _sharedBookMarkSaved(bookMarkId);
                            },
                            iconSize: 30,
                            icon: Icon(
                              _clickedBookmark
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReviewStatus(
                        reviewStatus: isIncreasing,
                        overallScore: overallScore,
                        totalReviews: totalReviews),
                    SizedBox(height: 9),
                    Text(
                      name,
                      style: AppStyles.textStyle_24_600,
                    ),
                    SizedBox(height: 2),
                    Text(
                      descriptionBio,
                      style: AppStyles.textStyle_15_400
                          .copyWith(color: Color(0xff38433E)),
                    ),
                    SizedBox(height: 14),
                    Text(
                      "Trending now:",
                      style: AppStyles.textStyle_14_600,
                    ),
                    Text(
                      trendingBio,
                      style: AppStyles.textStyle_14_400
                          .copyWith(color: Color(0xff38433E)),
                    ),
                    SizedBox(height: 14),
                    Text(
                      "Perks you'll love:",
                      style: AppStyles.textStyle_14_600,
                    ),
                    Text(
                      perksBio,
                      style: AppStyles.textStyle_14_400
                          .copyWith(color: Color(0xff38433E)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Category Ratings',
                          style: AppStyles.textStyle_18_600,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Image.asset('assets/icons/switch.png'))
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ExpandButtons(),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: airlineReviewLists.asMap().entries.map((entry) {
                  final index = entry.key;
                  final singleReview = entry.value;
                  if (singleReview != null) {
                    final reviewer = singleReview['reviewer'];
                    final airline = singleReview['airline'];
                    final from = singleReview['from'];
                    final to = singleReview['to'];

                    if (reviewer != null &&
                        airline != null &&
                        from != null &&
                        to != null) {
                      return Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: FeedbackCard(
                              singleFeedback: singleReview,
                            ),
                          ),
                          if (index != airlineReviewLists.length - 1)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 24.0),
                              child: Column(
                                children: [
                                  Divider(
                                    height: 2,
                                    color: Colors.black,
                                  ),
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
              Container(
                decoration: BoxDecoration(
                  // color: Colors.red,
                  border: Border(
                    top: BorderSide(
                      color: Colors.black.withOpacity(0.8),
                      width: 2,
                    ),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewsubmissionScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: Container(
                      // Diameter of the circular avatar
                      height: 56, // Diameter of the circular avatar
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppStyles.mainColor, // Background color
                        border: Border.all(
                            width: 2, color: Colors.black), // Border color
                        boxShadow: [
                          BoxShadow(color: Colors.black, offset: Offset(2, 2))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Leave a review",
                                style: GoogleFonts.getFont("Schibsted Grotesk",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.3),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Image.asset('assets/icons/edit.png')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}

class ExpandButtons extends ConsumerWidget {
  const ExpandButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isExpanded = ref.watch(buttonExpandNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CategoryRatingOptions(
                      iconUrl: 'assets/icons/review_icon_boarding.png',
                      label: 'Boarding and\nArrival Experience',
                      badgeScore: '10',
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: CategoryRatingOptions(
                      iconUrl: 'assets/icons/review_icon_comfort.png',
                      label: 'Comfort',
                      badgeScore: '10',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: CategoryRatingOptions(
                      iconUrl: 'assets/icons/review_icon_cleanliness.png',
                      label: 'Cleanliness',
                      badgeScore: '10',
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: CategoryRatingOptions(
                      iconUrl: 'assets/icons/review_icon_onboard.png',
                      label: 'Onboard Service',
                      badgeScore: '9',
                    ),
                  ),
                ],
              ),
              Visibility(
                  visible: isExpanded,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CategoryRatingOptions(
                              iconUrl: 'assets/icons/review_icon_food.png',
                              label: 'Food & Beverage',
                              badgeScore: '8',
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: CategoryRatingOptions(
                              iconUrl:
                                  'assets/icons/review_icon_entertainment.png',
                              label: 'In-Flight\nEntertainment',
                              badgeScore: '7',
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(height: 19),
              Center(
                child: InkWell(
                  onTap: () {
                    ref
                        .read(buttonExpandNotifierProvider.notifier)
                        .toggleButton(isExpanded);
                  },
                  child: IntrinsicWidth(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            isExpanded
                                ? "Show less categories"
                                : "Show more categories",
                            style: AppStyles.textStyle_18_600
                                .copyWith(fontSize: 15)),
                        const SizedBox(width: 8),
                        Icon(
                            isExpanded ? Icons.expand_less : Icons.expand_more),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
