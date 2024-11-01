import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryRatingOptions extends StatefulWidget {
  final String iconUrl;
  final String label;
  final String? badgeScore;

  const CategoryRatingOptions(
      {super.key, required this.iconUrl, required this.label, this.badgeScore});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryRatingOptionsState createState() => _CategoryRatingOptionsState();
}

class _CategoryRatingOptionsState extends State<CategoryRatingOptions> {
  bool _isClicked = false;

  void _toggleClick() {
    setState(() {
      _isClicked = !_isClicked; // Toggle the click state
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleClick, // Change color on tap
      child: Stack(
        children: [
          Container(
            height: 126,
            width: MediaQuery.of(context).size.width * 0.41,
            decoration: AppStyles.cardDecoration.copyWith(
              color: _isClicked
                  ? AppStyles.mainColor
                  : Colors.white, // Change color based on click state
            ),
            padding: EdgeInsets.only(
                bottom: 10, top: 16), // Add padding for better spacing
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: AppStyles.cardDecoration.copyWith(
                    color: _isClicked ? Colors.white : AppStyles.mainColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(widget.iconUrl, height: 40),
                ),
                SizedBox(height: 6),
                Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyle_14_600, // Optional styling
                ),
              ],
            ),
          ),
          if (widget.badgeScore != null)
            Positioned(
                top: 12,
                right: 16,
                child: Container(
                  height: 20,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      border: Border(
                        top: BorderSide(color: Colors.black, width: 2.0),
                        left: BorderSide(color: Colors.black, width: 2.0),
                        bottom: BorderSide(color: Colors.black, width: 3.0),
                        right: BorderSide(color: Colors.black, width: 3.0),
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "${widget.badgeScore}/10",
                      style: AppStyles.textStyle_12_600,
                    ),
                  ),
                ))
        ],
      ),
    );
  }
}
