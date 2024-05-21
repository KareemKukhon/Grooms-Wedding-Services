import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:rafeed_provider/ServiceProviderApp/models/orderModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/ratingModel.dart';

class Service {
  String id;
  String providerId;
  String logo;
  String title;
  double price;
  String description;
  String category;
  String? status;
  List<String> cities;
  List<String> objectives;
  List<Order> orders;
  List<RatingModel>? ratings;

  Service({
    required this.id,
    required this.providerId,
    required this.logo,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    this.status,
    required this.cities,
    required this.objectives,
    required this.orders,
    this.ratings,
  });

  Service copyWith({
    String? id,
    String? providerId,
    String? logo,
    String? title,
    double? price,
    String? description,
    String? category,
    ValueGetter<String?>? status,
    List<String>? cities,
    List<String>? objectives,
    List<Order>? orders,
    ValueGetter<List<RatingModel>?>? ratings,
  }) {
    return Service(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      logo: logo ?? this.logo,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status != null ? status() : this.status,
      cities: cities ?? this.cities,
      objectives: objectives ?? this.objectives,
      orders: orders ?? this.orders,
      ratings: ratings != null ? ratings() : this.ratings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'providerId': providerId,
      'logo': logo,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'status': status,
      'cities': cities,
      'objectives': objectives,
      'orders': orders.map((x) => x.toMap()).toList(),
      'ratings': ratings?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Service.fromMap(Map<String, dynamic> map, {bool edit = false}) {
    return Service(
      id: map['_id'] ?? '',
      providerId: map['providerId'] ?? '',
      logo: map['logo'] ?? '',
      title: map['title'] ?? '',
      price: double.parse(map['price'].toString()),
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      status: map['status'],
      cities: List<String>.from(map['cities']),
      objectives: List<String>.from(map['objectives']),
      orders: edit
          ? map['orders']
          : map['orders'] != null
              ? List<Order>.from(map['orders']?.map((x) => Order.fromMap(x)))
              : [],
      ratings: edit
          ? map['ratings']
          : map['ratings'] != null
              ? List<RatingModel>.from(
                  map['ratings']?.map((x) => RatingModel.fromMap(x)))
              : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) =>
      Service.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Service(id: $id, providerId: $providerId, logo: $logo, title: $title, price: $price, description: $description, category: $category, status: $status, cities: $cities, objectives: $objectives, orders: $orders, ratings: $ratings)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Service &&
        other.id == id &&
        other.providerId == providerId &&
        other.logo == logo &&
        other.title == title &&
        other.price == price &&
        other.description == description &&
        other.category == category &&
        other.status == status &&
        listEquals(other.cities, cities) &&
        listEquals(other.objectives, objectives) &&
        listEquals(other.orders, orders) &&
        listEquals(other.ratings, ratings);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        providerId.hashCode ^
        logo.hashCode ^
        title.hashCode ^
        price.hashCode ^
        description.hashCode ^
        category.hashCode ^
        status.hashCode ^
        cities.hashCode ^
        objectives.hashCode ^
        orders.hashCode ^
        ratings.hashCode;
  }
}
