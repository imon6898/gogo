import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gogo/app/utils/constants/app_colors.dart';
import 'package:gogo/app/widgets/LoadingOverlay.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'controller/web_view_screen_controller.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebViewScreenController>(
      init: Get.find<WebViewScreenController>(), // Ensure no reinitialization
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            if (await controller.webController.canGoBack()) {
              await controller.webController.goBack();
              return false; // Prevent popping the route
            } else {
              return true; // Allow popping the route, will call onClose()
            }
          },
          child: Scaffold(
            backgroundColor: CustomColors.BGColor,
            body: SafeArea(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity != null) {
                    if (details.primaryVelocity! > 0) {
                      // Swipe right: Navigate back
                      controller.navigateBack();
                    } else if (details.primaryVelocity! < 0) {
                      // Swipe left: Navigate forward
                      controller.navigateForward();
                    }
                  }
                },
                child: LoadingOverlay(
                  isLoading: controller.isLoading,
                  child: WebViewWidget(
                    key: ValueKey(controller.url), // Unique key to avoid issues
                    controller: controller.webController,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
