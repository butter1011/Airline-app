import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        // Diameter of the circular avatar
        height: 48, // Diameter of the circular avatar
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color, // Background color
          border: Border.all(width: 2, color: Colors.black), // Border color
          boxShadow: [BoxShadow(color: Colors.black, offset: Offset(2, 2))],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.getFont("Familjen Grotesk",
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}
