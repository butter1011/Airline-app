import 'package:airline_app/screen/leaderboard/widgets/detailButton.dart';
import 'package:airline_app/screen/leaderboard/widgets/reviewStatus.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DetailAirport extends StatefulWidget {
  const DetailAirport({super.key});

  @override
  State<DetailAirport> createState() => _DetailAirportState();
}

class _DetailAirportState extends State<DetailAirport> {
  bool _clickedBoolmark = false;
  @override
  Widget build(BuildContext context) {
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
                  decoration: BoxDecoration(
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
                      'assets/images/Abu Dhabi.png',
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
                          stops: [
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
                      'Abu Dhabi Airport',
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
                    DetailButton(
                        text: "Seat Comfort 10/10",
                        color: AppStyles.mainButtonColor),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
