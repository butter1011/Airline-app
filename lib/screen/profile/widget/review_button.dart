import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ReviewButton extends StatefulWidget {
  final String iconUrl;
  final String label;

  ReviewButton({required this.iconUrl, required this.label});

  @override
  _ReviewButtonState createState() => _ReviewButtonState();
}

class _ReviewButtonState extends State<ReviewButton> {
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
      child: Container(
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
    );
  }
}
