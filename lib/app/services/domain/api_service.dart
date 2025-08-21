
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as res;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../routes/app_routes.dart';
import '../../utils/constants/app_colors.dart';
import '../../widgets/custom_snack_bar.dart';
import '../cache_manager.dart';
import 'api_const.dart';


class ApiService {
  late Dio _dio;

  ApiService() {
    BaseOptions options = BaseOptions(
      baseUrl: kDebugMode ? ApiConstant.baseUrl : ApiConstant.baseUrl,
      receiveTimeout: const Duration(seconds: 50),
      connectTimeout: const Duration(seconds: 50),
    );

    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    try {
      options.headers["Authorization"] = "Bearer ${CacheManager.token}";
    } catch (e) {
      log("Authorization header error = $e");
    }

    _dio = Dio(options);
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        HttpClient client = HttpClient();
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 290,
      ));
    }
  }

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? params}) async {
    res.Response response;
    try {
      // If params are passed, they will be added as query parameters
      response = await _dio.get(
        endpoint,
        queryParameters: params, // Dynamically pass query parameters
      );
      return response;
    } on DioException catch (e) {
      errorHandle(e: e, requestMethod: "get = $endpoint");

      log("Get api error data = ${e.response}");
      log("Get api error data status code = ${e.response?.statusCode}");
      if (e.response?.statusCode == 401) {
        // await CacheManager.removeAllLocalData;
        log("Token invalid, navigating to sign-in screen.");
        //Get.offAllNamed(AppRoutes.LandingScreen);
      }

      /* Get.dialog(
        AlertDialog(
          title: Text('${e.response?.data['message'] ?? "timeout".tr}'),
          content: Text("${e.response?.data['error'] ?? 'serverTimeOutMsg'.tr}"),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );*/
    }
  }

  Future<dynamic> put(
      String endpoint,
      Map<String, dynamic> params) async {
    res.Response response;
    try {
      response = await _dio.put(endpoint, data: params);
      return response;
    } on DioException catch (e) {
      errorHandle(e: e, requestMethod: "put = $endpoint");
      log("check response Repo api service = ${e.response?.data['error']}");

      if (e.response?.statusCode == 401) {
        // await CacheManager.removeAllLocalData;
        log("Token invalid, navigating to sign-in screen.");
        //Get.offAllNamed(AppRoutes.LandingScreen);
      }
    }
  }

  Future<dynamic> post(String endpoint, dynamic params) async {
    res.Response response;
    try {

      response = await _dio.post(endpoint, data: params);


      return response;
    } on DioException catch (e) {
      errorHandle(e: e, requestMethod: "post = $endpoint");
      log("check response Repo api service e = $e");
      log("check response Repo api service status code = ${e.response?.statusCode}");
      log("check response Repo api service e.message = ${e.response?.data}");
      // if (e.response?.statusCode == null) {
      //   Get.offAllNamed(AppRoutes.LoginScreen);
      // }

      log("check response Repo api service = ${e.response?.data['error']}");
      return e.response;
    }
  }


  Future<bool> multipleFileUpload(String path, Map<String, dynamic> body, {required Map<String, File> files}) async {
    var formData = res.FormData.fromMap(body);

    for (var entry in files.entries) {
      formData.files.add(MapEntry(
        entry.key,
        await res.MultipartFile.fromFile(entry.value.path, filename: entry.value.path.split("/").last),
      ));
    }

    try {
      final response = await _dio.post(path, data: formData);
      // Assuming the response is a boolean
      return response.data as bool;
    } on DioException catch (e) {
      errorHandle(e: e, requestMethod: "POST $path");
      return false; // Handle the error appropriately
    }
  }


  Future<dynamic> patch(String endpoint, dynamic params) async {
    res.Response response;
    try {
      response = await _dio.patch(endpoint, data: params);
      return response;
    } on DioException catch (e) {
      errorHandle(e: e, requestMethod: "patch = $endpoint");


      log("check response Repo api service patch method  = ${e.response?.data['error']}");

      if (e.response?.statusCode == 401) {
        // await CacheManager.removeAllLocalData;
        log("Token invalid, navigating to sign-in screen.");
        //Get.offAllNamed(AppRoutes.LandingScreen);
      }
    }
  }

  Future<dynamic> delete(String endpoint) async {
    res.Response response;
    try {
      response = await _dio.delete(endpoint);
      return response;
    } on DioException catch (e) {
      errorHandle(e: e, requestMethod: "delete= $endpoint");
      log("check response Repo api service = $e");
      log("check response Repo api service = ${e.response?.statusCode}");
      log("check response Repo api service = ${e.message}");

      log("check response Repo api service = ${e.response?.data['error']}");

      if (e.response?.statusCode == 401) {
        // await CacheManager.removeAllLocalData();
        log("Token invalid, navigating to sign-in screen.");
        //Get.offAllNamed(AppRoutes.LandingScreen);
      }
    }
  }
}

errorHandle({required DioException e, required String requestMethod, BuildContext? context}) async {
  log(" Api Request Method: $requestMethod");
  log(" Api Request Method: ${e.type}");

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      log("DioErrorType.connectTimeout");
      break;
    case DioExceptionType.sendTimeout:
      log("DioErrorType.sendTimeout");
      break;
    case DioExceptionType.receiveTimeout:
      log("DioErrorType.receiveTimeout");
      break;
    case DioExceptionType.cancel:
      log("DioErrorType.cancel");
      break;
    case DioExceptionType.connectionError:
      log("DioErrorType.connectionError");
      break;
    case DioExceptionType.unknown:
      log("DioErrorType.other");
      break;
    case DioExceptionType.badCertificate:
      log("DioErrorType.badCertificate");
      // TODO: Handle this case.
      break;
    case DioExceptionType.badResponse:
      if (e.response?.statusCode == 401) {
        // Remove all local data when session is expired
        // await CacheManager.removeAllLocalData();
        log("Token invalid, navigating to sign-in screen.");
        if (context != null) {
          showCustomSnackBar(
            context: context,
            type: SnackBarType.Warning,
            title: "Warning",
            description: "You have logged out, Token invalid.",
          );
        }
        // Navigate to the sign-in screen
        //Get.offAllNamed(AppRoutes.LandingScreen);
      }

      // Log the response message
      // log("DioErrorType.badResponse ${e.response?.data['message']['phone'][0]}");
      // log("DioErrorType.badResponse ${e.response?.data['message'] ?? "timeout"}");
      break;
  }
}


String formatValidationMessages(Map<String, dynamic> messages) {
  StringBuffer formattedMessages = StringBuffer();

  messages.forEach((key, value) {
    if (value is String) {
      formattedMessages.writeln(value);
    } else if (value is List) {
      for (var message in value) {
        formattedMessages.writeln(message);
      }
    }
  });

  return formattedMessages.toString();
}

SnackbarController showErrorSnackbar({required String message}) {
  return Get.showSnackbar(
    GetSnackBar(
      title: 'Error',
      message: message,
      icon: const Icon(Icons.error, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: CustomColors.PrimaryColor,
      borderRadius: 20,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.slowMiddle,
    ),
  );
}