import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              style: GoogleFonts.getFont("Schibsted Grotesk",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  // letterSpacing: 0.7,
                  color: color == Colors.white ? Colors.black : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
