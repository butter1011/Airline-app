import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class TypeButton extends StatelessWidget {
  const TypeButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? AppStyles.mainColor : Colors.white,
          border: Border.all(width: 2, color: Colors.black),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(2, 2))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Text(
              text,
              style: AppStyles.textStyle_14_600,
            ),
          ),
        ),
      ),
    );
  }
}