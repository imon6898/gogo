import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading; // Custom leading widget (e.g., back button, menu)
  final Widget? title; // Title widget
  final int? titleBottom; // Space below title
  final List<Widget>? actions; // List of action widgets
  final bool centerTitle; // Center the title
  final double height; // Customizable AppBar height
  final Color backgroundColor; // Background color of the AppBar
  final Color? bottomBorderColor; // Color of the bottom border
  final double borderWidth; // Thickness of the bottom border
  final EdgeInsets padding; // Custom padding for the AppBar

  const CustomAppBar({
    Key? key,
    this.leading,
    this.title,
    this.titleBottom = 20,
    this.actions,
    this.centerTitle = false,
    this.height = 56, // Default AppBar height
    this.backgroundColor = Colors.transparent,
    this.bottomBorderColor = const Color(0xffDDDDDD),
    this.borderWidth = 1.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Column(
      children: [
        Container(
          height: height + statusBarHeight,
          decoration: BoxDecoration(color: backgroundColor),
          padding: EdgeInsets.only(top: statusBarHeight).add(padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Leading widget
              if (leading != null) leading!,
              SizedBox(width: leading != null ? 8.0 : 0),

              // Title Widget
              if (title != null)
                centerTitle
                    ? Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - (leading != null ? 56 : 0) - (actions != null ? 56 : 0),
                      child: Center(child: title!),
                    ),
                  ),
                )
                    : Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: title!,
                  ),
                ),

              // Spacer to push actions to the end
              if (actions != null && !centerTitle) const Spacer(),

              // Action Widgets
              if (actions != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions!,
                ),
            ],
          ),
        ),
        // Bottom Border with Padding
        if (bottomBorderColor != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              color: AppTheme.isDarkMode(context) ? const Color(0xff3f3f3f) : const Color(0xffDDDDDD),
              thickness: borderWidth,
              height: 0,
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
