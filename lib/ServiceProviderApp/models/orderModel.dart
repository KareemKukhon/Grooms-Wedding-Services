import 'dart:convert';

import 'package:rafeed_provider/ServiceProviderApp/models/customerModel.dart';

class Order {
  String id;
  DateTime? createdAt;
  DateTime? orderDate;
  String status;
  String city;
  String neighborhood;
  String hall;
  Customer customer;
  Order({
    required this.id,
    required this.createdAt,
    required this.orderDate,
    required this.status,
    required this.city,
    required this.neighborhood,
    required this.hall,
    required this.customer,
  });

  Order copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? orderDate,
    String? status,
    String? city,
    String? neighborhood,
    String? hall,
    Customer? customer,
  }) {
    return Order(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
      city: city ?? this.city,
      neighborhood: neighborhood ?? this.neighborhood,
      hall: hall ?? this.hall,
      customer: customer ?? this.customer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      // 'createdAt': createdAt,
      // 'orderDate': orderDate,
      'status': status,
      'city': city,
      'neighborhood': neighborhood,
      'hall': hall,
      'customer': customer.toMap(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      orderDate: map['orderDate'] != null
          ? DateTime.parse(map['orderDate'])
          : DateTime.now(),
      status: map['status'] ?? '',
      city: map['city'] ?? '',
      neighborhood: map['neighborhood'] ?? '',
      hall: map['hall'] ?? '',
      customer: Customer.fromMap(map['customer'] ?? map["customer_id"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, createdAt: $createdAt, orderDate: $orderDate, status: $status, city: $city, neighborhood: $neighborhood, hall: $hall, customer: $customer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.orderDate == orderDate &&
        other.status == status &&
        other.city == city &&
        other.neighborhood == neighborhood &&
        other.hall == hall &&
        other.customer == customer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        orderDate.hashCode ^
        status.hashCode ^
        city.hashCode ^
        neighborhood.hashCode ^
        hall.hashCode ^
        customer.hashCode;
  }
}
