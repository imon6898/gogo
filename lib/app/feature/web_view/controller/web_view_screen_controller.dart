import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreenController extends GetxController {
  late WebViewController webController;
  bool isLoading = true;
  String title = '';
  String url = '';

  @override
  void onInit() {
    super.onInit();

    title = Get.arguments[0] ?? 'WebView';
    url = Get.arguments[1] ?? '';

    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {}, // Can show progress indicator
          onPageStarted: (_) {
            isLoading = true;
            update();
          },
          onPageFinished: (_) {
            isLoading = false;
            update();
          },
          onWebResourceError: (error) {
            debugPrint("Web error: ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  void navigateBack() async {
    if (await webController.canGoBack()) {
      await webController.goBack();
    } else {
      Get.back();
    }
  }

  void navigateForward() async {
    if (await webController.canGoForward()) {
      await webController.goForward();
    }
  }

  @override
  void onClose() {
    webController.clearCache();
    super.onClose();
  }
}
