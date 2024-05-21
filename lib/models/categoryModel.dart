import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:Rafeed/models/serviceModel.dart';

class Category {
  final String? id;
  final String? name;
  final String? logo;
  final bool? showOnMain;
  final bool? active;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  List<ServiceModel>? services;
  Category({
    this.id,
    this.name,
    this.logo,
    this.showOnMain,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.services,
  });

  Category copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? name,
    ValueGetter<String?>? logo,
    ValueGetter<bool?>? showOnMain,
    ValueGetter<bool?>? active,
    ValueGetter<DateTime?>? createdAt,
    ValueGetter<DateTime?>? updatedAt,
    ValueGetter<List<ServiceModel>?>? services,
  }) {
    return Category(
      id: id != null ? id() : this.id,
      name: name != null ? name() : this.name,
      logo: logo != null ? logo() : this.logo,
      showOnMain: showOnMain != null ? showOnMain() : this.showOnMain,
      active: active != null ? active() : this.active,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
      updatedAt: updatedAt != null ? updatedAt() : this.updatedAt,
      services: services != null ? services() : this.services,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'logo': logo,
      'showOnMain': showOnMain,
      'active': active,

      'services': services?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['_id'],
      name: map['name'],
      logo: map['logo'],
      showOnMain: map['showOnMain'],
      active: map['active'],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      services: map['services'] != null ? List<ServiceModel>.from(map['services']?.map((x) => ServiceModel.fromMap(x))) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Category(id: $id, name: $name, logo: $logo, showOnMain: $showOnMain, active: $active, createdAt: $createdAt, updatedAt: $updatedAt, services: $services)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Category &&
      other.id == id &&
      other.name == name &&
      other.logo == logo &&
      other.showOnMain == showOnMain &&
      other.active == active &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      listEquals(other.services, services);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      logo.hashCode ^
      showOnMain.hashCode ^
      active.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      services.hashCode;
  }
}
