import 'package:airline_app/screen/leaderboard/widgets/itemButton.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AirportCard extends StatefulWidget {
  const AirportCard(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.reviewStatus,
      required this.index});
  final String title;
  final String imagePath;
  final bool reviewStatus;
  final int index;

  @override
  State<AirportCard> createState() => _AirportCardState();
}

class _AirportCardState extends State<AirportCard> {
  bool clickedBookmark = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.detailairport,
              arguments: {'index': widget.index});
        },
        child: Column(
          children: [
            Container(
              // height: 295,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(width: 2, color: Colors.black),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(2, 2))
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 175,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(22)),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              // offset: Offset(0, 10),
                              blurRadius: 10,
                              spreadRadius: -10,
                            )
                          ],

                          image: DecorationImage(
                              image: AssetImage(widget.imagePath),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(22)),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.transparent, // No color at the top
                              Colors.black.withOpacity(
                                  0.9), // Gradient color from 30px downwards
                            ],
                            stops: [
                              0.1,
                              1
                            ], // Adjust stops to control where the gradient starts and ends
                          ),
                        ),
                        // Start the gradient 30px from the top
                      ),
                      Positioned(
                        top: 18,
                        left: 15,
                        child: Container(
                          // Diameter of the circular avatar
                          height: 24, // Diameter of the circular avatar
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white, // Background color
                            border: Border.all(
                                width: 2, color: Colors.black), // Border color
                          ),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Text('9/10 from 382 reviews',
                                    style: AppStyles.textStyle_14_600),
                                const SizedBox(
                                  width: 3,
                                ),
                                widget.reviewStatus
                                    ? Image.asset('assets/icons/success.png')
                                    : Image.asset('assets/icons/danger.png')
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 6,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                clickedBookmark = !clickedBookmark;
                              });
                            },
                            iconSize: 30,
                            icon: Icon(
                              clickedBookmark
                                  ? Icons.bookmark_border
                                  : Icons.bookmark,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: AppStyles.textStyle_16_600.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ItemButton(
                                  text: "Top 1 Airport", color: Colors.black),
                              SizedBox(
                                width: 8,
                              ),
                              ItemButton(
                                  text: 'Cleanliness', color: Colors.white),
                              SizedBox(
                                width: 8,
                              ),
                              ItemButton(
                                  text: 'Best Wi-Fi', color: Colors.white)
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Row(
                            children: [
                              ItemButton(
                                  text: 'Best Business Class',
                                  color: Colors.white),
                            ],
                          )
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
