import 'package:airline_app/controller/feedback_controller.dart';
import 'package:airline_app/screen/app_widgets/bottom_nav_bar.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/screen/feed/widgets/feed_card.dart';
import 'package:airline_app/screen/feed/widgets/feed_filter_button.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final _fetchReviews = FeedbackController();
  bool _isLoading = true;
  List<Map<String, dynamic>> reviewList = [];
  late bool selectedAll = true;
  late bool selectedAirline = false;
  late bool selectedAirport = false;
  late bool selectedCleanliness = false;
  late bool selectedOnboard = false;

  @override
  void initState() {
    super.initState();
    _fetchReviews.fetchReviews().then((value) {
      print('🚝   $value');
      setState(() {
        reviewList = List<Map<String, dynamic>>.from(value);
      });
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
      body: _isLoading
          ? LoadingWidget()
          : Column(
              children: [
                // This section will always stay at the top
                SizedBox(
                  height: 44,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 271,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white, // Background color
                          border: Border.all(
                              width: 2, color: Colors.black), // Border color
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(2, 2))
                          ],
                        ),
                        child: const Center(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                  fontFamily: 'Clash Grotesk', fontSize: 14),
                              contentPadding: EdgeInsets.all(0),
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none, // Remove the underline
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.filterscreen);
                        },
                        child: Container(
                          width: 40, // Diameter of the circular avatar
                          height: 40, // Diameter of the circular avatar
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white, // Background color
                            border: Border.all(
                                width: 2, color: Colors.black), // Border color
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black, offset: Offset(2, 2))
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                                'assets/icons/setting.png'), // Local image asset
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        'Filter by category',
                        style: TextStyle(
                            fontFamily: 'Clash Grotesk',
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FeedFilterButton(
                        text: "All",
                        onSelectionChanged: (value) {
                          setState(() {
                            selectedAll = value;
                          });
                        },
                      ),
                      SizedBox(width: 8),
                      FeedFilterButton(
                        text: "Airline",
                        onSelectionChanged: (value) {
                          setState(() {
                            selectedAirline = value;
                          });
                          print(selectedAirline);
                        },
                      ),
                      SizedBox(width: 8),
                      FeedFilterButton(
                        text: "Airport",
                        onSelectionChanged: (value) {
                          setState(() {
                            selectedAirport = value;
                          });
                          print(" This is selectedAirport $selectedAirport");
                        },
                      ),
                      SizedBox(width: 8),
                      FeedFilterButton(
                        text: "Cleanliness",
                        onSelectionChanged: (value) {
                          setState(() {
                            selectedCleanliness = value;
                          });
                        },
                      ),
                      SizedBox(width: 8),
                      FeedFilterButton(
                        text: "Onboard",
                        onSelectionChanged: (value) {
                          setState(() {
                            selectedOnboard = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Container(height: 4, color: AppStyles.littleBlackColor),

                // The rest of your content goes here inside a scrollable area
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              children: reviewList.map((singleFeedback) {
                            return FeedCard(
                                singleFeedback:
                                    singleFeedback); // Your custom widget
                          }).toList()),
                          SizedBox(
                            height: 18,
                          ),
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
