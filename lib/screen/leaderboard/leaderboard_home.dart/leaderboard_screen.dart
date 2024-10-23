import 'package:airline_app/provider/airportlist_expand_provider.dart';
import 'package:airline_app/provider/button_expand_provider.dart';
import 'package:airline_app/screen/leaderboard/leaderboard_home.dart/leaderboard_home_widgets/feedback_card.dart';
import 'package:airline_app/screen/leaderboard/widgets/airport_card.dart';
import 'package:airline_app/screen/leaderboard/widgets/airport_list.dart';
import 'package:airline_app/screen/leaderboard/widgets/mainButton.dart';
import 'package:airline_app/screen/leaderboard/widgets/itemButton.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 271,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white, // Background color
                            border: Border.all(
                                width: 2, color: Colors.black), // Border color
                            boxShadow: [
                              BoxShadow(
                                  color: AppStyles.littleBlackColor,
                                  offset: const Offset(2, 2))
                            ],
                          ),
                          child: const Center(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  fontFamily: 'Clash Grotesk',
                                  fontSize: 14,
                                  // color: Color(0xff38433E)
                                ),
                                contentPadding: EdgeInsets.all(0),
                                prefixIcon: Icon(Icons.search),
                                border:
                                    InputBorder.none, // Remove the underline
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 40, // Diameter of the circular avatar
                          height: 40, // Diameter of the circular avatar
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white, // Background color
                            border: Border.all(
                                width: 2, color: Colors.black), // Border color
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black, offset: Offset(2, 2))
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/icons/setting.png', // Local image asset
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Text(
                          'Filter by category',
                          style: TextStyle(
                            fontFamily: 'Clash Grotesk',
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        MainButton(
                            text: "All", color: AppStyles.mainButtonColor),
                        SizedBox(
                          width: 8,
                        ),
                        const MainButton(
                          text: "Airline",
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        const MainButton(
                          text: "Airports",
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const MainButton(
                          text: "Cleanlines",
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const MainButton(
                          text: "Onboard",
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const MainButton(
                          text: "Airline",
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Divider(
                    thickness: 5,
                    color: AppStyles.littleBlackColor,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trending Airlines & Airports',
                          style: AppStyles.smallTitleTextStyle,
                        ),
                        AirportListSection(),
                        SizedBox(
                          height: 28,
                        ),
                        Text(
                          'Trending Feedback',
                          style: AppStyles.smallTitleTextStyle,
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children:
                                  trendingFeedbackList.map((singleFeedback) {
                            return FeedbackCard(
                              singleFeedback: singleFeedback,
                            );
                          }).toList()),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////
class AirportListSection extends ConsumerWidget {
  const AirportListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var provider = ref.watch(buttonExpandNotifierProvider);
    return Column(
      children: [
        Column(
          children: airportList.map((singleAirport) {
            int index = airportList.indexOf(singleAirport);
            if (provider || index < 5) {
              return AirportList(
                  country: singleAirport['country'],
                  reviewStatus: singleAirport['reviewStatus'],
                  logo: singleAirport['logo'],
                  index: index);
            }
            return const SizedBox.shrink();
          }).toList(),
        ),
        Center(
          child: InkWell(
            onTap: () {
              ref
                  .watch(buttonExpandNotifierProvider.notifier)
                  .toggleButton(provider);
              print("✈✈=====>$provider");
            },
            child: IntrinsicWidth(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider ? "Expand less" : "Expand more",
                      style:
                          AppStyles.subtitleTextStyle.copyWith(fontSize: 15)),
                  Icon(provider ? Icons.expand_less : Icons.expand_more),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
