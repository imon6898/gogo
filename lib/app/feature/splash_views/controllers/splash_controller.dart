


import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/cache_manager.dart';

class SplashScreenController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    super.onInit();

    // Animation setup
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    animationController.forward();

    Future.delayed(const Duration(seconds: 3), () async {
      String? token = CacheManager.token;
      String? startedId = CacheManager.getStartedId;
      
      // if (startedId == "1") {
        Get.offAllNamed(
          AppRoutes.WebViewScreen,
          arguments: ["webView".tr,  "https://gogo.easital.com/"],
        );
      // } else {
      //   Get.offAllNamed(AppRoutes.GetstartedScreen);
      // }
    });

  }




  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
