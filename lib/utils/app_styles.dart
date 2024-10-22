import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  ///Color style
  static Color mainButtonColor = const Color(0xFF3FEA9C);

  ///Text style
  static TextStyle mainTextStyle = GoogleFonts.getFont("Schibsted Grotesk",
      fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.5);
  static TextStyle itemButtonTextStyle = GoogleFonts.getFont(
      "Schibsted Grotesk",
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5);
  static TextStyle titleTextStyle = GoogleFonts.getFont("Schibsted Grotesk",
      fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.5);
  static TextStyle subtitleTextStyle = GoogleFonts.getFont("Schibsted Grotesk",
      fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.5);

  /// Box style
  static BoxDecoration avatarDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white, // Border color
      // borderRadius: BorderRadius.circular(30),
      border: Border.all(width: 2, color: Colors.black),
      boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(2, 2))]);
}
