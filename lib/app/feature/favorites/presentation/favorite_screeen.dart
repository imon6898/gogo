import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gogo/app/feature/favorites/controllers/favorite_controller.dart';
import 'package:gogo/app/feature/home/presentation/home_screen.dart';
import 'package:gogo/app/utils/constants/app_colors.dart';
import 'package:gogo/app/widgets/custom_search_textfield.dart';

class FavoriteScreeen extends StatelessWidget {
  const FavoriteScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
      init: FavoriteController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: CustomColors.BGColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.h),
            child: AppBar(
              backgroundColor: CustomColors.mainColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              toolbarHeight: 70.h,
              title: SizedBox(
                height: 40.h,
                child: CustomSearchField(
                  controller: controller.searchController,
                  onChanged: (value) {
                    controller.loadFavoritesFromCache();
                    controller.filterFavorites(); // apply filter based on the latest cache
                  },
                  onTap: () {
                    controller.loadFavoritesFromCache(); // reload when user taps into search
                  },
                  hintText: 'Search by postcode/cuisine',
                  fillColor: Colors.white,
                  borderColor: CustomColors.white,
                  borderWidth: 2,
                ),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              controller.loadFavoritesFromCache();
            },
            child: Obx(() {
              final favorites = controller.filteredFavorites;
              if (favorites.isEmpty) {
                return const Center(child: Text('No favorite restaurants found.'));
              }
              return ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final restaurant = favorites[index];
                  return dealCardWrapper(
                    restaurant,
                    controller.isFavorite(restaurant.id ?? ''),
                        () => controller.toggleFavorite(restaurant.id ?? ''),
                  );
                },
              );
            }),
          ),
        );
      },
    );
  }
}
