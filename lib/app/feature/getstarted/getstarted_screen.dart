import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo/app/routes/app_routes.dart';
import 'package:gogo/app/services/cache_manager.dart';
import 'package:gogo/app/widgets/custom_primary_button.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_colors.dart';
import 'controllers/getstarted_controller.dart';

class GetstartedScreen extends StatelessWidget {
  const GetstartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetstartedController>(builder: (controller) {
      return Scaffold(
        backgroundColor: CustomColors.BGColor,
        body: SafeArea(

          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  children: [
                    _onboardingPage(
                      image: ImageUtils.Onboarding1,
                      title: "Welcome to\nAdventcircle 💖",
                      subtitle:
                      "Building stronger communities through faith and compassion together.",
                    ),
                    _onboardingPage(
                      HoriLogo: ImageUtils.AppHorizontalWhiteLogo,
                      image: ImageUtils.Onboarding2,
                      title: "Connecting faith",
                      subtitle:
                      "Stay connected with your faith community wherever you are, anytime, and keep growing together in unity",
                    ),
                    _onboardingPage(
                      HoriLogo: ImageUtils.AppHorizontalWhiteLogo,
                      image: ImageUtils.Onboarding3,
                      title: "Business & Community",
                      subtitle:
                      "Join a community of believers making a positive difference locally and globally through faith driven actions",
                    ),
                  ],
                ),
              ),
              // Hide bottom section only on first page
              if (controller.currentPage != 0)
                _bottomSection(controller),
            ],
          ),
        ),
      );
    });
  }

  Widget _onboardingPage({
    String? HoriLogo,
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (HoriLogo != null)
            Image.asset(
              HoriLogo,
              width: 200.w,
              height: 50.h,
            ),
          const SizedBox(height: 40),
          Expanded(child: Image.asset(image, fit: BoxFit.contain)),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _bottomSection(GetstartedController controller) {
    // Hide on first page (intro splash)
    if (controller.currentPage == 0) {
      return const SizedBox.shrink();
    }

    // Show only for page 1 and 2
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Indicator (for only 2 real onboarding pages: index 1 & 2)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              2,
                  (index) {
                // Map indicator index 0 → page 1, index 1 → page 2
                final actualIndex = index + 1;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: controller.currentPage == actualIndex ? 12 : 8,
                  height: 3,
                  decoration: BoxDecoration(
                    color: controller.currentPage == actualIndex
                        ? Colors.teal
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Button
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: controller.currentPage == 2 ? "Get Started" : "Next",
              onPressed: () {
                if (controller.currentPage == 2) {
                  controller.getStarted();
                } else {
                  controller.nextPage();
                }
              },
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

}



// Custom painter for curved top
class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width / 2, -100, size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
