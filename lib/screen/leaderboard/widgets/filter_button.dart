import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:button_animations/button_animations.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key, required this.text});

  final String text;

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool _isSelected = false; // State variable to track selection

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected; // Toggle the selection state
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelection,
      child: IntrinsicWidth(
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: _isSelected
                ? AppStyles.mainButtonColor
                : AppStyles.whiteColor, // Change color based on selection
            border: Border.all(
              width: 2,
              color: AppStyles.littleBlackColor,
            ),
            boxShadow: [
              BoxShadow(
                color: AppStyles.littleBlackColor, // Adjust opacity if needed
                offset: const Offset(2, 2),
                // blurRadius: 4, // Add blur radius for a smoother shadow
              ),
            ],
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300), // Animation duration
            curve: Curves.easeInCubic, // Optional curve for smooth animation
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: _isSelected
                  ? AppStyles.mainButtonColor
                  : AppStyles.whiteColor, // Change color based on selection
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(widget.text, style: AppStyles.cardTextStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}