import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../themes/app_theme.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_fonts.dart';
import 'controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [

            Positioned.fill(
              child: Container(
                color: CustomColors.white, // Adding 60% opacity to the blue overlay
              ),
            ),

            // Animated Icon in the Center
            Center(
              child: ScaleTransition(
                scale: controller.scaleAnimation,
                child: Container(
                  width: 400.w, // Adjust size to fit the image with padding
                  height: 400.h,
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImageUtils.mdfVerticalWhiteLogo,
                    width: 400.w,
                    height: 400.h,
                  ),
                ),
              ),
            ),

          ],
        ),
      );
    });
  }
}
