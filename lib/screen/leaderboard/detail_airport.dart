import 'package:airline_app/provider/button_expand_provider.dart';
import 'package:airline_app/screen/leaderboard/widgets/category_rating_options.dart';
import 'package:airline_app/screen/leaderboard/widgets/category_reviews.dart';
import 'package:airline_app/screen/leaderboard/widgets/reviewStatus.dart';
import 'package:airline_app/screen/leaderboard/widgets/share_to_social.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailAirport extends StatefulWidget {
  const DetailAirport({super.key});

  @override
  State<DetailAirport> createState() => _DetailAirportState();
}

class _DetailAirportState extends State<DetailAirport> {
  bool _clickedBoolmark = false;
  bool isExpanded = false;
  late int airportIndex = 0;

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      var args = ModalRoute.of(context)!.settings.arguments as Map;
   
      airportIndex = args['index'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List reviews = airportReviewList[airportIndex]['reviews']['Seat Comfort'];

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
                    child: Image.asset(
                      airportReviewList[airportIndex]['imagePath'],
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
                                _clickedBoolmark = !_clickedBoolmark;
                              });
                            },
                            iconSize: 30,
                            icon: Icon(
                              _clickedBoolmark
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
                  // mainAxisAlignment: MainAxisAlignment.start
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReviewStatus(reviewStatus: false),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      airportReviewList[airportIndex]['country'],
                      style: AppStyles.textStyle_24_600,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      airportReviewList[airportIndex]['about'],
                      style: AppStyles.textStyle_15_400
                          .copyWith(color: Color(0xff38433E)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      "Trending now:",
                      style: AppStyles.textStyle_14_600,
                    ),
                    Text(
                      airportReviewList[airportIndex]['trending'],
                      style: AppStyles.textStyle_15_400
                          .copyWith(color: Color(0xff38433E)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      "Perks you'll love:",
                      style: AppStyles.textStyle_14_600,
                    ),
                    Text(
                      airportReviewList[airportIndex]['perk'],
                      style: AppStyles.textStyle_15_400
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
                children: reviews.map((singleReview) {       
                  return CategoryReviews(
                    review: singleReview,
                  );
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
              )
            ]),
          )
        ],
      ),
    );
  }
}

class ExpandButtons extends ConsumerWidget {
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
