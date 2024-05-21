import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:Rafeed/models/userModel.dart';

class RatingModel {
  final String? id;
  final String? customerId;
  final String? serviceId;
  final String? review;
  final double? value;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserModel? user;
  RatingModel({
    this.id,
    this.customerId,
    this.serviceId,
    this.review,
    this.value,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  RatingModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? customerId,
    ValueGetter<String?>? serviceId,
    ValueGetter<String?>? review,
    ValueGetter<double?>? value,
    ValueGetter<DateTime?>? createdAt,
    ValueGetter<DateTime?>? updatedAt,
    ValueGetter<UserModel?>? user,
  }) {
    return RatingModel(
      id: id != null ? id() : this.id,
      customerId: customerId != null ? customerId() : this.customerId,
      serviceId: serviceId != null ? serviceId() : this.serviceId,
      review: review != null ? review() : this.review,
      value: value != null ? value() : this.value,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
      updatedAt: updatedAt != null ? updatedAt() : this.updatedAt,
      user: user != null ? user() : this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'customerId': customerId,
      'serviceId': serviceId,
      'review': review,
      'value': value,
      'user': user?.toMap(),
    };
  }

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      id: map['_id'],
      customerId: map['customerId'],
      serviceId: map['serviceId'],
      review: map['review'],
      value: map['value']?.toDouble(),
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      user: map['user'] != null ? UserModel.fromMap(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RatingModel.fromJson(String source) =>
      RatingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RatingModel(id: $id, customerId: $customerId, serviceId: $serviceId, review: $review, value: $value, createdAt: $createdAt, updatedAt: $updatedAt, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RatingModel &&
        other.id == id &&
        other.customerId == customerId &&
        other.serviceId == serviceId &&
        other.review == review &&
        other.value == value &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerId.hashCode ^
        serviceId.hashCode ^
        review.hashCode ^
        value.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        user.hashCode;
  }
}
