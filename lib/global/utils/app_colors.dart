import 'package:flutter/material.dart';

abstract class AppColors {
  static const mainColor = Color(0xFF55BA4A);
  static const secondaryColor = Color(0xFF434445);
  // static const mainColor = buttonColor;
  // static const mainColorSecondary = Color(0xFF1976D2);
  static const black = Colors.black;
  static const blackShade = Color(0xFF212529);
  static const white = Colors.white;
  static const whiteShade = Color(0xFFF5F5F5);
  static const whiteShade2 = Color(0xFFF8F9FA);
  static const grey = Colors.grey;
  static const greyShade = Color(0xFF6c757d);
  static const greyShade2 = Color(0xFF444444);
  static const greyShade3 = Color(0xFF757575);
  static const greyShade4 = Color(0xFF9E9E9E);
  static const greyShade5 = Color(0xFFCBD3E3);
  static const orange = Colors.orange;
  static const red = Colors.red;
  static const redShade = Color(0xFFDC3545);
  static const redShade2 = Color(0xFFD32F2F);
  static const blue = Colors.blue;
  static const blueShade = Color(0xFF0D6EFD);
  static const blueShade2 = Color(0xFF8CBAE8);
  static const blueShade3 = Color(0xFF1976D2);
  static const green = Colors.green;
  static const greenShade = Color(0xFF198754);
  static const yellow = Colors.yellow;

  static  List<BoxShadow> firstShadow = [
    BoxShadow(
      color: black.withValues(alpha: 0.3),
      offset: Offset(0, 4),
      blurRadius: 4
    ),
  ];

  static const Color tabColor = Color(
    0xff6A1B9A,
  ); // Vibrant Purple for tab background
  static const Color bgColor = Color(
    0xffFCE4EC,
  ); // Light Pink for app background
  static const Color buttonColor =
      Colors.deepPurple; // Teal Blue for primary buttons
  static const Color button2Color = Color(
    0xff1565C0,
  ); // Bold Blue for secondary buttons
  static const Color buttonTextColor = Color(
    0xffFFFFFF,
  ); // White for text on buttons
  static const Color textFormFieldBorderColor = Color(
    0xffFFAB91,
  ); // Warm Coral for input borders
  static const Color textFormFieldLabelColor = Color(
    0xff4A148C,
  ); // Deep Purple for input labels
  static const Color text1Color = Color(
    0xff1B0000,
  ); // Dark Maroon for main text
  static const Color text2Color = Color(
    0xff37474F,
  ); // Slate Gray for secondary text
  static const Color text3Color = Color(
    0xffFFC400,
  ); // Bright Gold for highlights and accents
  static const Color strokeColor = Color(
    0xffD7CCC8,
  ); // Soft Beige for strokes and dividers
}
