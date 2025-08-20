import 'dart:developer';

import 'package:get/get.dart';
import 'package:gogo/app/services/cache_manager.dart';

import '../../../routes/app_routes.dart';

class MoreController extends GetxController {
  var isSettingsExpanded = false.obs;
  var isUserLink = false.obs;
  var isJoinExpanded = false.obs;
  var isLocationOn = true.obs;

  void toggleSettings() {
    isSettingsExpanded.toggle();
  }
  void toggleUserLink() {
    isUserLink.toggle();
  }

  void toggleJoin() {
    isJoinExpanded.toggle();
  }

  void toggleLocation() {
    isLocationOn.toggle();
  }


  Future<void> logout() async {
    log("Logging out...");
    bool removed = await CacheManager.removeToken();

    if (removed) {
      log("Token removed successfully");
      Get.offAllNamed(AppRoutes.LoginScreen);
    } else {
      log("Failed to remove token");
      Get.snackbar('Logout Failed', 'Could not remove token');
    }
  }

}
