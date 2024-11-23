// airport_list

import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AirportList extends StatelessWidget {
  const AirportList({
    super.key,
    required this.name,
    required this.isAirline,
    required this.isIncreasing,
    required this.logoImage,
    required this.index,
    required this.totalReviews,
    required this.backgroundImage,
    required this.perksBio,
    required this.trendingBio,
    required this.descriptionBio,
    // required this.logo
  });

  final String name;
  final bool isAirline;
  final int index;
  final String logoImage;
  final bool? isIncreasing;
  final int totalReviews;
  final String backgroundImage;
  final String perksBio;
  final String trendingBio;
  final String descriptionBio;
  // final String logo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.detailairport, arguments: {
          'index': index,
          'name': name,
          'descriptionBio': descriptionBio,
          'perksBio': perksBio,
          'trendingBio': trendingBio,
          'backgroundImage': backgroundImage
        });
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
                      backgroundImage: NetworkImage(logoImage),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppStyles.textStyle_14_600,
                      ),
                      Text(
                        isAirline ? 'Airline' : 'Airport',
                        style: AppStyles.textStyle_14_600.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  // Spacer(), // This will take up all available space between the elements
                  // SizedBox(width: 300), // This adds a fixed width of 300 pixels

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
                            (isIncreasing ?? false)
                                ? Image.asset('assets/icons/graph_primary.png')
                                : Image.asset('assets/icons/graph_danger.png'),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Onboard Service',
                                  style: AppStyles.textStyle_14_600.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff97a09c),
                                  ),
                                ),
                                Text(
                                  "+${totalReviews.toString()}",
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
