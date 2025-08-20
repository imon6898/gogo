import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gogo/app/utils/constants/app_assets.dart';
import 'controllers/notification_controller.dart';
import '../../widgets/custom_appbar.dart';
import '../../utils/constants/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationControllers>(
      init: NotificationControllers(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: CustomColors.BGColor,
          appBar: AppBar(
            backgroundColor: CustomColors.mainColor,
            title: Text("Notifications", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            centerTitle: true,
            actions: [
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white, // White background
                offset: Offset(0, kToolbarHeight),
                onSelected: (value) {
                  if (value == 'select') {
                    controller.toggleSelectionMode();
                  } else if (value == 'select_all') {
                    controller.selectAll();
                  }
                },

                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  // Top row: Delete and Mark as Read
                  PopupMenuItem<String>(
                    enabled: false,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPopupActionButton('Delete'),
                        _buildPopupActionButton('Mark as read'),
                      ],
                    ),
                  ),
                  PopupMenuItem(height: 2,padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),child: Divider(color: CupertinoColors.systemGrey2,)),

                  // Select
                  PopupMenuItem<String>(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    value: 'select',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Select", style: TextStyle(color: Colors.black)),
                        Icon(
                          controller.isSelectionMode.value
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: controller.isSelectionMode.value ? Colors.red : Colors.grey,
                        ),
                      ],
                    ),
                  ),


                  PopupMenuItem(height: 2,padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),child: Divider(color: CupertinoColors.systemGrey5,)),

                  // Select All
                  PopupMenuItem<String>(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    value: 'select_all',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Select All", style: TextStyle(color: Colors.black)),
                        Icon(
                          controller.isSelectionMode.value
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: controller.isSelectionMode.value ? Colors.red : Colors.grey,
                        ),                      ],
                    ),
                  ),
                ],
              ),
            ],


          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(() => ListView.builder(
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) {
                final item = controller.notifications[index];
                final isSelected = controller.isSelected(index);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: NotificationCard(
                    notification: item,
                    onDelete: () => controller.removeNotification(index),
                    isSelectionMode: controller.isSelectionMode.value,
                    isSelected: isSelected,
                    onTap: () => controller.toggleItemSelected(index),
                    controller: controller,
                  ),
                );
              },
            )),
          ),
        );
      },
    );
  }

  Widget _buildPopupActionButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // White button background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade400, // Light gray text to look disabled
        ),
      ),
    );
  }

}





class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onDelete;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback onTap;
  final NotificationControllers controller;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onDelete,
    required this.isSelectionMode,
    required this.isSelected,
    required this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      //direction: DismissDirection.values.,
      dismissThresholds: {
        DismissDirection.endToStart: 0.4,
      },
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete Notification'),
            content: Text('Are you sure you want to delete this notification?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Delete'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: CustomColors.CardsColour,
          borderRadius: BorderRadius.circular(12),
        ),
        child: GestureDetector(
          onTap: () => onDelete(),

          child: Container(
            height: 60.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text('Delete',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              )),
        ),
      ),
      child: InkWell(
    onTap: isSelectionMode ? onTap : null,

    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColors.CardsColour,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          if (controller.isSelectionMode.value)
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: isSelected ? Colors.red : Colors.grey,
                ),
              ),
            ),
          Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: SvgPicture.asset(ImageUtils.mdflogohorizontal, height: 24, width: 24)),
                    ),
                    SizedBox(width: 10),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'MealDeal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red)),
                          TextSpan(text: 'Finder', style: TextStyle(fontSize: 16, color: Colors.red)),
                        ],
                      ),
                    ),
                    Spacer(),
                    Text(notification.time, style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                SizedBox(height: 12),
                // Message
                notification.isDetailed
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Enjoy up to ",
                            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "50% OFF ",
                            style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "on your favourite meals!",
                            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(notification.message, style: TextStyle(fontSize: 14, color: Colors.black87)),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {},
                      child: Text("Explore your favourites"),
                    ),
                  ],
                )
                    : RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Enjoy up to ",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      TextSpan(
                        text: "50% OFF ",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      TextSpan(
                        text: "on your favourite..",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
            ),
      );
  }
}
