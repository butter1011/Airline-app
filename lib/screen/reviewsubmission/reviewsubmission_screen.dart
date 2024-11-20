import 'package:airline_app/screen/reviewsubmission/widgets/review_airport_card.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/review_flight_card.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/type_button.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewsubmissionScreen extends StatefulWidget {
  const ReviewsubmissionScreen({super.key});

  @override
  State<ReviewsubmissionScreen> createState() => _ReviewsubmissionScreenState();
}

class _ReviewsubmissionScreenState extends State<ReviewsubmissionScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> flights = airportCardList['flights'];
    List<dynamic> airports = airportCardList['airports'];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 52.2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context), // Navigate back when pressed
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('Reviews'),
          style: AppStyles.textStyle_16_600,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 4.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    AppLocalizations.of(context).translate('Type'),
                    style: AppStyles.textStyle_18_600,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TypeButton(text: "All"),
                    SizedBox(width: 8),
                    TypeButton(text: "Flights"),
                    SizedBox(width: 8),
                    TypeButton(text: "Airports"),
                  ],
                ),
                SizedBox(height: 26),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
              ],
            ),
            SizedBox(height: 12),
            Column(
              children: [
                // Display Flights
                ...flights.map((singleFlight) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: ReviewFlightCard(singleFlight: singleFlight),
                  );
                }),

                // Display Airports
                ...airports.map((singleAirport) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: ReviewAirportCard(singleAirport: singleAirport),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize:
            MainAxisSize.min, // Ensures it takes only the required space
        children: [
          Container(
            height: 2, // Height of the black line
            color: Colors.black, // Color of the line
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.syncedscreen);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Container(
                height: 56,
                decoration: AppStyles.buttonDecoration.copyWith(
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Center(
                    child: Text(
                  AppLocalizations.of(context).translate('Not here?'),
                  style: AppStyles.textStyle_15_600,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
