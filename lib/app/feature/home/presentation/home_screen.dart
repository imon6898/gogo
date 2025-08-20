import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:gogo/app/feature/home/model/restaurant_response_model.dart';
import 'package:gogo/app/widgets/custom_primary_button.dart';
import 'package:gogo/app/widgets/my_indicator.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../widgets/custom_search_textfield.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../controllers/home_controllers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControllers>(
      init: HomeControllers(),
      builder: (controller) => Obx(() => controller.searchMoveScreen.value == true
          ? _searchModeView(controller)
          : _homeModeView(controller)),
    );
  }
}

Widget _searchModeView(HomeControllers controller) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Scaffold(
        backgroundColor: CustomColors.BGColor,
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: AppBar(
            backgroundColor: CustomColors.mainColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            toolbarHeight: 70.h,
            leadingWidth: 50.w,
            leading: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: SizedBox(
                height: 40.h,
                width: 40.w,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    padding: EdgeInsets.only(left: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 25.sp),
                  ),
                ),
              )
            ),
            title: SizedBox(
              height: 40.h,
              child: CustomSearchField(
                controller: controller.searchController,
                hintText: 'Search by postcode/cuisine',
                fillColor: Colors.white,
                borderColor: CustomColors.white,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                borderWidth: 2,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(6.w),
                child: SizedBox(
                  height: 40.h,
                  width: 40.w,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.filter_list, color: CustomColors.mainColor, size: 22.sp),
                    ),
                  ),
                )
              )
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.restaurantLoadMoreRepo.refresh(true);
          },
          child: LoadingMoreList(
            ListConfig<Restaurant>(
              itemBuilder: (context, restaurant, index) {
                return Obx(() => dealCardWrapper(
                  restaurant,
                  controller.isFavorite(restaurant.id ?? 'unknown'),
                      () => controller.toggleFavorite(restaurant), // pass the whole object
                ));
              },
              sourceList: controller.restaurantLoadMoreRepo,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              indicatorBuilder: (c, indicatorStatus){
                return MyIndicator(indicatorStatus);
              },
            ),
          ),
        )
      );
    },
  );
}

