import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gogo/app/feature/location_permission_service.dart';
import 'app/bindings/view_model_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/services/cache_manager.dart';
import 'app/themes/app_theme.dart';
import 'app/utils/constants/app_text.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await ScreenUtil.ensureScreenSize();
  if (Platform.isIOS || Platform.isAndroid) {
    HttpOverrides.global = MyHttpOverrides();
  }
  if (!kIsWeb) {
    await dotenv.load(fileName: ".env");
  }

  await CacheManager.init();


  // bool granted = await LocationPermissionService.requestLocationPermission();
  // if (granted) {
  //   final position = await LocationPermissionService.getCurrentLocation(); // ✅ No error
  //   if (position != null) {
  //     debugPrint("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
  //   }
  // }

  //await _handleLocationPermissionAndLog();


  //Get.put(HomeController());
  runApp(const MyApp());
}





class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //return Obx(() {
      // Access the current theme state
      //final isDarkMode = Get.find<HomeController>().isDarkMode.value;

      // Update the status bar style based on theme
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        //statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark, // Icon color based on theme
        //statusBarBrightness: isDarkMode ? Brightness.light : Brightness.dark, // Light status bar for dark icons
      ));

      return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
            child: GetMaterialApp(
              builder: FToastBuilder(),
              debugShowCheckedModeBanner: false,
              translations: TextConst(),
              locale: _getLocaleFromCache(),
              fallbackLocale: const Locale('en', 'US'),
              initialBinding: ViewModelBinding(),
              title: 'MDF',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              //themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
              initialRoute: AppRoutes.SplashScreen,
              getPages: AppPages.list,
            ),
          );
        },
      );
    //});
  }


  Locale _getLocaleFromCache() {
    String? langId = CacheManager.getLanguageId.toString();
    log("Cached language ID: $langId");

    if (langId == '2') {
      log("Setting locale to Bengali (bn-BD)");
      return const Locale('bn', 'BD');
    }

    log("Setting locale to English (en-US)");
    return const Locale('en', 'US');
  }
}


