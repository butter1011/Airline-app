import 'package:airline_app/screen/leaderboard/widgets/airport_card.dart';
import 'package:airline_app/screen/leaderboard/widgets/button.dart';
import 'package:airline_app/screen/leaderboard/widgets/itemButton.dart';
import 'package:airline_app/utils/airportList_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.profilescreen,
                            );
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            // Add padding for a border effect
                            decoration: BoxDecoration(
                                color: Colors.white, // Border color
                                // borderRadius: BorderRadius.circular(25),
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black, offset: Offset(2, 2))
                                ]),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  AssetImage('assets/images/avatar1.png'),
                            ),
                          ),
                        ),
                        Container(
                          width: 50, // Diameter of the circular avatar
                          height: 50, // Diameter of the circular avatar
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white, // Background color
                            border: Border.all(
                                width: 2, color: Colors.black), // Border color
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black, offset: Offset(2, 2))
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/icons/notification.png', // Local image asset
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // Diameter of the circular avatar
                          height: 48, // Diameter of the circular avatar
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:
                                AppStyles.mainButtonColor, // Background color
                            border: Border.all(
                                width: 2, color: Colors.black), // Border color
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black, offset: Offset(2, 2))
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                              child: Text(
                                "All",
                                style: GoogleFonts.getFont("Schibsted Grotesk",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                        ),
                        Button(text: "Airports", color: Colors.white),
                        Button(text: "Airline", color: Colors.white),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 50, // Diameter of the circular avatar
                          height: 50, // Diameter of the circular avatar
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white, // Background color
                            border: Border.all(
                                width: 2, color: Colors.black), // Border color
                            boxShadow: [
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
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 5,
                color: Colors.black,
              ),
              Column(
                children: airportList.map((singleAirline) {
                  return AirportCard(
                    title: singleAirline["title"],
                    imagePath: singleAirline["imagePath"],
                    reviewStatus: singleAirline["reviewStatus"],
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
