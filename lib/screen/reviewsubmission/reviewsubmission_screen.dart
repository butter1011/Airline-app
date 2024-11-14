import 'package:airline_app/screen/reviewsubmission/widgets/review_airport_card.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/review_flight_card.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/type_button.dart';
import 'package:airline_app/utils/airport_list_json.dart';
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
  // Map<String, dynamic> _data = {}; // Initialize data
  // bool _loading = true; // Add loading state

  // @override
  // void initState() {
  //   super.initState();
  //   fetchData(); // Call fetchData on initialization
  // }

  // Future<void> fetchData() async {
  //   final String url =
  //       'http://10.0.2.2:8000/data'; // Replace with your API endpoint

  //   try {
  //     final response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         _data = json
  //             .decode(response.body); // Update the state with the fetched data
  //         // _loading = false; // Set loading to false when data is fetched
  //         print("🧡🧡 ${_data["message"]}");
  //       });
  //     } else {
  //       throw Exception('Failed to load data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     setState(() {
  //       _data = {'error': e.toString()}; // Update the state with the error
  //       // _loading = false; // Set loading to false on error
  //     });
  //   }
  // }

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
          'Reviews',
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
                    "Type",
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
                  "Not here?",
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
