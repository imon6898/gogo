import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gogo/app/feature/auth/controllers/auth_controller.dart';
import 'package:gogo/app/feature/getstarted/getstarted_screen.dart';
import 'package:gogo/app/utils/constants/app_assets.dart';
import 'package:gogo/app/utils/constants/app_colors.dart';
import 'package:gogo/app/widgets/custom_clickable_text_prompt.dart';
import 'package:gogo/app/widgets/custom_primary_button.dart';
import 'package:gogo/app/widgets/custom_text_field.dart';

import '../../../routes/app_routes.dart';


class FogatePassScreen extends StatelessWidget {
  const FogatePassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
    builder: (controller) {
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
            // Positioned(
            //   top: 250.h,
            //   left: 0,
            //   right: 0,
            //   child: SlideTransition(
            //     position: controller.getstartedController.mdfBottleLogoPositionAnimation,
            //     child: ScaleTransition(
            //       scale: controller.getstartedController.scaleAnimation,
            //       child: Image.asset(
            //         ImageUtils.mdfbottoleLogo,
            //         width: 100.w,
            //         height: 100.h,
            //       ),
            //     ),
            //   ),
            // ),

            // Button with fade animation
            Positioned(
              bottom: 80.h,
              left: 20.w,
              right: 20.w,
              child: Column(
                spacing: 10,
                children: [
                  SlideTransition(
                    position: controller.getstartedController.mdfBottleLogoPositionAnimation,
                    child: ScaleTransition(
                      scale: controller.getstartedController.scaleAnimation,
                      child: Image.asset(
                        ImageUtils.mdfbottoleLogo,
                        width: 100.w,
                        height: 100.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  FadeTransition(
                    opacity: controller.getstartedController.fadeAnimation,
                    child: Text(
                      'Sent OTP',
                      style: TextStyle(
                          fontSize: 28.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  FadeTransition(
                    opacity: controller.getstartedController.fadeAnimation,
                    child: Column(
                      spacing: 10.h,
                      children: [
                        CustomTextField(
                          controller: controller.emailController,
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            // Handle email input
                          },
                        ),
                      ],
                    )
                  ),


                  SizedBox(
                    height: 100.h,
                  ),

                  FadeTransition(
                    opacity: controller.getstartedController.fadeAnimation,
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: "Sent OTP",
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Get.toNamed(AppRoutes.VerifyOtpScreen);
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
