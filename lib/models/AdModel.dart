import 'dart:convert';

import 'package:Rafeed/models/categoryModel.dart';


class Ad {
  String? id;
  String? message;
  String? logo;
  DateTime? startDate;
  DateTime? endDate;
  Category? category;
  Ad({
    this.id,
    this.message,
    this.logo,
    this.startDate,
    this.endDate,
    this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'message': message,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'category': category?.toMap(),
    };
  }

  factory Ad.fromMap(Map<String, dynamic> map) {
    return Ad(
      id: map['_id'],
      logo: map['logo'],
      message: map['message'],
      startDate: map['startDate'] != null
          ? DateTime.parse(map['startDate'])
          : DateTime.now(),
      endDate: map['endDate'] != null
          ? DateTime.parse(map['endDate'])
          : DateTime.now(),
      category:
          map['category'] != null ? Category.fromMap(map['category']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ad.fromJson(String source) => Ad.fromMap(json.decode(source));
}
