import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo/app/routes/app_routes.dart';
import 'package:gogo/app/services/cache_manager.dart';
import 'package:gogo/app/widgets/custom_primary_button.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_colors.dart';
import 'controllers/getstarted_controller.dart';

class GetstartedScreen extends StatelessWidget {
  const GetstartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetstartedController>(builder: (controller) {
      return Scaffold(
        body: Stack(
          children: [
            // Background color
            Positioned.fill(
              child: Container(color: CustomColors.mainColor),
            ),

            // Top Logo with position animation
            Positioned(
              top: 80.h,
              left: 0,
              right: 0,
              child: Image.asset(
                ImageUtils.mdffullLogo,
                width: 120.w,
                height: 120.h,
              ),

              // SlideTransition(
              //   position: controller.mdfLogoPositionAnimation,
              //   child: FadeTransition(
              //     opacity: controller.fadeAnimation,
              //     child: Image.asset(
              //       ImageUtils.mdffullLogo,
              //       width: 120.w,
              //       height: 120.h,
              //     ),
              //   ),
              // ),
            ),

            // White curved container
            Positioned(
              bottom: 0,
              child: CustomPaint(
                painter: MyCustomPainter(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),

            // Center Bottle Logo with position animation
            Positioned(
              top: 250.h,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: controller.mdfBottleLogoPositionAnimation,
                child: ScaleTransition(
                  scale: controller.scaleAnimation,
                  child: Image.asset(
                    ImageUtils.mdfbottoleLogo,
                    width: 100.w,
                    height: 100.h,
                  ),
                ),
              ),
            ),

            // Button with fade animation
            Positioned(
              bottom: 40.h,
              left: 20.w,
              right: 20.w,
              child: Column(
                spacing: 10,
                children: [
                  FadeTransition(
                    opacity: controller.fadeAnimation,
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                          fontSize: 28.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FadeTransition(
                    opacity: controller.fadeAnimation,
                    child: Text(
                      'to MealDealFinder where you find great food at great prices',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  FadeTransition(
                    opacity: controller.fadeAnimation,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'By continuing, you agree to our ',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'terms and conditions. ',
                            style: TextStyle(
                              fontSize: 12.sp,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Find out how we use your data in our ',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'privacy statement.',
                            style: TextStyle(
                              fontSize: 12.sp,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  FadeTransition(
                    opacity: controller.fadeAnimation,
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: "Let's get started",
                        onPressed: () async {
                          controller.getStarted();

                        },
                        backgroundColor: CustomColors.mainColor,
                        borderRadius: 30.0,
                        textStyle: TextStyle(
                          color: CustomColors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

// Custom painter for curved top
class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width / 2, -100, size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
