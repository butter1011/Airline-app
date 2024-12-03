import 'dart:convert';

import 'package:airline_app/provider/button_expand_provider.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/screen/leaderboard/widgets/category_rating_options.dart';
import 'package:airline_app/screen/leaderboard/widgets/reviewStatus.dart';
import 'package:airline_app/screen/leaderboard/widgets/share_to_social.dart';
import 'package:airline_app/screen/reviewsubmission/reviewsubmission_screen.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  Map<String, List<String>> _bookmarkItems = {};
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadBookmarks();
  }

  void _loadBookmarks() {
    final String? bookmarksJson = _prefs.getString('bookmarks');
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
    await _prefs.setString('bookmarks', json.encode(_bookmarkItems));
  }

  Future<void> _sharedBookMarkSaved(String bookMarkId) async {
    final userId = ref.read(userDataProvider)?['userData']['_id'];

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
    final Map<String, dynamic> airportData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final userId = ref.read(userDataProvider)?['userData']['_id'];

    if (userId != null &&
        _bookmarkItems[userId]?.contains(airportData['_id']) == true) {
      _clickedBookmark = true;
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 315,
            leading: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: airportData['backgroundImage'],
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 315,
                          color: AppStyles.mainColor.withOpacity(0.5),
                          child: Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ), //   airportData['backgroundImage'],
                    //   fit: BoxFit.cover,
                    //   cacheWidth: 1080,
                    // ),
                  ),
                  Positioned(
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                          stops: const [0.1, 1],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 67,
                    right: 12,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () async =>
                              await BottomSheetHelper.showScoreBottomSheet(
                                  context),
                          icon: Image.asset('assets/icons/share_white.png'),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _clickedBookmark = !_clickedBookmark;
                            });
                            _sharedBookMarkSaved(airportData['_id']);
                          },
                          iconSize: 30,
                          icon: Icon(
                            _clickedBookmark
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: Colors.white,
                          ),
                        ),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReviewStatus(
                      reviewStatus: airportData['isIncreasing'],
                      overallScore: airportData['overall'],
                      totalReviews: airportData['totalReviews'],
                    ),
                    const SizedBox(height: 9),
                    Text(
                      airportData['name'],
                      style: AppStyles.textStyle_24_600,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      airportData['descriptionBio'],
                      style: AppStyles.textStyle_15_400
                          .copyWith(color: const Color(0xff38433E)),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Trending now:",
                      style: AppStyles.textStyle_14_600,
                    ),
                    Text(
                      airportData['trendingBio'],
                      style: AppStyles.textStyle_14_400
                          .copyWith(color: const Color(0xff38433E)),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Perks you'll love:",
                      style: AppStyles.textStyle_14_600,
                    ),
                    Text(
                      airportData['perksBio'],
                      style: AppStyles.textStyle_14_400
                          .copyWith(color: const Color(0xff38433E)),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Category Ratings',
                          style: AppStyles.textStyle_18_600,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/icons/switch.png'),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    CategoryButtons(
                      isAirline: airportData['isAirline'],
                      airportData: airportData,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
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
                        builder: (context) => const ReviewsubmissionScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppStyles.mainColor,
                        border: Border.all(width: 2, color: Colors.black),
                        boxShadow: const [
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
                                style: GoogleFonts.schibstedGrotesk(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(width: 8),
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

class CategoryButtons extends ConsumerWidget {
  final bool isAirline;
  final Map airportData;

  const CategoryButtons(
      {super.key, required this.isAirline, required this.airportData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(buttonExpandNotifierProvider);

    Widget buildCategoryRow(String iconUrl, String label, String badgeScore) {
      return Expanded(
        child: CategoryRatingOptions(
          iconUrl: iconUrl,
          label: label,
          badgeScore: badgeScore,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                isAirline
                    ? buildCategoryRow(
                        'assets/icons/review_icon_boarding.png',
                        'Boarding and\nArrival Experience',
                        airportData['departureArrival'].round().toString())
                    : buildCategoryRow(
                        'assets/icons/review_icon_access.png',
                        'Accessibility',
                        airportData['accessibility'].round().toString()),
                const SizedBox(width: 16),
                isAirline
                    ? buildCategoryRow('assets/icons/review_icon_comfort.png',
                        'Comfort', airportData['comfort'].round().toString())
                    : buildCategoryRow(
                        'assets/icons/review_icon_wait.png',
                        'Wait Times',
                        airportData['waitTimes'].round().toString()),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                isAirline
                    ? buildCategoryRow(
                        'assets/icons/review_icon_cleanliness.png',
                        'Cleanliness',
                        airportData['cleanliness'].round().toString())
                    : buildCategoryRow(
                        'assets/icons/review_icon_help.png',
                        'Helpfulness/Ease of Travel',
                        airportData['helpfulness'].round().toString()),
                const SizedBox(width: 16),
                isAirline
                    ? buildCategoryRow(
                        'assets/icons/review_icon_onboard.png',
                        'Onboard Service',
                        airportData['onboardService'].round().toString())
                    : buildCategoryRow(
                        'assets/icons/review_icon_ambience.png',
                        'Ambience/Comfort',
                        airportData['ambienceComfort'].round().toString()),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  isAirline
                      ? buildCategoryRow(
                          'assets/icons/review_icon_food.png',
                          'Food & Beverage',
                          airportData['foodBeverage'].round().toString())
                      : buildCategoryRow(
                          'assets/icons/review_icon_food.png',
                          'Food & Beverage and Shopping',
                          airportData['foodBeverage'].round().toString()),
                  const SizedBox(width: 16),
                  isAirline
                      ? buildCategoryRow(
                          'assets/icons/review_icon_entertainment.png',
                          'In-Flight\nEntertainment',
                          airportData['entertainmentWifi'].round().toString())
                      : buildCategoryRow(
                          'assets/icons/review_icon_entertainment.png',
                          'Amenities and Facilities',
                          airportData['amenities'].round().toString()),
                ],
              ),
            ],
            const SizedBox(height: 19),
            InkWell(
              onTap: () => ref
                  .read(buttonExpandNotifierProvider.notifier)
                  .toggleButton(isExpanded),
              child: IntrinsicWidth(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        isExpanded
                            ? "Show less categories"
                            : "Show more categories",
                        style:
                            AppStyles.textStyle_18_600.copyWith(fontSize: 15)),
                    const SizedBox(width: 8),
                    Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
