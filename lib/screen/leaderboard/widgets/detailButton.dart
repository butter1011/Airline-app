import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailButton extends StatelessWidget {
  const DetailButton({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: IntrinsicWidth(
        child: Container(
          // Diameter of the circular avatar
          height: 40, // Diameter of the circular avatar
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color, // Background color
            border: Border.all(width: 2, color: Colors.black), // Border color
            boxShadow: [BoxShadow(color: Colors.black, offset: Offset(2, 2))],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Row(
                children: [
                  Center(child: Image.asset('assets/icons/rocket.png')),
                  Text(text,
                      style: GoogleFonts.getFont("Familjen Grotesk",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.7),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
