import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:Rafeed/models/serviceModel.dart';

class FavoriteModel {
  String? id;
  ServiceModel? service;
  FavoriteModel({
    this.id,
    this.service,
  });

  FavoriteModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<ServiceModel?>? service,
  }) {
    return FavoriteModel(
      id: id != null ? id() : this.id,
      service: service != null ? service() : this.service,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'service': service?.toMap(),
    };
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['_id'],
      service: map['service'] != null ? ServiceModel.fromMap(map['service']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteModel.fromJson(String source) => FavoriteModel.fromMap(json.decode(source));

  @override
  String toString() => 'FavoriteModel(id: $id, service: $service)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is FavoriteModel &&
      other.id == id &&
      other.service == service;
  }

  @override
  int get hashCode => id.hashCode ^ service.hashCode;
}
