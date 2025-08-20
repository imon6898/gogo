import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:gogo/app/feature/home/home_logic/home_repo.dart';
import 'package:gogo/app/feature/home/model/restaurant_response_model.dart';
import 'package:gogo/app/services/cache_manager.dart';

import '../home_logic/restaurant_load_more_repo.dart';

import 'dart:convert';  // for jsonEncode/jsonDecode

class HomeControllers extends GetxController {
  var searchMoveScreen = false.obs;
  void toggleSearchResult(bool value) {
    searchMoveScreen.value = value;
  }

  final HomeRepo _homeRepo = HomeRepo();

  late RestaurantLoadMoreRepo restaurantLoadMoreRepo;

  final ScrollController scrollController = ScrollController();
  final searchController = TextEditingController();

  var showSearchInAppBar = false.obs;
  var filteredDeals = [].obs;

  final favorites = <Restaurant>[].obs;


  @override
  void onInit() {
    super.onInit();

    restaurantLoadMoreRepo = RestaurantLoadMoreRepo(repository: _homeRepo);

    scrollController.addListener(() {
      if (scrollController.offset > 150) {
        showSearchInAppBar.value = true;
      } else {
        showSearchInAppBar.value = false;
      }
    });

    searchController.addListener(() {
      final query = searchController.text.trim();
      restaurantLoadMoreRepo.updateSearchTerm(query);
    });

    _loadFavoritesFromCache();  // Load favorites on init
  }

  // Load favorites from CacheManager and decode JSON string
  Future<void> _loadFavoritesFromCache() async {
    final jsonString = CacheManager.getFavoriteRestaurant;
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        List<dynamic> decoded = jsonDecode(jsonString);
        favorites.assignAll(decoded.map((e) => Restaurant.fromJson(e)).toList());
      } catch (e) {
        favorites.clear();
      }
    }
  }

  // Save favorites to CacheManager by encoding JSON string
  Future<void> _saveFavoritesToCache() async {
    final favoriteList = favorites.map((r) => r.toJson()).toList();
    final jsonString = jsonEncode(favoriteList);
    await CacheManager.setFavoriteRestaurant(jsonString);
  }

  bool isFavorite(String id) {
    return favorites.any((r) => r.id == id);
  }

  void toggleFavorite(Restaurant restaurant) {
    final index = favorites.indexWhere((r) => r.id == restaurant.id);
    if (index != -1) {
      favorites.removeAt(index);
    } else {
      favorites.add(restaurant);
    }
    _saveFavoritesToCache();  // Save full list
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    restaurantLoadMoreRepo.dispose();
    super.onClose();
  }
}
