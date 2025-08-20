import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';

class CustomSnackBar extends StatelessWidget {
  final String title;
  final String description;
  final SnackBarType type;

  const CustomSnackBar({
    Key? key,
    required this.title,
    required this.description,
    required this.type,
  }) : super(key: key);

  Color _getBackgroundColor() {
    switch (type) {
      case SnackBarType.Success:
        return CustomColors.successSnackBar;
      case SnackBarType.Warning:
        return CustomColors.waringSnackBar;
      case SnackBarType.Failure:
        return CustomColors.failureSnackBar;
      case SnackBarType.Light:
        return CustomColors.lightSnackBar;
    }
  }

  Icon _getIcon() {
    switch (type) {
      case SnackBarType.Success:
        return Icon(Icons.check_circle, color: Colors.green);
      case SnackBarType.Warning:
        return Icon(Icons.warning, color: Colors.orange);
      case SnackBarType.Failure:
        return Icon(Icons.close, color: Colors.red);
      case SnackBarType.Light:
        return Icon(Icons.home_work_outlined, color: Colors.black);
      default:
        return Icon(Icons.info, color: Colors.blue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: _getIcon(),
              ),
              const SizedBox(width: 12),
              // Title and Description with Scrollable Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: 100, // Set max height for scrolling
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Close Button
        Positioned(
          top: 10,
          right: 12,
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum SnackBarType { Success, Warning, Failure, Light }

void showCustomSnackBar({
  required BuildContext context,
  required SnackBarType type,
  required String title,
  required String description,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      width: MediaQuery.of(context).size.width,
      behavior: SnackBarBehavior.floating,
      content: CustomSnackBar(
        title: title,
        description: description,
        type: type,
      ),
    ),
  );
}
