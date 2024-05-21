import 'dart:convert';

import 'package:flutter/widgets.dart';

class SettingsModel {
  final String? id; // Use final since "_id" shouldn't change after creation
  final String? facebook;
  final String? instagram;
  final String? twitter;
  final String? google;
  final String? youtube;
  final String? logo;
  final String? cname;
  final String? pname;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  SettingsModel({
    this.id,
    this.facebook,
    this.instagram,
    this.twitter,
    this.google,
    this.youtube,
    this.logo,
    this.cname,
    this.pname,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  SettingsModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? facebook,
    ValueGetter<String?>? instagram,
    ValueGetter<String?>? twitter,
    ValueGetter<String?>? google,
    ValueGetter<String?>? youtube,
    ValueGetter<String?>? logo,
    ValueGetter<String?>? cname,
    ValueGetter<String?>? pname,
    ValueGetter<String?>? description,
    ValueGetter<DateTime?>? createdAt,
    ValueGetter<DateTime?>? updatedAt,
  }) {
    return SettingsModel(
      id: id != null ? id() : this.id,
      facebook: facebook != null ? facebook() : this.facebook,
      instagram: instagram != null ? instagram() : this.instagram,
      twitter: twitter != null ? twitter() : this.twitter,
      google: google != null ? google() : this.google,
      youtube: youtube != null ? youtube() : this.youtube,
      logo: logo != null ? logo() : this.logo,
      cname: cname != null ? cname() : this.cname,
      pname: pname != null ? pname() : this.pname,
      description: description != null ? description() : this.description,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
      updatedAt: updatedAt != null ? updatedAt() : this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'facebook': facebook,
      'instagram': instagram,
      'twitter': twitter,
      'google': google,
      'youtube': youtube,
      'logo': logo,
      'cname': cname,
      'pname': pname,
      'description': description,
      // 'createdAt': createdAt?.millisecondsSinceEpoch,
      // 'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      id: map['_id'],
      facebook: map['facebook'],
      instagram: map['instagram'],
      twitter: map['twitter'],
      google: map['google'],
      youtube: map['youtube'],
      logo: map['logo'],
      cname: map['cname'],
      pname: map['pname'],
      description: map['description'],
      // createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt']) : null,
      // updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsModel.fromJson(String source) => SettingsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Settings(id: $id, facebook: $facebook, instagram: $instagram, twitter: $twitter, google: $google, youtube: $youtube, logo: $logo, cname: $cname, pname: $pname, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SettingsModel &&
      other.id == id &&
      other.facebook == facebook &&
      other.instagram == instagram &&
      other.twitter == twitter &&
      other.google == google &&
      other.youtube == youtube &&
      other.logo == logo &&
      other.cname == cname &&
      other.pname == pname &&
      other.description == description &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      facebook.hashCode ^
      instagram.hashCode ^
      twitter.hashCode ^
      google.hashCode ^
      youtube.hashCode ^
      logo.hashCode ^
      cname.hashCode ^
      pname.hashCode ^
      description.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
