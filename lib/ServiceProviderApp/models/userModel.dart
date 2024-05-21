import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:rafeed_provider/ServiceProviderApp/models/phoneModel.dart';

class User {
  String? id;
  String username;
  Phone phone;
  String password;
  String gender;
  String role;
  String? logo;
  bool? status;
  User({
    this.id,
    required this.username,
    required this.phone,
    required this.password,
    required this.gender,
    required this.role,
    this.logo,
    this.status
  });


  User copyWith({
    ValueGetter<String?>? id,
    String? username,
    Phone? phone,
    String? password,
    String? gender,
    String? role,
    ValueGetter<String?>? logo,
  }) {
    return User(
      id: id != null ? id() : this.id,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      logo: logo != null ? logo() : this.logo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'username': username,
      'phone': phone.toMap(),
      'password': password,
      'gender': gender,
      'role': role,
      'logo': logo,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'],
      username: map['username'] ?? '',
      phone: Phone.fromMap(map['phone']),
      password: map['password'] ?? '',
      gender: map['gender'] ?? '',
      role: map['role'] ?? '',
      logo: map['logo'] ?? 'public/uploads/defaultImage.jpg',
      status: map['status']??true
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, username: $username, phone: $phone, password: $password, gender: $gender, role: $role, logo: $logo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.id == id &&
      other.username == username &&
      other.phone == phone &&
      other.password == password &&
      other.gender == gender &&
      other.role == role &&
      other.logo == logo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      username.hashCode ^
      phone.hashCode ^
      password.hashCode ^
      gender.hashCode ^
      role.hashCode ^
      logo.hashCode;
  }
}
