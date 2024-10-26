import 'package:airline_app/provider/button_expand_provider.dart';
import 'package:airline_app/screen/leaderboard/leaderboard_detail/widgets/category_reviews.dart';
import 'package:airline_app/screen/leaderboard/widgets/detailButton.dart';
import 'package:airline_app/screen/leaderboard/widgets/reviewStatus.dart';
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
      print(" Passed index ==========> ${args['index']}");
      airportIndex = args['index'];
      print("🏅🏅🏅  ===> ${airportReviewList[0]}");
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List reviews = airportReviewList[airportIndex]['reviews']['Seat Comfort'];
    print("😉😉😉😉😉😉 ${reviews[1]}");
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
                            onPressed: () {},
                            icon: Image.asset('assets/icons/telegram.png')),
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
                      style: AppStyles.titleTextStyle,
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Category Ratings',
                          style: AppStyles.subtitleTextStyle,
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
                  print("🧨🧨🧨🧨 $singleReview");
                  return CategoryReviews(
                    review: singleReview,
                  );
                }).toList(),
              ),
              // CategoryReviews(review: airportList[airportIndex]['review']),
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
                      color: AppStyles.mainButtonColor, // Background color
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
  const ExpandButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var provider = ref.watch(buttonExpandNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DetailButton(
                    text: "Seat Comfort",
                    color: AppStyles.mainButtonColor,
                    score: 10,
                  ),
                  const DetailButton(
                    text: "Cleanliness",
                    color: Colors.white,
                    score: 9,
                  ),
                ],
              ),
              const DetailButton(
                text: "Booking Experience",
                color: Colors.white,
                score: 9,
              ),
              const DetailButton(
                text: "Additional Services",
                color: Colors.white,
                score: 9,
              ),
            ],
          ),
        ),
        Visibility(
          visible: provider,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailButton(
                text: "Lounge Access",
                color: Colors.white,
                score: 8,
              ),
              DetailButton(
                text: "Boarding Process",
                color: Colors.white,
                score: 8,
              ),
              DetailButton(
                text: "Food & Beverage",
                color: Colors.white,
                score: 8,
              ),
              DetailButton(
                text: "Cabin Crew Service  ",
                color: Colors.white,
                score: 4,
              ),
              DetailButton(
                text: "Wi-Fi",
                color: Colors.white,
                score: 3,
              ),
              DetailButton(
                text: "In-Flight Entertainment",
                color: Colors.white,
                score: 2,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 19,
        ),
        Center(
            child: InkWell(
          onTap: () {
            ref
                .watch(buttonExpandNotifierProvider.notifier)
                .toggleButton(provider);
          },
          child: IntrinsicWidth(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider ? "Show less categories" : "Show more categories",
                    style: AppStyles.subtitleTextStyle.copyWith(fontSize: 15)),
                Icon(
                  provider ? Icons.expand_less : Icons.expand_more,
                ),
              ],
            ),
          ),
        ))
      ],
    );
  }
}
