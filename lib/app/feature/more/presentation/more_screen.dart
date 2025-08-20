import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gogo/app/feature/more/controllers/more_controller.dart';
import 'package:gogo/app/utils/constants/app_assets.dart';
import 'package:gogo/app/utils/constants/app_colors.dart';

import '../../../routes/app_routes.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoreController>(
      init: MoreController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: CustomColors.BGColor,
          appBar: AppBar(
            backgroundColor: CustomColors.mainColor,
            title: SvgPicture.asset(
              ImageUtils.mdflogohorizontal,
              color: CustomColors.white,
            ),
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              buildExpandableTile(
                controller: controller,
                icon: Icons.handshake_outlined,
                title: 'Join To',
                isExpanded: controller.isJoinExpanded.value,
                onTap: () => controller.toggleJoin(),
              ),
              buildExpandableTile(
                controller: controller,
                icon: Icons.email_outlined,
                title: 'Contact Us',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                isExpanded: false,
              ),
              buildExpandableTile(
                controller: controller,
                icon: Icons.info_outline,
                title: 'About Us',
                isExpanded: false,
              ),
              Obx(() => buildExpandableTile(
                controller: controller,
                icon: Icons.settings,
                title: 'Settings',
                backgroundColor: controller.isSettingsExpanded.value
                    ? Colors.red
                    : Colors.white,
                titleColor: controller.isSettingsExpanded.value
                    ? Colors.white
                    : Colors.black,
                iconColor: Colors.black,

                trailing: Icon(
                  controller.isSettingsExpanded.value
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: controller.isSettingsExpanded.value
                      ? Colors.white
                      : Colors.red,
                ),
                isExpanded: controller.isSettingsExpanded.value,
                onTap: () => controller.toggleSettings(),
                children: [
                  ListTile(
                    leading: const Icon(Icons.my_location, color: Colors.black),
                    title: const Text('Location service', style: TextStyle(color: Colors.black)),
                    trailing: Switch(
                      value: controller.isLocationOn.value,
                      onChanged: (value) => controller.toggleLocation(),
                      activeColor: Colors.green,
                    ),
                  ),
                  // const Divider(height: 1),
                  // const ListTile(
                  //   leading: Icon(Icons.language, color: Colors.black),
                  //   title: Text('Language', style: TextStyle(color: Colors.black)),
                  //   trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  // ),
                  // const Divider(height: 1),
                  // const ListTile(
                  //   leading: Icon(Icons.color_lens),
                  //   title: Text('App theme'),
                  //   trailing: Icon(Icons.keyboard_arrow_down),
                  // ),
                ],
              )),
              Obx(() => buildExpandableTile(
                controller: controller,
                icon: Icons.link,
                title: 'Useful link',
                backgroundColor: controller.isUserLink.value
                    ? Colors.red
                    : Colors.white,
                titleColor: controller.isUserLink.value
                    ? Colors.white
                    : Colors.black,
                iconColor: Colors.black,
                trailing: Icon(
                  controller.isUserLink.value
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: controller.isUserLink.value
                      ? Colors.white
                      : Colors.red,
                ),
                isExpanded: controller.isUserLink.value,
                onTap: () => controller.toggleUserLink(),
                children: [
                  ListTile(
                    leading: Icon(Icons.privacy_tip_outlined, color: Colors.black),
                    title: Text('Privacy policy', style: TextStyle(color: Colors.black)),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.WebViewScreen,
                        arguments: ["webView".tr,  "https://policies.google.com/privacy?hl=en-US"],
                      );
                    },
                  ),
                  const Divider(height: 1),
                   ListTile(
                    leading: Icon(Icons.task, color: Colors.black),
                    title: Text('Terms of condition', style: TextStyle(color: Colors.black)),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.WebViewScreen,
                        arguments: ["webView".tr,  "https://policies.google.com/privacy?hl=en-US"],
                      );
                    },
                    ),
                ],
              )),
              buildExpandableTile(
                controller: controller,
                icon: Icons.logout_sharp,
                iconColor: CustomColors.mainColor,
                title: 'Log Out',
                isExpanded: controller.isJoinExpanded.value,
                onTap: () => controller.logout(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildExpandableTile({
    required MoreController controller,
    required IconData icon,
    required String title,
    required bool isExpanded,
    VoidCallback? onTap,
    List<Widget> children = const [],
    Widget? trailing,
    Color? backgroundColor,
    Color? titleColor,
    Color? iconColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: backgroundColor ?? Colors.white,
          borderRadius: isExpanded
              ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          )
              : BorderRadius.circular(12),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Row(
                children: [
                  Icon(icon, color: iconColor ?? Colors.black),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: titleColor ?? Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (trailing != null) trailing,
                ],
              ),
            ),
          ),
        ),
        ...isExpanded
            ? [
          Container(
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border(
                  left: BorderSide(color: Colors.black, width: 1),
                  right: BorderSide(color: Colors.black, width: 1),
                  bottom: BorderSide(color: Colors.black, width: 1)),
            ),
            child: Column(
              children: children,
            ),
          ),
        ]
            : [],

        const SizedBox(height: 12),
      ],
    );
  }
}
