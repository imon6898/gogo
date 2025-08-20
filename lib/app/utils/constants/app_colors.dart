///How to use

/*
import 'package:your_project/utils/custom_colors.dart';

Container(
  color: CustomColors.mainColor,
  child: Text(
    'Hello World',
    style: TextStyle(color: CustomColors.white),
  ),
);

*/




import 'package:flutter/material.dart';

class CustomColors {
  // Main Color
  static const Color mainColor = Color(0xFFFF000D);


  // Background Colors
  static const Color BGColor = Color(0xFFECEDE8);

  // Button Color & Cards Colour
  static const Color CardsColour = Color(0xFFF9F8F6);
  static const Color NavbarColour = Color(0xFFF9F8F6);
  static const Color NavbarSelectColour = Color(0xFFF7E0E6);
  static const Color yollow = Color(0xFFFFA903);
  static const Color transparent = Color(0x00000000);


  // Black & White Colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);


  // Green
  static const Color green = Color(0xFF16A34A);
  static const Color successSnackBar = Color(0xFFD8FFF2);
  static const Color waringSnackBar = Color(0xFFFEF1D4);
  static const Color failureSnackBar = Color(0xFFFFC3C3);
  static const Color lightSnackBar = Color(0xFFEFEFEFF7);
}
