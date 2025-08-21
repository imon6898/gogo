/*
CustomButton(
                    text: "SignIN",
                    onPressed: () {
                      print("Learn More Pressed!");
                    },
                    backgroundColor: CustomColors.mainColor,
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    textStyle: CustomTextStyles.bold22.copyWith(color: Colors.white),
                  ),
*/


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed; // Change to nullable
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final double height;

  const CustomButton({
    Key? key,
    this.text,
    required this.onPressed, // Nullable onPressed
    this.backgroundColor = CustomColors.PrimaryColor,
    this.borderRadius = 6.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 0.0),
    required this.textStyle,
    this.height = 44.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed, // Handle null in onPressed
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius).r,
          ),
        ),
        child: Text(
          text!,
          style: textStyle,
        ),
      ),
    );
  }
}





class CustomOutlinedButton extends StatelessWidget {
  final String? text; // Text displayed on the button
  final VoidCallback onPressed; // Callback for button press
  final Color borderColor; // Border color of the button
  final Color textColor; // Text color
  final double borderRadius; // Border radius
  final EdgeInsets padding; // Padding inside the button
  final TextStyle textStyle; // TextStyle for the button text
  final double height; // Height of the button

  const CustomOutlinedButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.borderColor = Colors.blue, // Default border color
    this.textColor = Colors.blue, // Default text color
    this.borderRadius = 6.0, // Default border radius
    this.padding = const EdgeInsets.symmetric(horizontal: 0.0),
    required this.textStyle, // TextStyle is required
    this.height = 52.0, // Default height set to 52
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: padding,
          side: BorderSide(color: borderColor, width: 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius).r,
          ),
        ),
        child: Text(
          text!,
          style: textStyle.copyWith(color: textColor), // Apply text style with text color
        ),
      ),
    );
  }
}

