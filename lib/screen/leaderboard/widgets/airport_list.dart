import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AirportList extends StatelessWidget {
  const AirportList({
    super.key,
    required this.airportData,
  });
  
  final Map<String, dynamic> airportData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context, 
          AppRoutes.detailairport, 
          arguments: airportData
        );
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
                    decoration: AppStyles.circleDecoration,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(airportData['logoImage']),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        airportData['name'],
                        style: AppStyles.textStyle_14_600,
                      ),
                      Text(
                        airportData['isAirline'] ? 'Airline' : 'Airport',
                        style: AppStyles.textStyle_14_600.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    // Use Expanded to take remaining space
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end, // Align to the end (right)
                      children: [
                        Row(
                          children: [
                            // Image.asset('assets/icons/graph_danger.png'),
                            (airportData['isIncreasing'])
                                ? Image.asset('assets/icons/graph_primary.png')
                                : Image.asset('assets/icons/graph_danger.png'),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Total Reviews',
                                  style: AppStyles.textStyle_14_600.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff97a09c),
                                  ),
                                ),
                                Text(
                                  "+${airportData['totalReviews'].toString()}",
                                  style: AppStyles.textStyle_14_600.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff38433e),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
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
