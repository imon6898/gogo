// To parse this JSON data:
// final restaurantResponse = restaurantResponseFromJson(jsonString);

import 'dart:convert';

RestaurantResponse restaurantResponseFromJson(String str) => RestaurantResponse.fromJson(json.decode(str));

String restaurantResponseToJson(RestaurantResponse data) => json.encode(data.toJson());

class RestaurantResponse {
  final int? statusCode;
  final bool? success;
  final String? message;
  final RestaurantData? data;

  RestaurantResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) => RestaurantResponse(
    statusCode: json['statusCode'],
    success: json['success'],
    message: json['message'],
    data: json['data'] == null ? null : RestaurantData.fromJson(json['data']),
  );

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class RestaurantData {
  final List<Restaurant>? restaurants;
  final int? totalResult;
  final int? page;
  final int? limit;
  final int? totalPages;

  RestaurantData({
    this.restaurants,
    this.totalResult,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory RestaurantData.fromJson(Map<String, dynamic> json) => RestaurantData(
    restaurants: json['restaurants'] == null
        ? []
        : List<Restaurant>.from(json['restaurants'].map((x) => Restaurant.fromJson(x))),
    totalResult: json['totalResult'],
    page: int.tryParse(json['page'].toString()),
    limit: int.tryParse(json['limit'].toString()),
    totalPages: int.tryParse(json['totalPages'].toString()),
  );

  Map<String, dynamic> toJson() => {
    'restaurants': restaurants?.map((x) => x.toJson()).toList(),
    'totalResult': totalResult,
    'page': page,
    'limit': limit,
    'totalPages': totalPages,
  };
}

class Restaurant {
  final String? id;
  final String? restaurantId;
  final String? name;
  final String? type;
  final String? website;
  final bool? isHalal;
  final int? deliveryCharge;
  final int? minOrderAmount;
  final String? restaurantSize;
  final Location? location;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic distance;

  Restaurant({
    this.id,
    this.restaurantId,
    this.name,
    this.type,
    this.website,
    this.isHalal,
    this.deliveryCharge,
    this.minOrderAmount,
    this.restaurantSize,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.distance,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json['_id'],
    restaurantId: json['id'],
    name: json['name'],
    type: json['type'],
    website: json['website'],
    isHalal: json['isHalal'],
    deliveryCharge: json['deliveryCharge'],
    minOrderAmount: json['minOrderAmount'],
    restaurantSize: json['restaurantSize'],
    location: json['location'] == null ? null : Location.fromJson(json['location']),
    createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
    updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
    distance: json['distance'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'id': restaurantId,
    'name': name,
    'type': type,
    'website': website,
    'isHalal': isHalal,
    'deliveryCharge': deliveryCharge,
    'minOrderAmount': minOrderAmount,
    'restaurantSize': restaurantSize,
    'location': location?.toJson(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'distance': distance,
  };
}

class Location {
  final String? street;
  final String? city;
  final String? state;
  final String? postCode;
  final int? latitude;
  final int? longitude;

  Location({
    this.street,
    this.city,
    this.state,
    this.postCode,
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    street: json['street'],
    city: json['city'],
    state: json['state'],
    postCode: json['postCode'],
    latitude: json['latitude'],
    longitude: json['longitude'],
  );

  Map<String, dynamic> toJson() => {
    'street': street,
    'city': city,
    'state': state,
    'postCode': postCode,
    'latitude': latitude,
    'longitude': longitude,
  };
}
