import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gogo/app/feature/favorites/presentation/favorite_screeen.dart';
import 'package:gogo/app/feature/history/presentation/history_screen.dart';
import 'package:gogo/app/feature/more/presentation/more_screen.dart';
import 'package:gogo/app/feature/notification/notification_screen.dart';
import '../../utils/constants/app_colors.dart';
import '../home/presentation/home_screen.dart';
import 'controllers/dashboard_controller.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: CustomColors.BGColor,
          body: IndexedStack(
            index: controller.selectedIndex,
            children: [
              NotificationScreen(),
              FavoriteScreeen(),
              HomeScreen(),
              HistoryScreen(),
              MoreScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            useLegacyColorScheme: false,
            elevation: 4,
            currentIndex: controller.selectedIndex,
            onTap: controller.changeTab,
            type: BottomNavigationBarType.fixed,
            backgroundColor: CustomColors.NavbarColour,
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.red,
            showSelectedLabels: true,
            selectedLabelStyle: TextStyle(fontSize: 10.w, fontWeight: FontWeight.w600, color: Colors.red),
            items: List.generate(controller.tabNames.length, (index) {
              final isSelected = controller.selectedIndex == index;
              return BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? CustomColors.NavbarSelectColour : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        controller.icons[index],
                        size: isSelected ? 14.w : 20.w,
                      ),
                      if (isSelected) SizedBox(width: 4.w),
                      if (isSelected)
                        Text(
                          controller.tabNames[index],
                          style: TextStyle(fontSize: 10.w, fontWeight: FontWeight.w600, color: Colors.red),
                        ),
                    ],
                  ),
                ),
                label: "",
              );
            }),
          ),
        );
      },
    );
  }
}
