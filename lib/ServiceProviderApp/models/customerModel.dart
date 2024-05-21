import 'dart:convert';

import 'package:rafeed_provider/ServiceProviderApp/models/phoneModel.dart';

class Customer {
  String id;
  String username;
  Phone phone;
  String password;
  String gender;
  String role;
  String logo;
  Customer({
    required this.id,
    required this.username,
    required this.phone,
    required this.password,
    required this.gender,
    required this.role,
    required this.logo,
  });

  Customer copyWith({
    String? id,
    String? username,
    Phone? phone,
    String? password,
    String? gender,
    String? role,
    String? logo,
  }) {
    return Customer(
      id: id ?? this.id,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      logo: logo ?? this.logo,
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

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['_id'] ?? '',
      username: map['username'] ?? '',
      phone: Phone.fromMap(map['phone']),
      password: '',
      gender: map['gender'] ?? '',
      role: map['role'] ?? '',
      logo: map['logo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(id: $id, username: $username, phone: $phone, password: $password, gender: $gender, role: $role, logo: $logo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Customer &&
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
