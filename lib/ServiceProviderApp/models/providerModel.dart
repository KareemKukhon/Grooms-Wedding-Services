import 'dart:convert';
import 'dart:developer';

import 'package:rafeed_provider/ServiceProviderApp/models/chatModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/galleryModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/notificationModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/orderModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/phoneModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/serviceModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

class ProviderModel {
  String? id;
  String username;
  Phone phone;
  String? order_status;
  String password;
  String gender;
  String role;
  String? key;
  String? logo;
  String? city;
  List<NotificationsModel>? notifications;
  List<Service>? services;
  List<ChatModel>? chats;
  List<Gallery>? gallery;
  List<Order>? orders;
  String email;
  double? latitude;
  double? longitude;
  String? field;
  String? token;
  bool? status;
  ProviderModel(
      {this.id,
      required this.username,
      required this.phone,
      required this.password,
      required this.gender,
      required this.role,
      this.key,
      this.logo,
      this.order_status,
      this.city,
      this.notifications,
      this.services,
      this.chats,
      this.gallery,
      this.orders,
      required this.email,
      this.latitude,
      this.longitude,
      this.field,
      this.token,
      this.status});

  Map<String, dynamic> toMap() {
    return {
      // '_id': id,
      'username': username,
      'phone': phone.toMap(),
      'password': password,
      'gender': gender,
      'role': role,
      'key': key,
      'logo': logo,
      'city': city,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'field': field,
      'token': token,
    };
  }

  Map<String, dynamic> toAMap() {
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
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'field': field,
      'token': token,
    };
  }

  factory ProviderModel.fromMap(Map<String, dynamic> map) {
    log(map['chats'].toString());
    List<NotificationsModel> notifications = [];

    if (map['notifications'] != null) {
      notifications.addAll(
        List<NotificationsModel>.from(
          map['notifications']?.map((x) => NotificationsModel.fromMap(x)),
        ),
      );
    }

    if (map['gnotifications'] != null) {
      notifications.addAll(
        List<NotificationsModel>.from(
          map['gnotifications']?.map((x) => NotificationsModel.fromMap(x)),
        ),
      );
    }
    notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    print(
        '====================================================================');
    return ProviderModel(
      id: map['_id'],
      username: map['username'] ?? '',
      phone: Phone.fromMap(map['phone']),
      password: map['password'] ?? '',
      gender: map['gender'] ?? '',
      status: map['status'] ?? true,
      role: map['role'] ?? '',
      key: map['key'],
      logo: map['logo'],
      city: map['city'],
      order_status: map['order_status'] ?? "ACTIVE",
      notifications: notifications,
      services: map['services'] != null
          ? List<Service>.from(map['services']?.map((x) => Service.fromMap(x)))
          : [],
      chats: map['chats'] != null
          ? List<ChatModel>.from(
              map['chats']?.map((x) => ChatModel.fromMap(x, map['_id'])))
          : [],
      gallery: map['works'] != null
          ? List<Gallery>.from(map['works']?.map((x) => Gallery.fromMap(x)))
          : [],
      orders: ((map['services'] ?? []) as List)
          .expand((element) =>
              List<Order>.from(element['orders']?.map((x) => Order.fromMap(x))))
          .toList(),
      email: map['email'] ?? '',
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
