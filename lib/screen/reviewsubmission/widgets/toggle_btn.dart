import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ToggleBtn extends StatefulWidget {
  const ToggleBtn({super.key, required this.buttonText, required this.height});
  final String buttonText;
  final double height;

  @override
  State<ToggleBtn> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleBtn> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        height: widget.height,
        decoration: AppStyles.cardDecoration,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? AppStyles.mainColor : Colors.white,
            foregroundColor: AppStyles.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            setState(() {
              isSelected = !isSelected;
            });
            // Add functionality for syncing here
          },
          child: Center(
            child: Text(widget.buttonText, style: AppStyles.textStyle_14_600),
          ),
        ),
      ),
    );
  }
}
