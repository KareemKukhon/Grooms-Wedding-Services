import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:Rafeed/models/orderModel.dart';
import 'package:Rafeed/models/providerModel.dart';
import 'package:Rafeed/models/ratingModel.dart';

class ServiceModel {
  String? id;
  String? providerId;
  String logo;
  String title;
  double price;
  String description;
  String category;
  List<dynamic> cities;
  List<dynamic> objectives;
  List<RatingModel>? ratings;
  ProviderModel? provider;

  ServiceModel({
    required this.id,
    this.providerId,
    required this.logo,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.cities,
    required this.objectives,
    this.ratings,
    this.provider,
  });

  ServiceModel copyWith({
    ValueGetter<String?>? id,
    String? providerId,
    String? logo,
    String? title,
    double? price,
    String? description,
    String? category,
    List<dynamic>? cities,
    List<dynamic>? objectives,
    ValueGetter<List<RatingModel>?>? ratings,
    ValueGetter<ProviderModel?>? provider,
  }) {
    return ServiceModel(
      id: id != null ? id() : this.id,
      providerId: providerId ?? this.providerId,
      logo: logo ?? this.logo,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      cities: cities ?? this.cities,
      objectives: objectives ?? this.objectives,
      ratings: ratings != null ? ratings() : this.ratings,
      provider: provider != null ? provider() : this.provider,
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
      'cities': cities,
      'objectives': objectives,
      'ratings': ratings?.map((x) => x?.toMap())?.toList(),
      'provider': provider?.toMap(),
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['_id'],
      // providerId: map['provider_id'] ?? '',
      logo: map['logo'] ?? '',
      title: map['title'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      cities: List<dynamic>.from(map['cities']),
      objectives: List<dynamic>.from(map['objectives']),
      ratings: map['ratings'] != null ? List<RatingModel>.from(map['ratings']?.map((x) => RatingModel.fromMap(x))) : [],
      provider: map['provider'] != null ? ProviderModel.fromMap(map['provider']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) =>
      ServiceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ServiceModel(id: $id, providerId: $providerId, logo: $logo, title: $title, price: $price, description: $description, category: $category, cities: $cities, objectives: $objectives, ratings: $ratings, provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ServiceModel &&
      other.id == id &&
      other.providerId == providerId &&
      other.logo == logo &&
      other.title == title &&
      other.price == price &&
      other.description == description &&
      other.category == category &&
      listEquals(other.cities, cities) &&
      listEquals(other.objectives, objectives) &&
      listEquals(other.ratings, ratings) &&
      other.provider == provider;
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
      cities.hashCode ^
      objectives.hashCode ^
      ratings.hashCode ^
      provider.hashCode;
  }
}
