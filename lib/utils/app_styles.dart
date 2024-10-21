import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static Color mainButtonColor = const Color(0xFF3FEA9C);
  static TextStyle mainTextStyle = GoogleFonts.getFont(
    "Space Grotesk",
    fontSize: 16,
    fontWeight: FontWeight.w900,
  );
  static BoxDecoration avatarDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white, // Border color
      // borderRadius: BorderRadius.circular(30),
      border: Border.all(width: 2, color: Colors.black),
      boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(2, 2))]);
}
