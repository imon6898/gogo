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

    title = (Get.arguments?[0] ?? 'WebView').toString();
    url = (Get.arguments?[1] ?? '').toString();

    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setUserAgent(
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
              "AppleWebKit/537.36 (KHTML, like Gecko) "
              "Chrome/116.0.0.0Safari/537.36")
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (_) {},
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

  Future<void> navigateBack() async {
    if (await webController.canGoBack()) {
      await webController.goBack();
    } else {
      Get.back();
    }
  }

  Future<void> navigateForward() async {
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
