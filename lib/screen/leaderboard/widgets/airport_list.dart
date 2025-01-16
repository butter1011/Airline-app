import 'package:airline_app/provider/filter_button_provider.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirportList extends ConsumerWidget {
  const AirportList({
    super.key,
    required this.airportData,
  });

  final Map<String, dynamic> airportData;
  (List<FlSpot>, double) _getSpots() {
    final scoreHistory =
        List<Map<String, dynamic>>.from(airportData['scoreHistory'] ?? []);
    if (scoreHistory.isEmpty) {
      return (
        [
          const FlSpot(0, 0),
          const FlSpot(1, 0),
        ],
        0.0
      );
    }

    if (scoreHistory.length == 1) {
      // If only one data point exists, create a flat line with same value
      final score = double.parse(scoreHistory.first['score'].toString());
      return (
        [
          FlSpot(0, score),
          FlSpot(1, score),
        ],
        0.0
      );
    }

    final spots = <FlSpot>[];
    var lastScore = 0.0;
    var firstScore = 0.0;
    var isFirstScore = true;

    // Convert all timestamps to x-axis points from 0 to 1
    final totalPoints = scoreHistory.length;
    for (var i = 0; i < totalPoints; i++) {
      final entry = scoreHistory[i];
      final score = double.parse(entry['score'].toString());

      if (isFirstScore) {
        firstScore = score;
        isFirstScore = false;
      }
      lastScore = score;

      // Normalize x-axis from 0 to 1
      final xValue = i / (totalPoints - 1);
      spots.add(FlSpot(xValue, score));
    }

    final change = lastScore - firstScore;
    return (spots, change);
  }

  num getCategoryScore(String selecedFilterButton) {
    switch (selecedFilterButton) {
      case "Flight Experience":
        return airportData['departureArrival'];
      case "Comfort":
        return airportData['comfort'];
      case "Cleanliness":
        return airportData['cleanliness'];
      case "Onboard":
        return airportData['onboardService'];
      case "Food & Beverage":
        return airportData['foodBeverage'];
      case "Entertainment & WiFi":
        return airportData['entertainmentWifi'];
      case "Accessibility":
        return airportData['accessibility'];
      case "Wait Times":
        return airportData['waitTimes'];
      case "Helpfulness":
        return airportData['helpfulness'];
      case "Ambience":
        return airportData['ambienceComfort'];
      case "Amenities":
        return airportData['amenities'];
      default:
        return airportData['departureArrival'];
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (spots, changeValue) = _getSpots();
    final String selecedFilterButton = ref.watch(filterButtonProvider);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.detailairport,
            arguments: airportData);
      },
      child: Container(
        decoration: BoxDecoration(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: AppStyles.circleDecoration,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: airportData['logoImage'] != null
                            ? NetworkImage(airportData['logoImage'])
                            : airportData['isAirline']
                                ? const AssetImage(
                                        'assets/images/airline_logo.png')
                                    as ImageProvider
                                : const AssetImage(
                                        'assets/images/airport_logo.png')
                                    as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          airportData['name'],
                          style: AppStyles.textStyle_14_600,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          airportData['isAirline'] ? 'Airline' : 'Airport',
                          style: AppStyles.textStyle_14_600.copyWith(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Score ${airportData['overall'].toStringAsFixed(1)}',
                          style: AppStyles.textStyle_14_600.copyWith(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 80, // Fixed width for the graph
                    height: 40,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            color: airportData['isIncreasing']
                                ? Color(0xFF3FEA9C)
                                : Color(0xFFFF4961),
                            barWidth: 2,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: (airportData['isIncreasing']
                                      ? Color(0xFF3FEA9C)
                                      : Color(0xFFFF4961))
                                  .withOpacity(0.1),
                            ),
                            showingIndicators: [],
                          ),
                        ],
                        lineTouchData: LineTouchData(enabled: false),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        (selecedFilterButton == "All" ||
                                selecedFilterButton == "Airline" ||
                                selecedFilterButton == "Airport")
                            ? 'Rate of Growth'
                            : selecedFilterButton,
                        style: AppStyles.textStyle_14_600.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff97a09c),
                        ),
                      ),
                      (selecedFilterButton == "All" ||
                              selecedFilterButton == "Airline" ||
                              selecedFilterButton == "Airport")
                          ? Text(
                              changeValue >= 0
                                  ? "+${changeValue.toStringAsFixed(1)}"
                                  : changeValue.toStringAsFixed(1),
                              style: AppStyles.textStyle_14_600.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            )
                          : Text(
                              getCategoryScore(selecedFilterButton)
                                  .toStringAsFixed(1),
                              style: AppStyles.textStyle_14_600.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              color: AppStyles.littleBlackColor,
            )
          ],
        ),
      ),
    );
  }
}
