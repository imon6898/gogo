import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  int selectedIndex = 2;

  final List<String> tabNames = [
    'Alerting',
    'Favorite',
    'Home',
    'History',
    'More',
  ];

  final List<IconData> icons = [
    Icons.notifications,
    Icons.favorite,
    Icons.home,
    Icons.history,
    Icons.menu_outlined,
  ];

  void changeTab(int index) {
    selectedIndex = index;
    update();
  }
}
