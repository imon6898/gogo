// /// How to use for set
// ///         await CacheManager.setId(data['id'] ?? "");
// ///         await CacheManager.setToken(data['token'] ?? "");
// ///         await CacheManager.setEmail(data['email'] ?? "");
// ///         await CacheManager.setFirstName(data['firstName'] ?? "");
// ///         await CacheManager.setSignUpAs(data['signUpAs'] ?? "");
// ///         await CacheManager.setDriverId(data['driverId'] ?? "");
// ///         await CacheManager.setPictureBase64(data['pictureBase64'] ?? "");

// /// How to use for get
// ///         String? email = CacheManager.email;

import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {

  static SharedPreferences? _pref;

  static Future<void> init() async {_pref = await SharedPreferences.getInstance();}


  // Setters
  static Future<bool> setToken(String tokenValue) async {log("Saving Token: $tokenValue");return await _saveToCache(CacheKeys.token.name, tokenValue);}
  static Future<bool> setFavoriteRestaurant(String favoriteRestaurantValue) async {log("Saving Favorite Restaurant: $favoriteRestaurantValue");return await _saveToCache(CacheKeys.favoriteRestaurant.name, favoriteRestaurantValue);}
  static Future<bool> setLanguageId(String languageId) async {log("Setting Language ID: $languageId");return await _saveToCache(CacheKeys.languageId.name, languageId);}
  static Future<bool> setThemeId(String themeId) async {log("Setting Theme ID: $themeId");return await _saveToCache(CacheKeys.themeId.name, themeId);}
  static Future<bool> setStartedId(String startedId) async {log("Setting Started ID: $startedId");return await _saveToCache(CacheKeys.startedId.name, startedId);}
  static Future<bool> setLoginEmail(String loginEmail) async {log("Login Email: $loginEmail");return await _saveToCache(CacheKeys.loginEmail.name, loginEmail);}
  static Future<bool> setLoginPassword(String loginPassword) async {log("Login Password: $loginPassword");return await _saveToCache(CacheKeys.loginPassword.name, loginPassword);}



  // Getters
  static String? get token {var value = _getFromCache<String>(CacheKeys.token.name);log("Retrieved Token: $value");return value;}
  static String? get getFavoriteRestaurant {var value = _getFromCache<String>(CacheKeys.favoriteRestaurant.name);log("Retrieved Favorite Restaurant: $value");return value;}
  static String? get getLanguageId {var value = _getFromCache<String>(CacheKeys.languageId.name);log("Language ID: $value");return value ?? '1';}
  static String? get getThemeId {var value = _getFromCache<String>(CacheKeys.themeId.name);log("Theme ID: $value");return value;}
  static String? get getStartedId {var value = _getFromCache<String>(CacheKeys.startedId.name);log("Started ID: $value");return value;}
  static String? get getLoginEmail {var value = _getFromCache<String>(CacheKeys.loginEmail.name);log("Login Email: $value");return value;}
  static String? get getLoginPassword {var value = _getFromCache<String>(CacheKeys.loginPassword.name);log("Login Password: $value");return value;}



  // Removers
  static Future<bool> removeToken() async {log("Removing Token");return await _remove(CacheKeys.token.name);}
  static Future<bool> removeFavoriteRestaurant() async {log("Removing Favorite Restaurant from cache");return await _remove(CacheKeys.favoriteRestaurant.name);}



  // Helper function to remove a value from cache
  static Future<bool> _remove(String key) async {
    if (_pref == null) {
      log("SharedPreferences instance is null. Cannot remove key: $key");
      return false;
    }
    if (!_pref!.containsKey(key)) {
      log("Key '$key' does not exist in cache. Nothing to remove.");
      return false;
    }
    final removed = await _pref!.remove(key);
    log("Removed key '$key' from cache: $removed");
    return removed;
  }

  // Helper function to get data from cache
  static dynamic _getFromCache<T>(String key) {
    log("Getting $key as type: \${T.toString()}");
    if (_pref == null) return '';
    if (T == int) {
      return _pref!.getInt(key) ?? 0;
    } else if (T == bool) {
      return _pref!.getBool(key) ?? false;
    }
    return _pref!.getString(key) ?? '';
  }

  // Helper function to save data to cache
  static Future<bool> _saveToCache(String key, dynamic value) async {
    log("Saving $key with value: $value of type: ${value.runtimeType}");
    if (_pref == null || value == null) return false;
    print("asfdashgdas");
    if (value is bool) {
      return await _pref!.setBool(key, value);
    } else if (value is int) {
      return await _pref!.setInt(key, value);
    }
    return await _pref!.setString(key, value);
  }
}

enum CacheKeys {
  token,
  favoriteRestaurant,
  themeId,
  languageId,
  startedId,
  loginEmail,
  loginPassword
}

