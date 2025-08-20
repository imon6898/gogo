


import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gogo/app/feature/location_permission_service.dart';

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

    // Navigate after 2 seconds, checking for token
    // Future.delayed(const Duration(seconds: 3), () async {
    //   String? token = CacheManager.token; // Retrieve the token
    //
    //   if (token != null && token.isNotEmpty) {
    //     // Token exists, navigate to SideMenuView
    //     //Get.offAllNamed(AppRoutes.SideMenuView);
    //   } else {
    //     // No token, navigate to SigninScreen
    //     //_handleLocationPermissionAndLog();
    //
    //
    //     bool granted = await LocationPermissionService.requestLocationPermission();
    //     if (granted) {
    //       final position = await LocationPermissionService.getCurrentLocation(); // ✅ No error
    //       if (position != null) {
    //         debugPrint("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
    //       }
    //     }
    //
    //    Get.offAllNamed(AppRoutes.GetstartedScreen);
    //   }
    // });

    Future.delayed(const Duration(seconds: 3), () async {
      String? token = CacheManager.token;
      String? startedId = CacheManager.getStartedId;

      Get.offAllNamed(
        AppRoutes.WebViewScreen,
        arguments: ["webView".tr,  "https://gogo.easital.com/"],
      );

      // if (token != null && token.isNotEmpty) {
      //
      //   Get.offAllNamed(AppRoutes.DashboardScreen);
      // } else {
      //   // Location permission request
      //   // bool granted = await LocationPermissionService.requestLocationPermission();
      //   // if (granted) {
      //   //   final position = await LocationPermissionService.getCurrentLocation();
      //   //   if (position != null) {
      //   //     debugPrint("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
      //   //   }
      //   // }
      //
      //   if (startedId == "1") {
      //
      //     Get.offAllNamed(AppRoutes.LoginScreen);
      //   } else {
      //
      //     Get.offAllNamed(AppRoutes.GetstartedScreen);
      //   }
      // }
    });

  }


  // Future<void> _handleLocationPermissionAndLog() async {
  //   try {
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
  //       permission = await Geolocator.requestPermission();
  //     }
  //
  //     if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
  //       final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //       debugPrint('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
  //     } else {
  //       debugPrint("Location permission not granted.");
  //     }
  //   } catch (e) {
  //     debugPrint("Error getting location: $e");
  //   }
  // }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
