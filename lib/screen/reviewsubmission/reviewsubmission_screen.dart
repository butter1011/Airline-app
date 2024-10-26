import 'package:airline_app/screen/reviewsubmission/widgets/type_button.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ReviewsubmissionScreen extends StatelessWidget {
  const ReviewsubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 52.2,
        leading: Icon(Icons.arrow_back_ios_sharp),
        centerTitle: true,
        title: Text(
          'Reviews',
          style: AppStyles.mainTextStyle,
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(4.0), // Set height for the bottom widget
          child: Container(
            color: Colors.black, // Background color for the container
            height: 4.0, // Height of the container
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Type",
                  style: AppStyles.subtitleTextStyle,
                ),
                SizedBox(
                  height: 16,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TypeButton(
                      text: "All",
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    TypeButton(
                      text: "Flights",
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    TypeButton(
                      text: "Airports",
                    ),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                Container(
                  height: 2,
                  color: Colors.black,
                )
              ],
            ),
            Container(
              height:148,
              decoration: BoxDecoration(),
            )
          ],
        ),
      ),
    );
  }
}
