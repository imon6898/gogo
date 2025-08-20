
import 'package:get/get.dart';
import 'package:gogo/app/feature/auth/presentation/fogate_pass_screen.dart';
import 'package:gogo/app/feature/auth/presentation/login_screen.dart';
import 'package:gogo/app/feature/auth/presentation/registration_screen.dart';
import 'package:gogo/app/feature/auth/presentation/resetpass_screen.dart';
import 'package:gogo/app/feature/auth/presentation/verify_otp_screen.dart';
import 'package:gogo/app/feature/dashboard/dashboard_screen.dart';
import 'package:gogo/app/feature/favorites/presentation/favorite_screeen.dart';
import 'package:gogo/app/feature/getstarted/getstarted_screen.dart';
import 'package:gogo/app/feature/history/presentation/history_screen.dart';
import 'package:gogo/app/feature/home/presentation/home_screen.dart';
import 'package:gogo/app/feature/more/presentation/more_screen.dart';
import 'package:gogo/app/feature/splash_views/splash_screen.dart';
import 'package:gogo/app/feature/web_view/web_view_screen.dart';



import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.SplashScreen,
      page: () => SplashScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.GetstartedScreen,
      page: () => GetstartedScreen(),
      transition: Transition.upToDown,
      transitionDuration: Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.DashboardScreen,
      page: () => DashboardScreen(),
      transition: Transition.leftToRight,
    ),

    GetPage(
      name: AppRoutes.HomeScreen,
      page: () => HomeScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.FavoriteScreeen,
      page: () => FavoriteScreeen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.HistoryScreen,
      page: () => HistoryScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.MoreScreen,
      page: () => MoreScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.LoginScreen,
      page: () => LoginScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.RegistrationScreen,
      page: () => RegistrationScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.FogatePassScreen,
      page: () => FogatePassScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.VerifyOtpScreen,
      page: () => VerifyOtpScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.ResetpassScreen,
      page: () => ResetpassScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.WebViewScreen,
      page: () => WebViewScreen(),
      transition: Transition.rightToLeft,
    ),


  ];
}
