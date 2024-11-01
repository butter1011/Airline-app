import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class NavButton extends StatefulWidget {
  const NavButton({super.key, required this.text, required this.onPressed, required this.color});

  final String text;
  final VoidCallback onPressed;
  final Color color;

  @override
  _NavButtonState createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool _isSelected = false; // State variable to track selection

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected; // Toggle the selection state
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black, width: 2),
          bottom: BorderSide(color: Colors.black, width: 4),
          right: BorderSide(color: Colors.black, width: 4),
          left: BorderSide(color: Colors.black, width: 2), // Bottom border
        ),
        borderRadius: BorderRadius.circular(28), // Rounded corners
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          overlayColor: AppStyles.mainColor,
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        onPressed: () {
          _toggleSelection();
        }, // Pass the function from the parent widget
        child: Center(
          child: Text(
            widget.text,
            style: AppStyles.textStyle_15_600, // Text color
          ),
        ),
      ),
    );
  }
}
