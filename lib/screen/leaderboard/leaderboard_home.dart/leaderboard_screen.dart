import 'package:airline_app/screen/leaderboard/widgets/airport_card.dart';
import 'package:airline_app/screen/leaderboard/widgets/mainButton.dart';
import 'package:airline_app/screen/leaderboard/widgets/itemButton.dart';
import 'package:airline_app/utils/airport_list_json.dart';
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
                  padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainButton(text: "All", color: AppStyles.mainButtonColor),
                      const MainButton(text: "Airports", color: Colors.white),
                      const MainButton(text: "Airline", color: Colors.white),
                      const SizedBox(
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
                          boxShadow: const [
                            BoxShadow(color: Colors.black, offset: Offset(2, 2))
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
                  )),
              const Divider(
                thickness: 5,
                color: Colors.black,
              ),
              Column(
                children: airportList.map((singleAirline) {
                  int index = airportList.indexOf(singleAirline);
                  return AirportCard(
                    title: singleAirline["country"],
                    imagePath: singleAirline["imagePath"],
                    reviewStatus: singleAirline["reviewStatus"],
                    index: index,
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