Widget _homeModeView(HomeControllers controller) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Scaffold(
        backgroundColor: CustomColors.BGColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: CustomColors.mainColor,
          automaticallyImplyLeading: false, // Don't insert default back button space
          titleSpacing: 0, // Remove title spacing too
          title: SvgPicture.asset(
            ImageUtils.mdflogohorizontal,
            color: CustomColors.white,
            fit: BoxFit.cover,
            width: 300.w,
          ),        leadingWidth: 300.w,
          actions: [
            //IconButton(onPressed: () {}, icon: Icon(Icons.share, color: Colors.white)),
            //SizedBox(width: 5.w),
            IconButton(onPressed: () {
              Get.toNamed(AppRoutes.LoginScreen);
            }, icon: Icon(Icons.account_circle_outlined, color: Colors.white)),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.restaurantLoadMoreRepo.refresh(true);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topBanner(controller),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              //   child: Text("Nearby Deals", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: CustomColors.mainColor)),
              // ),
              Expanded(
                child: LoadingMoreList(
                  ListConfig<Restaurant>(
                    itemBuilder: (context, restaurant, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nearby Deals", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: CustomColors.mainColor)),
                          Obx(() => dealCardWrapper(
                            restaurant,
                            controller.isFavorite(restaurant.id ?? 'unknown'),
                                () => controller.toggleFavorite(restaurant), // pass the whole object
                          )),
                        ],
                      );
                    },
                    sourceList: controller.restaurantLoadMoreRepo,
                    padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 0.h, bottom: 8.h),
                    indicatorBuilder: (c, indicatorStatus){
                      return MyIndicator(indicatorStatus);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget _topBanner(HomeControllers controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        children: [
          Container(
            width: double.infinity,
            height: 0.38.sh,
            child: Stack(
              children: [
                // Background container color or decoration if needed
                Container(), // Optional

                // Positioned image taking a smaller height
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 0.26.sh, // Smaller than the container height
                    child: Image.asset(
                      ImageUtils.chickentikkamasala,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 115.h,
            left: 16.w,
            right: 16.w,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: CustomColors.NavbarColour,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, offset: Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Whatever's your flavour", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                  Text("Search for the best deals near you", style: TextStyle(fontSize: 14.sp, color: CustomColors.black)),
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 40.h,
                    child: CustomSearchField(
                      controller: controller.searchController,
                      hintText: 'Search by postcode/cuisine',
                      fillColor: Colors.white,
                      onTap: () => controller.toggleSearchResult(true),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Divider(height: 1, color: Colors.grey),
      SizedBox(height: 10.h),
    ],
  );
}

Widget dealCardWrapper(Restaurant restaurant, bool isFavorite, VoidCallback onPressed) {
  return GestureDetector(
    onTap: (){
      Navigator.push(
        Get.context!,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 800),
          reverseTransitionDuration: Duration(milliseconds: 800),
          pageBuilder: (_, animation, __) => FadeTransition(
            opacity: animation,
            child: RestaurantDetailScreen(restaurant: restaurant),
          ),
        ),
      );
      // Get.toNamed(
      //   AppRoutes.RestaurantDetailScreen,
      //   arguments: restaurant,
      // );
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: CustomColors.NavbarColour,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                // onTap: () async {
                //   try {
                //     await launchUrl(
                //       Uri.parse(restaurant.website ?? 'https://example.com'),
                //       customTabsOptions: const CustomTabsOptions(
                //         showTitle: true,
                //         urlBarHidingEnabled: true,
                //         shareState: CustomTabsShareState.on,
                //       ),
                //       safariVCOptions: const SafariViewControllerOptions(
                //         preferredBarTintColor: Colors.white,
                //         preferredControlTintColor: Colors.black,
                //         barCollapsingEnabled: true,
                //       ),
                //     );
                //   } catch (e) {
                //     debugPrint('Failed to launch: $e');
                //   }
                // },
                // onTap: () {
                //   Get.toNamed(
                //     AppRoutes.WebViewScreen,
                //     arguments: ["webView".tr,  "${restaurant.website ?? ''}"],
                //   );
                // },
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                  child: Image.asset(
                    ImageUtils.chickentikkamasala,
                    width: double.infinity,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              if (restaurant.isHalal == true)
              Positioned(
                top: 0.h,
                right: 0.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: CustomColors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Halal',
                    style: TextStyle(color: CustomColors.green, fontSize: 14.sp),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.h,
                child: Container(
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(color: CustomColors.black.withOpacity(0.7)),
                  child: Text(
                    "${restaurant.name ?? 'Unknown'} (${restaurant.type ?? ''})",
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('No discount', style: TextStyle(fontSize: 14.sp, color: Colors.red)),
                    Text("Min: \$${restaurant.minOrderAmount.toString() ?? ''}", style: TextStyle(fontSize: 14.sp, color: CustomColors.black)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${'reting'} (${'retingPeople'})", style: TextStyle(fontSize: 12.sp, color: CustomColors.black)),
                    Text("Distance: ${restaurant.distance.toString() ?? ''}", style: TextStyle(fontSize: 12.sp, color: CustomColors.black)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Delivery fee: \$${restaurant.deliveryCharge.toString() ?? ''}", style: TextStyle(fontSize: 14.sp, color: CustomColors.black)),
                    IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border, // filled if favorite, outlined otherwise
                        color: isFavorite ? Colors.red : null,               // red color if favorite, default color otherwise
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}



class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: SizedBox(
          height: 40.h,
          child: CustomButton(
            text: "Order Now",
            onPressed: () {
              Get.toNamed(
                AppRoutes.WebViewScreen,
                arguments: ["webView".tr,  "${restaurant.website}/menu"],
              );
            },
            // onPressed: () async {
            //     try {
            //       await launchUrl(
            //         Uri.parse("${restaurant.website}/menu" ?? ''),
            //         customTabsOptions: const CustomTabsOptions(
            //           showTitle: true,
            //           urlBarHidingEnabled: true,
            //           shareState: CustomTabsShareState.on,
            //         ),
            //         safariVCOptions: const SafariViewControllerOptions(
            //           preferredBarTintColor: Colors.white,
            //           preferredControlTintColor: Colors.black,
            //           barCollapsingEnabled: true,
            //         ),
            //       );
            //     } catch (e) {
            //       debugPrint('Failed to launch: $e');
            //     }
            // },
            backgroundColor: CustomColors.mainColor,
            borderRadius: 30.0,
            textStyle: TextStyle(
              color: CustomColors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟢 HERO IMAGE
            Stack(
              children: [
                Hero(
                  tag: 'restaurantCard_${restaurant.id}',
                  child: ClipRRect(
                    child: Image.asset(
                      ImageUtils.chickentikkamasala,
                      width: double.infinity,
                      height: 250.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 40.h,
                  left: 16.w,
                  child: SizedBox(
                    height: 40.h,
                    width: 40.w,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(20.r),
                      child: Container(
                        padding: EdgeInsets.only(left: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 25.sp),
                      ),
                    ),
                  )
                ),
              ],
            ),

            // 🔵 Promo Banner
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Enjoy Up to ',
                    children: [
                      TextSpan(
                        text: '25% OFF ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'dine-in food only. T&Cs apply - '),
                      TextSpan(
                        text: 'Proceed to book',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // 🔴 Restaurant Info
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: restaurant.name ?? '',
                          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' (${restaurant.type})',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text("Rating: "),
                      Icon(Icons.star, size: 18.sp, color: Colors.orange),
                      SizedBox(width: 4.w),
                      Text("${'5.0'} (${'120'})"),
                      Spacer(),
                      Icon(Icons.location_on, size: 18.sp, color: Colors.red),
                      SizedBox(width: 4.w),
                      Text("${restaurant.distance} M"),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Minimum: £${restaurant.minOrderAmount}"),
                      Text("Delivery Fee: £${restaurant.deliveryCharge}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery: ${"50"} Min"),
                      Text("Collection: ${"20"} Min"),
                    ],
                  ),
                ],
              ),
            ),

            // 🔻 Deal Banner
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(16.w),
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 10),
                ],
              ),
              child: Column(
                children: [
                  Image.asset(ImageUtils.mdfFulllogo, height: 50.h, width: 250, color: Colors.red),
                  SizedBox(height: 10.h),
                  Text.rich(
                    TextSpan(
                      text: '30% OFF ',
                      style: TextStyle(color: Colors.red, fontSize: 16.sp, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: 'online orders',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text("Delivery or Collection\nFood item only", textAlign: TextAlign.center),
                ],
              ),
            ),

            SizedBox(height: 16.h), // spacing before bottom button
          ],
        ),
      ),
    );
  }
}
