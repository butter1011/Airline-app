import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  ///Color style
  static Color mainColor = const Color(0xFF3FEA9C);
  static Color littleBlackColor = const Color(0xff181818);

  ///Text style
  static TextStyle textStyle_12_600 = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle textStyle_13_600 = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle textStyle_14_400 = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle textStyle_14_500 = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xff38433E),
  );
  static TextStyle textStyle_14_600 = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFF000000),
  );
  static TextStyle textStyle_15_400 = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static TextStyle textStyle_15_600 = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Color(0xFF000000),
  );
  static TextStyle textStyle_15_500 = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Color(0xFF181818),
  );

  static TextStyle textStyle_16_600 = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF000000),
  );
  static TextStyle textStyle_18_600 = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle textStyle_24_600 = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle textStyle_32_600 = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle oswaldTextStyle = GoogleFonts.getFont(
    'Oswald',
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      color: Colors.white,
      fontSize: 15,
    ),
  );

  /// Box style
  static BoxDecoration circleDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white, // Border color
      border: Border(
        top: BorderSide(color: Colors.black, width: 2.0),
        left: BorderSide(color: Colors.black, width: 2.0),
        bottom: BorderSide(color: Colors.black, width: 4.0),
        right: BorderSide(color: Colors.black, width: 4.0),
      ));
  static BoxDecoration notificationDecoration = BoxDecoration(
    shape: BoxShape.rectangle,
    color: Colors.white, // Border color
    border: Border(
      top: BorderSide(color: Colors.black, width: 2.0),
      left: BorderSide(color: Colors.black, width: 2.0),
      bottom: BorderSide(color: Colors.black, width: 4.0),
      right: BorderSide(color: Colors.black, width: 4.0),
    ),
    borderRadius: BorderRadius.circular(24),
  );
  static BoxDecoration cardDecoration = BoxDecoration(
      color: Colors.white, // Border color
      borderRadius: BorderRadius.circular(24),
      border: Border(
        top: BorderSide(color: Colors.black, width: 2.0),
        left: BorderSide(color: Colors.black, width: 2.0),
        bottom: BorderSide(color: Colors.black, width: 4.0),
        right: BorderSide(color: Colors.black, width: 4.0),
      ));
  static BoxDecoration buttonDecoration = BoxDecoration(
      color: Color(0xFF3FEA9C),
      border: Border(
        top: BorderSide(color: Colors.black, width: 2.0),
        left: BorderSide(color: Colors.black, width: 2.0),
        bottom: BorderSide(color: Colors.black, width: 4.0),
        right: BorderSide(color: Colors.black, width: 4.0),
      ));
  static BoxDecoration iconDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border(
        top: BorderSide(color: Colors.black, width: 2.0),
        left: BorderSide(color: Colors.black, width: 2.0),
        bottom: BorderSide(color: Colors.black, width: 3.0),
        right: BorderSide(color: Colors.black, width: 3.0),
      ));
  static BoxDecoration badgeDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      border: Border(
        top: BorderSide(color: Colors.black, width: 2.0),
        left: BorderSide(color: Colors.black, width: 2.0),
        bottom: BorderSide(color: Colors.black, width: 3.0),
        right: BorderSide(color: Colors.black, width: 3.0),
      ));
}
