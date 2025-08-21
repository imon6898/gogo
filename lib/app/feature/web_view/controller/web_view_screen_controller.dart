import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

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

    // Platform-specific params
    late final PlatformWebViewControllerCreationParams params;
    if (Platform.isAndroid) {
      params = AndroidWebViewControllerCreationParams();
    } else if (Platform.isIOS) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    webController = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setUserAgent(
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
            "AppleWebKit/537.36 (KHTML, like Gecko) "
            "Chrome/116.0.0.0 Safari/537.36",
      )
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
            _fixMixedContent(); // Fix mixed content after page loads
          },
          onWebResourceError: (error) {
            debugPrint("Web error: ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    // Platform-specific configuration
    _configurePlatformSpecifics();
  }

  void _configurePlatformSpecifics() {
    if (Platform.isAndroid) {
      _configureAndroidWebView();
    } else if (Platform.isIOS) {
      _configureIOSWebView();
    }
  }

  void _configureAndroidWebView() {
    final AndroidWebViewController androidController =
    webController.platform as AndroidWebViewController;

    // Configure Android-specific settings
    androidController.setMediaPlaybackRequiresUserGesture(false);

    // For Android, we can try to enable mixed content through platform channels
    // or use JavaScript workarounds
  }

  void _configureIOSWebView() {
    final WebKitWebViewController iosController =
    webController.platform as WebKitWebViewController;

    // Configure iOS-specific settings
    iosController.setAllowsBackForwardNavigationGestures(true);
  }

  // JavaScript solution for mixed content issues
  Future<void> _fixMixedContent() async {
    try {
      await webController.runJavaScript('''
        // Function to convert HTTP URLs to HTTPS
        function forceHttpsResources() {
          // Fix images
          document.querySelectorAll('img[src^="http:"]').forEach(img => {
            img.src = img.src.replace('http:', 'https:');
          });
          
          // Fix scripts
          document.querySelectorAll('script[src^="http:"]').forEach(script => {
            script.src = script.src.replace('http:', 'https:');
          });
          
          // Fix links (CSS, etc.)
          document.querySelectorAll('link[href^="http:"]').forEach(link => {
            link.href = link.href.replace('http:', 'https:');
          });
          
          // Fix iframes
          document.querySelectorAll('iframe[src^="http:"]').forEach(iframe => {
            iframe.src = iframe.src.replace('http:', 'https:');
          });
          
          // Fix source elements
          document.querySelectorAll('source[src^="http:"]').forEach(source => {
            source.src = source.src.replace('http:', 'https:');
          });
        }
        
        // Run initially
        forceHttpsResources();
        
        // Set up mutation observer to handle dynamically loaded content
        const observer = new MutationObserver(function(mutations) {
          mutations.forEach(function(mutation) {
            if (mutation.addedNodes.length > 0) {
              setTimeout(forceHttpsResources, 100);
            }
          });
        });
        
        observer.observe(document.body, {
          childList: true,
          subtree: true
        });
        
        // Also listen for load events on new elements
        document.addEventListener('load', function(e) {
          if (e.target && e.target.src && e.target.src.startsWith('http:')) {
            e.target.src = e.target.src.replace('http:', 'https:');
          }
        }, true);
      ''');
    } catch (e) {
      debugPrint("JavaScript injection error: $e");
    }
  }

  // Alternative: Try to load with HTTPS first, fallback to HTTP
  Future<void> loadUrlWithHttpsFallback(String originalUrl) async {
    final uri = Uri.parse(originalUrl);

    // Try HTTPS first
    final httpsUrl = uri.replace(scheme: 'https');

    try {
      await webController.loadRequest(httpsUrl);
    } catch (e) {
      // If HTTPS fails, try the original URL
      debugPrint("HTTPS failed, trying original URL: $e");
      await webController.loadRequest(uri);
    }
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

  // Reload the page with mixed content fix
  Future<void> reloadWithFix() async {
    isLoading = true;
    update();
    await webController.reload();
  }

  @override
  void onClose() {
    webController.clearCache();
    super.onClose();
  }
}