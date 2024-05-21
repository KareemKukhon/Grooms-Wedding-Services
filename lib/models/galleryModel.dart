import 'dart:convert';

import 'package:Rafeed/models/serviceModel.dart';

class Gallery {
  String id;
  ServiceModel? service;
  String name;
  String type;
  String url;
  DateTime createdAt;
  Gallery({
    required this.id,
    required this.service,
    required this.name,
    required this.type,
    required this.url,
    required this.createdAt,
  });

  Gallery copyWith({
    String? id,
    ServiceModel? service,
    String? name,
    String? type,
    String? url,
    DateTime? createdAt,
  }) {
    return Gallery(
      id: id ?? this.id,
      service: service ?? this.service,
      name: name ?? this.name,
      type: type ?? this.type,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'works': service!.toMap(),
      'name': name,
      'type': type,
      'url': url,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Gallery.fromMap(Map<String, dynamic> map) {
    return Gallery(
      id: map['id'] ?? '',
      service: map['works'] != null? ServiceModel.fromMap(map['works']): null,
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      url: map['url'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Gallery.fromJson(String source) =>
      Gallery.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Gallery(id: $id, service: $service, name: $name, type: $type, url: $url, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Gallery &&
      other.id == id &&
      other.service == service &&
      other.name == name &&
      other.type == type &&
      other.url == url &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      service.hashCode ^
      name.hashCode ^
      type.hashCode ^
      url.hashCode ^
      createdAt.hashCode;
  }
}
