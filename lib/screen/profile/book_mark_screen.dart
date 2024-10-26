import 'package:airline_app/screen/profile/profile_screen.dart';
import 'package:airline_app/screen/profile/utils/review_json.dart';
import 'package:airline_app/screen/profile/widget/creview_list.dart';

import 'package:airline_app/utils/app_styles.dart';

import 'package:flutter/material.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 66,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProfileScreen();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/left.png', // Path to your arrow icon
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                Expanded(
                    child: Center(
                        child: Text('Mexico (2)',
                            style: AppStyles.mainTextStyle))),
              ],
            ),
          ),
          Divider(
            thickness: 4,
            color: Colors.black,
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AirportListSectionProfile(), // Your custom widget
                    SizedBox(height: 28),
                  ],
                ),
              ),
            ],
          )))
        ],
      ),
    );
  }
}

class AirportListSectionProfile extends StatelessWidget {
  const AirportListSectionProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: reviewjsonlist.map((singleAirport) {
            int index = reviewjsonlist.indexOf(singleAirport);
            return CreviewList(
                country: singleAirport['country'],
                reviewStatus: singleAirport['reviewStatus'],
                logo: singleAirport['logo'],
                index: index);
          }).toList(),
        ),
      ],
    );
  }
}
