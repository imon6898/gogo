import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gogo/app/utils/constants/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'controller/web_view_screen_controller.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebViewScreenController>(
      // Use Get.find if you registered the controller in a Binding.
      // Otherwise, replace with: init: Get.put(WebViewScreenController()),
      init: Get.find<WebViewScreenController>(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            final canGoBack = await controller.webController.canGoBack();
            if (canGoBack) {
              await controller.webController.goBack();
              return false; // don't pop route, just go back in web history
            }
            return true; // no web history -> pop route
          },
          child: Scaffold(
            backgroundColor: CustomColors.white,
            body: SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: WebViewWidget(controller: controller.webController),
                  ),
                  if (controller.isLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
