import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gogo/app/feature/home/model/restaurant_response_model.dart';
import 'package:gogo/app/services/cache_manager.dart';

class FavoriteController extends GetxController {
  final searchController = TextEditingController();
  var allFavorites = <Restaurant>[].obs;
  var filteredFavorites = <Restaurant>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadFavorites();
    searchController.addListener(filterFavorites);
  }

  @override
  void onReady() {
    super.onReady();
    _loadFavorites();  // reload favorites whenever screen ready
  }


  void loadFavoritesFromCache() {
    final jsonString = CacheManager.getFavoriteRestaurant;
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        List<dynamic> decoded = jsonDecode(jsonString);
        allFavorites.assignAll(decoded.map((e) => Restaurant.fromJson(e)).toList());
        filteredFavorites.assignAll(allFavorites);
      } catch (e) {
        allFavorites.clear();
        filteredFavorites.clear();
      }
    } else {
      allFavorites.clear();
      filteredFavorites.clear();
    }
  }


  void _loadFavorites() {
    final jsonString = CacheManager.getFavoriteRestaurant;
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        List<dynamic> decoded = jsonDecode(jsonString);
        allFavorites.assignAll(decoded.map((e) => Restaurant.fromJson(e)).toList());
        filteredFavorites.assignAll(allFavorites);
      } catch (e) {
        allFavorites.clear();
        filteredFavorites.clear();
      }
    }
  }

  void filterFavorites() {
    final query = searchController.text.toLowerCase().trim();
    if (query.isEmpty) {
      filteredFavorites.assignAll(allFavorites);
    } else {
      filteredFavorites.assignAll(
        allFavorites.where((restaurant) {
          return (restaurant.name?.toLowerCase().contains(query) ?? false) ||
              (restaurant.type?.toLowerCase().contains(query) ?? false);
        }),
      );
    }
  }

  bool isFavorite(String id) {
    return allFavorites.any((r) => r.id == id);
  }

  void toggleFavorite(String id) {
    final index = allFavorites.indexWhere((r) => r.id == id);
    if (index != -1) {
      allFavorites.removeAt(index);

      if (allFavorites.isEmpty) {
        // If no favorites left, remove the whole cache key
        CacheManager.removeFavoriteRestaurant();
      } else {
        // Otherwise, update the cache with new favorites list
        _saveFavoritesToCache();
      }

      filterFavorites();
    }
  }



  void _saveFavoritesToCache() {
    final jsonList = allFavorites.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    CacheManager.setFavoriteRestaurant(jsonString);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
