import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/serviceModel.dart';

class Category {
  String? id;
  String name;
  List<Service> services;
  String? logo;
  bool showOnMain;
  bool active;
  Category({
    this.id,
    required this.name,
    required this.services,
    this.logo,
    required this.showOnMain,
    required this.active,
  });


  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'services': services.map((x) => x.toMap()).toList(),
      'logo': logo,
      'showOnMain': showOnMain,
      'active': active,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['_id'],
      name: map['name'] ?? '',
      services:map['services']!=null? List<Service>.from(map['services']?.map((x) => Service.fromMap(x))):[],
      logo: map['logo'],
      showOnMain: map['showOnMain'] ?? false,
      active: map['active'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source));

  @override
  String toString() => 'Category(name: $name, services: $services)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Category &&
      other.name == name &&
      listEquals(other.services, services);
  }

  @override
  int get hashCode => name.hashCode ^ services.hashCode;
}
