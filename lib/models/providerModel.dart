import 'dart:convert';

import 'package:Rafeed/models/galleryModel.dart';
import 'package:Rafeed/models/notificationModel.dart';
import 'package:Rafeed/models/phoneModel.dart';
import 'package:Rafeed/models/serviceModel.dart';

class ProviderModel {
  String? id;
  String username;
  Phone phone;

  String password;
  String gender;
  String role;
  String? key;
  String? logo;
  String? city;
  List<NotificationsModel>? notifications;
  List<ServiceModel>? services;
  List<Gallery>? works;
  String email;
  double? latitude;
  double? longitude;
  String? field;
  String? token;
  ProviderModel({
    this.id,
    required this.username,
    required this.phone,
    required this.password,
    required this.gender,
    required this.role,
    this.key,
    this.logo,
    this.city,
    this.notifications,
    this.services,
    this.works,
    required this.email,
    this.latitude,
    this.longitude,
    this.field,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'username': username,
      'phone': phone.toMap(),
      'password': password,
      'gender': gender,
      'role': role,
      'key': key,
      'logo': logo,
      'city': city,
      'notifications': notifications?.map((x) => x?.toMap())?.toList(),
      'services': services?.map((x) => x?.toMap())?.toList(),
      'userEmail': email,
      'latitude': latitude,
      'longitude': longitude,
      'field': field,
      'token': token,
    };
  }

  factory ProviderModel.fromMap(Map<String, dynamic> map) {
    return ProviderModel(
      id: map['_id'],
      username: map['username'] ?? '',
      phone: Phone.fromMap(map['phone']),
      password: map['password'] ?? '',
      gender: map['gender'] ?? '',
      role: map['role'] ?? '',
      key: map['key'],
      logo: map['logo']??"public/uploads/defaultImage.jpg",
      city: map['city'],
      notifications: map['notifications'] != null
          ? List<NotificationsModel>.from(
              map['notifications']?.map((x) => NotificationsModel.fromMap(x)))
          : null,
      services: map['services'] != null
          ? List<ServiceModel>.from(
              map['services']?.map((x) => ServiceModel.fromMap(x)))
          : null,
      works: map['works'] != null
          ? List<Gallery>.from(map['works']?.map((x) => Gallery.fromMap(x)))
          : null,
      email: map['userEmail'] ?? '',
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      field: map['field'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProviderModel.fromJson(String source) =>
      ProviderModel.fromMap(json.decode(source));
}
