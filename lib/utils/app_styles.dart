import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  ///Color style
  static Color mainButtonColor = const Color(0xFF3FEA9C);
  static Color littleBlackColor = const Color(0xff181818);

  ///Text style

  static TextStyle normalTextStyle = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle cardTextStyle = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFF181818),
  );
  static TextStyle textButtonStyle = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Color(0xFF181818),
  );
  static TextStyle mainTextStyle = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle smallTitleTextStyle = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF38433E),
  );
  static TextStyle subtitleTextStyle = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle titleTextStyle = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  /// Box style
  static BoxDecoration avatarDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white, // Border color
      border: Border.all(width: 2, color: Colors.black),
      boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(2, 2))]);
  static BoxDecoration slideButtonDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white, // Border color
      border: Border.all(width: 2, color: Colors.black),
      boxShadow: const [
        BoxShadow(color: Color(0xff181818), offset: Offset(2, 2))
      ]);
}
