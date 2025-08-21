import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gogo/app/services/cache_manager.dart';
import '../../../routes/app_routes.dart';

class GetstartedController extends GetxController {
  late PageController pageController;
  int currentPage = 0;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();

    // Auto move from first page after 2 sec
    Future.delayed(const Duration(seconds: 2), () {
      if (pageController.hasClients) {
        pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void onPageChanged(int index) {
    currentPage = index;
    update();
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> getStarted() async {
    await CacheManager.setStartedId("1");
    Get.offAllNamed(
      AppRoutes.WebViewScreen,
      arguments: ["webView".tr, "https://adventcircle.com/"],
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

