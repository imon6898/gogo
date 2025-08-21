import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'package:gogo/app/feature/getstarted/controllers/getstarted_controller.dart';
import 'package:gogo/app/feature/splash_views/controllers/splash_controller.dart';
import 'package:gogo/app/feature/web_view/controller/web_view_screen_controller.dart';



class ViewModelBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<SplashScreenController>(() => SplashScreenController(), fenix: true);
    Get.lazyPut<GetstartedController>(() => GetstartedController(), fenix: true);
    Get.lazyPut<WebViewScreenController>(() => WebViewScreenController(), fenix: true);


  }
}