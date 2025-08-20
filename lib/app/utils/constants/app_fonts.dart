///How to use

/*
import 'package:your_project/utils/custom_text_styles.dart';
Text(
  'Hello World',
  style: CustomTextStyles.regular14,
  CustomTextStyles.medium18.copyWith(color: CustomColors.black),
);

*/




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextStyles {
  // Font Size 22 Bold
  static const TextStyle bold22 = TextStyle(
    fontFamily: 'Roboto', // Updated to use Roboto
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black, // Default color is black
  );

  // Font Size 22 Bold
  static const TextStyle large18 = TextStyle(
    fontFamily: 'Roboto', // Updated to use Roboto
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.black, // Default color is black
  );

  // Font Size 18 Medium
  static const TextStyle medium18 = TextStyle(
    fontFamily: 'Roboto', // Updated to use Roboto
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black, // Default color is black
  );

  // Font Size 16 Regular
  static const TextStyle regular16 = TextStyle(
    fontFamily: 'Roboto', // Updated to use Roboto
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black, // Default color is black
  );

  // Font Size 16 Medium
  static const TextStyle medium16 = TextStyle(
    fontFamily: 'Roboto', // Updated to use Roboto
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black, // Default color is black
  );

  // Font Size 16 Medium
  static const TextStyle large16 = TextStyle(
    fontFamily: 'Roboto', // Updated to use Roboto
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.black, // Default color is black
  );

  // Font Size 14 Regular
  static const TextStyle regular14 = TextStyle(
    fontFamily: 'Roboto', // Updated to use Roboto
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black, // Default color is black
  );

  // Font Size 14 Medium
  static const TextStyle medium14 = TextStyle(
    fontFamily: 'Roboto', // Updated to use Roboto
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black, // Default color is black
  );

  // Font Size 14 Semi Bold
  static const TextStyle semiBold14 = TextStyle(
    fontFamily: 'Roboto', // Updated to use Roboto
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black, // Default color is black
  );

  // Font Size 12 Light Regular
  static const TextStyle light12 = TextStyle(
    fontFamily: 'Roboto', // Updated to use Roboto
    fontSize: 12,
    fontWeight: FontWeight.w300, // Light weight
    color: Colors.black, // Default color is black
  );

  static const TextStyle medium12 = TextStyle(
    fontFamily: 'Roboto', // Updated to use Roboto
    fontSize: 12,
    fontWeight: FontWeight.w500, // Light weight
    color: Colors.black, // Default color is black
  );

  // Font Size 10 Regular
  static const TextStyle regular10 = TextStyle(
    fontFamily: 'Roboto', // Updated to use Roboto
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Colors.black, // Default color is black
  );

  // Font Size 9 Regular
  static const TextStyle regular9 = TextStyle(
    fontFamily: 'Roboto', // Updated to use Roboto
    fontSize: 9,
    fontWeight: FontWeight.w400,
    color: Colors.black, // Default color is black
  );
}

// Extension for Custom Colors
extension CustomTextStylesExtensions on TextStyle {
  // Custom Heading Color
  TextStyle get headingColor => copyWith(color: Color(0xFF7C7C7C)); // Example: Gray color

  // White Color
  TextStyle get white => copyWith(color: Colors.white);

  // Example of adding more custom colors
  TextStyle get red => copyWith(color: Colors.red);
}


