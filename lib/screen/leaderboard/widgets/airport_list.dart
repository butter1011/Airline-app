import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AirportList extends StatelessWidget {
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
          const FlSpot(24, 0),
        ],
        0.0
      );
    }

    final now = DateTime.now();
    final twentyFourHoursAgo = now.subtract(const Duration(hours: 24));

    if (scoreHistory.length == 1) {
      // If only one data point exists, create a flat line with same value
      final score = double.parse(scoreHistory.first['score'].toString());
      return (
        [
          FlSpot(0, score),
          FlSpot(24, score),
        ],
        0.0
      );
    }

    final spots = <FlSpot>[];
    var lastScore = 0.0;
    var firstScore = 0.0;
    var isFirstScore = true;

    for (var i = 0; i <= 24; i++) {
      final targetTime = twentyFourHoursAgo.add(Duration(hours: i));

      // Find the closest score entry before or at this time
      final relevantScore = scoreHistory.lastWhere(
        (entry) {
          final entryTime = DateTime.parse(entry['timestamp']);
          return entryTime.isBefore(targetTime) ||
              entryTime.isAtSameMomentAs(targetTime);
        },
        orElse: () => scoreHistory.first,
      );

      lastScore = double.parse(relevantScore['score'].toString());
      if (isFirstScore) {
        firstScore = lastScore;
        isFirstScore = false;
      }
      spots.add(FlSpot(i.toDouble(), lastScore));
    }

    final change = lastScore - firstScore;
    return (spots, change);
  }

  @override
  Widget build(BuildContext context) {
    final (spots, changeValue) = _getSpots();
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
                      child: Image.network(
                        airportData['logoImage'],
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
                        '24h changes',
                        style: AppStyles.textStyle_14_600.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff97a09c),
                        ),
                      ),
                      Text(
                        changeValue >= 0
                            ? "+${changeValue.toStringAsFixed(3)}"                                                                                              
                            : changeValue.toStringAsFixed(3),
                        style: AppStyles.textStyle_14_600.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: changeValue >= 0
                              ? const Color(0xFF3FEA9C)
                              : const Color(0xFFFF4961),
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
