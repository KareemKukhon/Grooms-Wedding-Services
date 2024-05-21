import 'dart:convert';

class NotificationsModel {
  String? id;
  String userId;
  String message;
  String type;
  DateTime createdAt;
  bool isOpen;
  NotificationsModel({
    this.id,
    required this.userId,
    required this.message,
    required this.type,
    required this.createdAt,
    required this.isOpen,
  });

  NotificationsModel copyWith({
    String? id,
    String? userId,
    String? message,
    String? type,
    DateTime? createdAt,
    bool? isOpen,
  }) {
    return NotificationsModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isOpen: isOpen ?? this.isOpen,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'message': message,
      'type': type,
      'createdAt': createdAt.toString(),
      'is_open': isOpen,
    };
  }

  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    List<String> notTypes = ["CUSTOMER", "PROVIDER", "ALL"];
    return NotificationsModel(
      id: map['_id'] ?? '',
      userId: map['userId'] ?? '',
      message: map['message'] ?? '',
      type: (notTypes.contains((map['type'] ?? ''))
          ? "GNOT"
          : (map['type'] ?? '')),
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      isOpen: notTypes.contains((map['type'] ?? ''))
          ? true
          : map['is_open'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationsModel.fromJson(String source) =>
      NotificationsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notification(id: $id, userId: $userId, message: $message, type: $type, createdAt: $createdAt, isOpen: $isOpen)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationsModel &&
        other.id == id &&
        other.userId == userId &&
        other.message == message &&
        other.type == type &&
        other.createdAt == createdAt &&
        other.isOpen == isOpen;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        message.hashCode ^
        type.hashCode ^
        createdAt.hashCode ^
        isOpen.hashCode;
  }
}
