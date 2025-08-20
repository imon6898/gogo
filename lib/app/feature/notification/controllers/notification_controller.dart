import 'package:get/get.dart';

class NotificationControllers extends GetxController {
  final notifications = <NotificationModel>[].obs;
  final isSelectionMode = false.obs;
  final selectedIndices = <int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.value = List.generate(10, (index) {
      return NotificationModel(
        title: 'MealDealFinder',
        message: index == 0
            ? 'Get up tp 50% discount on delicious meals from your favourite local restaurants. Don’t miss out, grab it before it’s gone!'
            : 'Enjoy up to 50% OFF on your favourite..',
        time: '2m ago',
        isDetailed: index == 0,
      );
    });
  }

  void selectAll() {
    if (selectedIndices.length == notifications.length) {
      // All items already selected → Deselect all
      selectedIndices.clear();
      isSelectionMode.value = false;
    } else {
      // Not all selected → Select all
      isSelectionMode.value = true;
      selectedIndices.clear();
      for (int i = 0; i < notifications.length; i++) {
        selectedIndices.add(i);
      }
    }
    update();
  }



  void removeNotification(int index) {
    notifications.removeAt(index);
  }

  void toggleSelectionMode() {
    isSelectionMode.toggle();
    if (!isSelectionMode.value) selectedIndices.clear();
    update();
  }

  void toggleItemSelected(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
      update();
    } else {
      selectedIndices.add(index);
      update();
    }
  }

  bool isSelected(int index) => selectedIndices.contains(index);
}



class NotificationModel {
  final String title;
  final String message;
  final String time;
  final bool isDetailed;

  NotificationModel({
    required this.title,
    required this.message,
    required this.time,
    this.isDetailed = false,
  });
}
