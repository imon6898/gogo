  import 'dart:developer';

import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:gogo/app/feature/auth/auth_logic/auth_repo.dart';
  import 'package:gogo/app/feature/getstarted/controllers/getstarted_controller.dart';
  import 'package:gogo/app/routes/app_routes.dart';
  import 'package:gogo/app/services/cache_manager.dart';

  class AuthController extends GetxController {
    late final GetstartedController getstartedController;

    TextEditingController otpController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailControllerLogin = TextEditingController();
    TextEditingController passControllerLogin = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController confirmPassController = TextEditingController();

    // For toggling password visibility
    RxBool isPasswordHidden = true.obs;
    RxBool isConfirmPasswordHidden = true.obs;
    RxBool rememberMe = false.obs;

    @override
    void onInit() {
      super.onInit();
      getstartedController = Get.find<GetstartedController>();

      emailControllerLogin.text = CacheManager.getLoginEmail ?? '';
      passControllerLogin.text = CacheManager.getLoginPassword ?? '';
    }

    void togglePasswordVisibility() {
      isPasswordHidden.value = !isPasswordHidden.value;
    }
    void toggleConfirmPasswordVisibility() {
      isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
    }


    Future<void> signIn() async {
      if (emailControllerLogin.text.isNotEmpty && passControllerLogin.text.isNotEmpty) {
        Map<String, dynamic> params = {
          'email': emailControllerLogin.text,
          'password': passControllerLogin.text,
        };

          final response = await AuthRepo().postLoginRepo(params);

          if (response != null && response.statusCode == 200 && response.data["success"] == true) {
            var responseData = response.data;
            String token = responseData["data"]["accessToken"]; // ✅ Correct access

            CacheManager.setToken(token);

            if (rememberMe.value) {
              await CacheManager.setLoginEmail(emailControllerLogin.text);
              await CacheManager.setLoginPassword(passControllerLogin.text);
            } else {
              await CacheManager.setLoginEmail('');
              await CacheManager.setLoginPassword('');
            }


            Get.offAllNamed(AppRoutes.DashboardScreen);
          } else {
            final errorMessage = response?.data["message"] ?? "Login failed";
            Get.snackbar('Error', errorMessage);
          }
      } else {
        Get.snackbar('Error', 'Please fill in all fields');
      }
    }


    Future<void> registrationIn() async {
      if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
        Map<String, dynamic> params = {
          'name': nameController.text,
          'email': emailController.text,
          'password': passController.text,
          // "phoneNumber": "1234567890",
          // "role": "USER",
          // "clientDetails": {
          //   "address": "123 Main Street, Cityville"
          // }
        };

          final response = await AuthRepo().postRegistrationRepo(params);

          if (response != null && response.statusCode == 201   && response.data["success"] == true) {
            var responseData = response.data;
            // String token = responseData["data"]["accessToken"]; // ✅ Correct access



            if (rememberMe.value) {
              await CacheManager.setLoginEmail(emailController.text);
              await CacheManager.setLoginPassword(passController.text);
            } else {
              await CacheManager.setLoginEmail(emailController.text);
              await CacheManager.setLoginPassword(passController.text);
            }


            Get.offAllNamed(AppRoutes.LoginScreen);
          } else {
            final errorMessage = response?.data["message"] ?? "Login failed";
            Get.snackbar('Error', errorMessage);
          }
      } else {
        Get.snackbar('Error', 'Please fill in all fields');
      }
    }
  }
