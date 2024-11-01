import 'package:airline_app/screen/leaderboard/widgets/filter_button.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AirportsEachContinent extends StatelessWidget {
  const AirportsEachContinent({super.key, required this.continent});
  final String continent;

  @override
  Widget build(BuildContext context) {

    dynamic airports = airportList[continent];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              continent,
              style: AppStyles.textStyle_14_600,
            ),
            Icon(Icons.expand_less)
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(spacing: 8, runSpacing: 8, children: [
          const FilterButton(text: "All"),
          ...airports.map((singleContinent) {
            return FilterButton(text: singleContinent);
          }),
        ]),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
