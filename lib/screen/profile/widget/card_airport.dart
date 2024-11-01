import 'package:airline_app/screen/profile/widget/cair_category_reviews.dart';

import 'package:airline_app/utils/cairport_list_json.dart';

import 'package:flutter/material.dart';

class CLeaderboardScreen extends StatelessWidget {
  const CLeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List reviews = cairportList[1]['reviews']['Seat Comfort'];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Text(
                'Showing',
                // style: AppStyles.showTextStyle,
              ),
              Expanded(child: ReviewScore())
            ],
          ),
        ),
        Column(
          children: trendingFeedbackList.map((singleReview) {
            return CairCategoryReviews(
              review: singleReview,
            );
          }).toList(),
        ),
      ],
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////
class ReviewScore extends StatefulWidget {
  @override
  _ReviewScoreState createState() => _ReviewScoreState();
}

class _ReviewScoreState extends State<ReviewScore> {
  String? _selectedItem; // Variable to hold the selected item
  final List<String> _items = [
    'Highest Score',
    'Mid Score',
    'Lowest Score',
  ];

  @override
  void initState() {
    super.initState();
    _selectedItem = _items[0]; // Set default selected item
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Main container for the dropdown
      width: 300, // Set width as needed
      padding: EdgeInsets.symmetric(horizontal: 25),

      child: DropdownButtonHideUnderline(
        // Hides the default underline
        child: DropdownButton<String>(
          value: _selectedItem,

          isExpanded: true, // Make dropdown fill available space
          icon: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.expand_more,
              color: Colors.grey.shade600,
            ),
          ),
          // Style for the button when collapsed

          style: TextStyle(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500),
          // Customize the dropdown menu appearance
          menuMaxHeight: 600, // Maximum height of the dropdown menu
          elevation: 8, // Shadow depth of the dropdown menu
          // Style for the dropdown menu
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(8),
          onChanged: (String? newValue) {
            setState(() {
              _selectedItem = newValue;
            });
          },
          // Generate items for the dropdown
          items: _items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  // Hover effect (only visible on web)
                  color: Colors.transparent,
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
