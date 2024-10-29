import 'package:airline_app/screen/leaderboard/widgets/airports_each_continent.dart';
import 'package:airline_app/screen/leaderboard/widgets/filter_button.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> keys = airportList.keys.toList();
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios,
          size: 24,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the row
          children: [
            Expanded(
              child: Text(
                "Filters",
                textAlign:
                    TextAlign.center, // Center text within the expanded widget
                style: AppStyles.mainTextStyle,
              ),
            ),
            const Icon(
              Icons.search,
              size: 24,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 4, // Set the height to match the thickness you want
            color: AppStyles.littleBlackColor, // Use your desired color
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
////////Type category
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Type",
                            style: AppStyles.subtitleTextStyle,
                          ),
                          const Icon(Icons.expand_less),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilterButton(text: 'All'),
                          FilterButton(text: 'Airports'),
                          FilterButton(text: 'Airline'),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
////////Global&Regional Leaderboards
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Global&Regional Leaderboards",
                            style: AppStyles.subtitleTextStyle,
                          ),
                          const Icon(
                            Icons.expand_less,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
//////////////All Continents
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Best by Continents',
                                style: AppStyles.mainTextStyle,
                              ),
                              const Icon(
                                Icons.expand_less,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          const Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              FilterButton(text: "All"),
                              FilterButton(text: "Africa"),
                              FilterButton(text: "Asia"),
                              FilterButton(text: "Europe"),
                              FilterButton(text: "North America"),
                              FilterButton(text: "South America"),
                              FilterButton(text: "Australia"),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
//////////////Each continent
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Best by Continents',
                                style: AppStyles.mainTextStyle,
                              ),
                              const Icon(
                                Icons.expand_less,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          Column(
                            children: keys.map((singleKey) {
                              print("🛴🛴🛴    $singleKey");
                              return AirportsEachContinent(
                                  continent: singleKey);
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
//////  Category-Specific Leaderboards
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Category-Specific Leaderboards",
                              style: AppStyles.subtitleTextStyle,
                            ),
                            const Icon(
                              Icons.expand_less,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            FilterButton(text: "All"),
                            FilterButton(text: "Best Wi-Fi"),
                            FilterButton(text: "Best Food"),
                            FilterButton(text: "Best Seat Comfort"),
                            FilterButton(text: "Cleanliness"),
                          ],
                        )
                      ]),
                  SizedBox(
                    height: 25,
                  ),
///////   Class-Specific Leaderboards
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Category-Specific Leaderboards",
                              style: AppStyles.subtitleTextStyle,
                            ),
                            const Icon(
                              Icons.expand_less,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            FilterButton(text: "All"),
                            FilterButton(text: "Best First Class"),
                            FilterButton(text: "Best Business Class"),
                            FilterButton(text: "Best Economy Class"),
                          ],
                        )
                      ]),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4, // Set the height to match the thickness you want
            color: AppStyles.littleBlackColor, // Use your desired color
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.87,
              height: 56,
              decoration: BoxDecoration(
                  color: AppStyles.mainButtonColor,
                  border:
                      Border.all(width: 2, color: AppStyles.littleBlackColor),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                        color: AppStyles.littleBlackColor, offset: Offset(2, 2))
                  ]),
              child: Center(
                child: Text(
                  "Appply",
                  style: AppStyles.textButtonStyle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
