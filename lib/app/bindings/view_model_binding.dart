import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:gogo/app/feature/auth/controllers/auth_controller.dart';
import 'package:gogo/app/feature/dashboard/controllers/dashboard_controller.dart';
import 'package:gogo/app/feature/favorites/controllers/favorite_controller.dart';
import 'package:gogo/app/feature/getstarted/controllers/getstarted_controller.dart';
import 'package:gogo/app/feature/history/controllers/history_controller.dart';
import 'package:gogo/app/feature/home/controllers/home_controllers.dart';
import 'package:gogo/app/feature/more/controllers/more_controller.dart';
import 'package:gogo/app/feature/notification/controllers/notification_controller.dart';
import 'package:gogo/app/feature/splash_views/controllers/splash_controller.dart';
import 'package:gogo/app/feature/web_view/controller/web_view_screen_controller.dart';


class ViewModelBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<SplashScreenController>(() => SplashScreenController(), fenix: true);
    Get.lazyPut<GetstartedController>(() => GetstartedController(), fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<HomeControllers>(() => HomeControllers(), fenix: true);
    Get.lazyPut<FavoriteController>(() => FavoriteController(), fenix: true);
    Get.lazyPut<NotificationControllers>(() => NotificationControllers(), fenix: true);
    Get.lazyPut<HistoryController>(() => HistoryController(), fenix: true);
    Get.lazyPut<MoreController>(() => MoreController(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<WebViewScreenController>(() => WebViewScreenController(), fenix: true);


  }
}
