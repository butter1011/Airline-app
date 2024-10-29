import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  ///Color style
  static Color mainButtonColor = const Color(0xFF3FEA9C);
  static Color littleBlackColor = const Color(0xff181818);
  static Color whiteColor = const Color(0xffffffff);

  ///Text style

  static TextStyle flagTextStyle = const TextStyle(
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

  static TextStyle litteBlackTextStyle = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xff38433E),
  );
  static TextStyle litteGrayTextStyle = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Color(0xff38433E),
  );
  static TextStyle cardTextStyle = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFF000000),
  );
  static TextStyle normalTextStyle2 = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static TextStyle textButtonStyle = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Color(0xFF181818),
  );
  static TextStyle messageTextStyle = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Color(0xFF181818),
  );

  static TextStyle mainTextStyle = const TextStyle(
    fontFamily: 'Clash Grotesk',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF181818),
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
  static TextStyle reviewTitleTextStyle = GoogleFonts.getFont(
    'Oswald',
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      color: Colors.white,
      fontSize: 15,
    ),
  );

  /// Box style
  static BoxDecoration avatarDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white, // Border color
      border: Border.all(width: 2, color: AppStyles.littleBlackColor),
      boxShadow: [
        BoxShadow(color: AppStyles.littleBlackColor, offset: Offset(2, 2))
      ]);
  static BoxDecoration avatarExpandDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: AppStyles.mainButtonColor, // Border color
      border: Border.all(width: 2, color: AppStyles.littleBlackColor),
      boxShadow: [
        BoxShadow(color: AppStyles.littleBlackColor, offset: Offset(2, 2))
      ]);
  static BoxDecoration slideButtonDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white, // Border color
      border: Border.all(width: 2, color: Colors.black),
      boxShadow: const [
        BoxShadow(color: Color(0xff181818), offset: Offset(2, 2))
      ]);
  static BoxDecoration notificationDecoration = BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.white, // Border color
      border: Border.all(width: 2, color: Colors.black),
      borderRadius: BorderRadius.circular(24),
      boxShadow: const [
        BoxShadow(color: Color(0xff181818), offset: Offset(2, 2))
      ]);
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
}
