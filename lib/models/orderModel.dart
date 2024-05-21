import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:Rafeed/models/serviceModel.dart';

class Order {
  String? id;
  String? customerId;
  String? serviceId;
  String createdAt;
  DateTime orderDate;
  String status;
  String? city;
  String? neighborhood;
  String? hall;
  ServiceModel service;
  Order({
    this.id,
    this.customerId,
    this.serviceId,
    required this.createdAt,
    required this.orderDate,
    required this.status,
    this.city,
    this.neighborhood,
    this.hall,
    required this.service,
  });

  Order copyWith({
    ValueGetter<String?>? id,
    String? customerId,
    String? serviceId,
    String? createdAt,
    DateTime? orderDate,
    String? status,
    ValueGetter<String?>? city,
    ValueGetter<String?>? neighborhood,
    ValueGetter<String?>? hall,
    ServiceModel? service,
  }) {
    return Order(
      id: id != null ? id() : this.id,
      customerId: customerId ?? this.customerId,
      serviceId: serviceId ?? this.serviceId,
      createdAt: createdAt ?? this.createdAt,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
      city: city != null ? city() : this.city,
      neighborhood: neighborhood != null ? neighborhood() : this.neighborhood,
      hall: hall != null ? hall() : this.hall,
      service: service ?? this.service,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'serviceId': serviceId,
      'createdAt': createdAt,
      'order_date': orderDate,
      'status': status,
      'city': city,
      'neighborhood': neighborhood,
      'hall': hall,
      'service': service.toMap(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'],
      // customerId: map['customer_id'] ?? '',
      // serviceId: map['service_id'] ?? '',
      createdAt: map['createdAt'] ?? '',
      orderDate: map['orderDate'] != null
          ? DateTime.parse(map['orderDate'])
          : DateTime.now(),

      status: map['status'] ?? '',
      city: map['city'],
      neighborhood: map['neighborhood'],
      hall: map['hall'],
      service: ServiceModel.fromMap(map['service'] ?? map['service_id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, customerId: $customerId, serviceId: $serviceId, createdAt: $createdAt, orderDate: $orderDate, status: $status, city: $city, neighborhood: $neighborhood, hall: $hall, service: $service)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.customerId == customerId &&
        other.serviceId == serviceId &&
        other.createdAt == createdAt &&
        other.orderDate == orderDate &&
        other.status == status &&
        other.city == city &&
        other.neighborhood == neighborhood &&
        other.hall == hall &&
        other.service == service;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerId.hashCode ^
        serviceId.hashCode ^
        createdAt.hashCode ^
        orderDate.hashCode ^
        status.hashCode ^
        city.hashCode ^
        neighborhood.hashCode ^
        hall.hashCode ^
        service.hashCode;
  }
}
