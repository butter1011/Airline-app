import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ToggleBtn extends StatelessWidget {
  const ToggleBtn({
    super.key,
    required this.buttonText,
    required this.height,
    required this.isSelected,
    required this.onSelected,
  });
  final String buttonText;
  final double height;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        height: height,
        decoration: AppStyles.cardDecoration,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? AppStyles.mainColor : Colors.white,
            foregroundColor: AppStyles.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: onSelected,
          child: Center(
            child: Text(buttonText, style: AppStyles.textStyle_14_600),
          ),
        ),
      ),
    );
  }
}
