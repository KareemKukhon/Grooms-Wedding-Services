import 'dart:convert';
import 'dart:developer';

import 'package:Rafeed/models/categoryModel.dart';
import 'package:Rafeed/models/chatModel.dart';
import 'package:Rafeed/models/favorateModel.dart';
import 'package:Rafeed/models/notificationModel.dart';
import 'package:Rafeed/models/orderModel.dart';
import 'package:Rafeed/models/phoneModel.dart';
import 'package:Rafeed/models/providerModel.dart';
import 'package:Rafeed/var/var.dart';

class UserModel {
  String? id;
  String username;
  Phone? phone;
  String password;
  DateTime? marriageDate;
  String email;
  String gender;
  String role;
  String? logo;
  String? key;
  List<Order>? orders;
  List<NotificationsModel>? notifications;
  List<ChatModel>? chats;
  List<Category>? categories;
  List<ProviderModel>? provideres;
  List<FavoriteModel>? favorites;
  String? token;
  UserModel({
    this.id,
    required this.username,
    required this.phone,
    required this.password,
    this.marriageDate,
    required this.email,
    required this.gender,
    required this.role,
    required this.logo,
    this.key,
    this.orders,
    this.notifications,
    this.chats,
    this.categories,
    this.provideres,
    this.favorites,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      // '_id': id,
      'username': username,
      'phone': phone?.toMap(),
      'password': password,
      'email': email,
      // 'gender': gender,
      'role': role,
      // 'logo': logo,
      'key': key,
      // 'orders': orders?.map((x) => x?.toMap())?.toList(),
      // 'notifications': notifications?.map((x) => x?.toMap())?.toList(),
      // 'chats': chats?.map((x) => x?.toMap())?.toList(),
      // 'categories': categories?.map((x) => x?.toMap())?.toList(),
      // 'provideres': provideres?.map((x) => x?.toMap())?.toList(),
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
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
    return UserModel(
      id: map['_id'],
      username: map['username'] ?? '',
      phone: map['phone'] != null ? Phone.fromMap(map['phone']) : null,
      password: map['password'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      role: map['role'] ?? '',
      logo: map['logo'] ?? 'public/uploads/defaultImage.jpg',
      key: map['key'],
      orders: map['orders'] != null
          ? List<Order>.from(map['orders']?.map((x) => Order.fromMap(x)))
          : null,
      notifications: notifications,
      chats: map['chats'] != null
          ? List<ChatModel>.from(
              map['chats']?.map((x) => ChatModel.fromMap(x, map['_id'])))
          : null,
      categories: map['categories'] != null
          ? List<Category>.from(
              map['categories']?.map((x) => Category.fromMap(x)))
          : null,
      provideres: map['provideres'] != null
          ? List<ProviderModel>.from(
              map['provideres']?.map((x) => ProviderModel.fromMap(x)))
          : null,
      favorites: map['favorites'] != null
          ? List<FavoriteModel>.from(
              map['favorites']?.map((x) => FavoriteModel.fromMap(x)))
          : [],
      marriageDate: map['marriageDate']!=null ? DateTime.parse(map['marriageDate']) :DateTime.now(),
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, username: $username, phone: $phone, password: $password, gender: $gender, role: $role, logo: $logo, orders: $orders, notifications: $notifications, chats: $chats, token: $token, providers: $provideres)';
  }
}
