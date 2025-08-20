import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gogo/app/feature/location_permission_service.dart';
import 'package:gogo/app/services/cache_manager.dart';

import '../../../routes/app_routes.dart';

class GetstartedController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _logoAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _mdfLogoPositionAnimation;
  late Animation<Offset> _mdfBottleLogoPositionAnimation;

  @override
  void onInit() {
    super.onInit();

    // Initialize the animation controllers
    _fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _logoAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Set up animations
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOut,
    );

    _mdfLogoPositionAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
    ));

    _mdfBottleLogoPositionAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _fadeController.forward();
    _scaleController.forward();
    _logoAnimationController.forward();
  }

  Future<void> getStarted() async {
    await LocationPermissionService.requestLocationPermission();
    bool granted = await LocationPermissionService.requestLocationPermission();
    if (granted) {
      final position = await LocationPermissionService.getCurrentLocation();
      if (position != null) {
        debugPrint("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
      }
    }

    await CacheManager.setStartedId("1");
    Get.offAllNamed(AppRoutes.LoginScreen);
  }

  @override
  void onClose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _logoAnimationController.dispose();
    super.onClose();
  }

  Animation<double> get fadeAnimation => _fadeAnimation;
  Animation<double> get scaleAnimation => _scaleAnimation;
  Animation<Offset> get mdfLogoPositionAnimation => _mdfLogoPositionAnimation;
  Animation<Offset> get mdfBottleLogoPositionAnimation => _mdfBottleLogoPositionAnimation;
}
