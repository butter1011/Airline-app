import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ItemButton extends StatelessWidget {
  const ItemButton({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        // Diameter of the circular avatar
        height: 24, // Diameter of the circular avatar
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color, // Background color
          border: Border.all(width: 2, color: Colors.black), // Border color
          boxShadow: const [
            BoxShadow(color: Color(0xFF181818), offset: Offset(2, 2))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Text(
              text,
              style: AppStyles.textStyle_14_600.copyWith(color: color == Colors.white ? Colors.black : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
