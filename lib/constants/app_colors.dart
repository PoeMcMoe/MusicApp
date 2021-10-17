import 'package:flutter/material.dart';

// Resource:
// A good resource would be this website: http://mcg.mbitson.com/
// You simply need to put in the colour you wish to use, and it will generate
// all shades for you. Your primary colour will be the `500` value.

class AppColors {
  AppColors._();

  static const accent = Color(0xFF536dfe);
  static const darkAccent = Color(0xFF304ffe);

  static const primary = MaterialColor(0xFF3f51b5, {
    50: Color(0xFFe8eaf6),
    100: Color(0xFFc5cae9),
    200: Color(0xFF9fa8da),
    300: Color(0xFF7986cb),
    400: Color(0xFF5c6bc0),
    500: Color(0xFF3f51b5),
    600: Color(0xFF3949ab),
    700: Color(0xFF303f9f),
    800: Color(0xFF283593),
    900: Color(0xFF1a237e),
  });

  static const errorColor = Color(0xFFD60000);

  static const scaffoldColor = Color(0xFFF9F9F9);
  static const bottomNavBarShadow = Color(0x08000000);
  static const cardShadow = Color(0x0D737373);

  static const grey = Color(0xFF8E8E8E);
  static const darkGrey = Color(0xFF2E2E2E);
  static const black = Color(0xFF222222);

  // Text colors ---------------------------------------------------------------
  static const Color textMainColor = Color(0xFF363636);
  static const Color textAlternativeColor = Color(0xFFF2F2F2);
  static const Color textNonHighlightColor = Color(0xFF9B9B9B);

  // Icon colors ---------------------------------------------------------------
  static const Color iconHighlightColor = accent;
  static const Color iconNonHighlightColor = Color(0xFF9B9B9B);
  static const Color iconMainColor = textMainColor;
  static const Color iconAlternativeColor = textAlternativeColor;

  // Material splash colors ----------------------------------------------------
  static const Color splashColorScaffoldBackground = Color(0x40EC0C36);
  static const Color splashColorAccentBackground = Color(0xB3F2F2F2);

  // Button highlight colors ---------------------------------------------------
  static const Color highlightColorAccentBackground = Color(0x05000000);
  static const Color highlightColorScaffoldBackground = Color(0x05000000);

  // Colors for disabled graphical elements ------------------------------------
  static const Color disabledAccentColor = Color(0xFFD40B30);
  static const Color disabledIconColor = Color(0xFFDBDBDB);
  static const Color disabledTextColor = Color(0xFFDBDBDB);

  // Input Fill colors ---------------------------------------------------------
  static const Color inputFillColor = Color(0xFFFFFFFF);

  // Shadow colors ---------------------------------------------------------
  static Color whiteShadowColor = Colors.grey.shade200;

  static Color whiteDisabledShadowColor = Colors.grey.shade200.withOpacity(0.5);
}
