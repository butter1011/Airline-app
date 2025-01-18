import 'package:airline_app/screen/leaderboard/widgets/category_rating_options.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CategoryButtonsWidget extends StatefulWidget {
  final bool isAirline;
  final Map airportData;

  const CategoryButtonsWidget(
      {super.key, required this.isAirline, required this.airportData});

  @override
  State<CategoryButtonsWidget> createState() => _CategoryButtonsWidgetState();
}

class _CategoryButtonsWidgetState extends State<CategoryButtonsWidget> {
  bool isExpanded = false;

  Widget buildCategoryRow(String iconUrl, String label, String badgeScore) {
    return Expanded(
      child: CategoryRatingOptions(
        iconUrl: iconUrl,
        label: label,
        badgeScore: badgeScore,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                widget.isAirline
                    ? buildCategoryRow(
                        'assets/icons/review_icon_boarding.png',
                        'Boarding and\nArrival Experience',
                        widget.airportData['departureArrival']
                            .round()
                            .toString())
                    : buildCategoryRow(
                        'assets/icons/review_icon_access.png',
                        'Accessibility',
                        widget.airportData['accessibility'].round().toString()),
                const SizedBox(width: 16),
                widget.isAirline
                    ? buildCategoryRow(
                        'assets/icons/review_icon_comfort.png',
                        'Comfort',
                        widget.airportData['comfort'].round().toString())
                    : buildCategoryRow(
                        'assets/icons/review_icon_wait.png',
                        'Wait Times',
                        widget.airportData['waitTimes'].round().toString()),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                widget.isAirline
                    ? buildCategoryRow(
                        'assets/icons/review_icon_cleanliness.png',
                        'Cleanliness',
                        widget.airportData['cleanliness'].round().toString())
                    : buildCategoryRow(
                        'assets/icons/review_icon_help.png',
                        'Helpfulness/Ease of Travel',
                        widget.airportData['helpfulness'].round().toString()),
                const SizedBox(width: 16),
                widget.isAirline
                    ? buildCategoryRow(
                        'assets/icons/review_icon_onboard.png',
                        'Onboard Service',
                        widget.airportData['onboardService'].round().toString())
                    : buildCategoryRow(
                        'assets/icons/review_icon_ambience.png',
                        'Ambience/Comfort',
                        widget.airportData['ambienceComfort']
                            .round()
                            .toString()),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  widget.isAirline
                      ? buildCategoryRow(
                          'assets/icons/review_icon_food.png',
                          'Food & Beverage',
                          widget.airportData['foodBeverage'].round().toString())
                      : buildCategoryRow(
                          'assets/icons/review_icon_food.png',
                          'Food & Beverage and Shopping',
                          widget.airportData['foodBeverage']
                              .round()
                              .toString()),
                  const SizedBox(width: 16),
                  widget.isAirline
                      ? buildCategoryRow(
                          'assets/icons/review_icon_entertainment.png',
                          'In-Flight\nEntertainment',
                          widget.airportData['entertainmentWifi']
                              .round()
                              .toString())
                      : buildCategoryRow(
                          'assets/icons/review_icon_entertainment.png',
                          'Amenities and Facilities',
                          widget.airportData['amenities'].round().toString()),
                ],
              ),
            ],
            const SizedBox(height: 19),
            InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
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
