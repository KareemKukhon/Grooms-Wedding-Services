import 'dart:convert';

class Message {
  final String id; // Message document ID
  final String receiverId; // ID of the intended recipient
  final String type; // Message type (e.g., "IMAGE", "TEXT")
  final DateTime createdAt;
  final String message; // Content of the message
  bool isSeen;
  bool isSender;
  Message({
    required this.id,
    required this.receiverId,
    required this.type,
    required this.createdAt,
    required this.message,
    required this.isSeen,
    this.isSender  = false,
  });

  Message copyWith({
    String? id,
    String? receiverId,
    String? type,
    DateTime? createdAt,
    String? message,
    bool? isSeen,
    int? v,
  }) {
    return Message(
      id: id ?? this.id,
      receiverId: receiverId ?? this.receiverId,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
      isSeen: isSeen ?? this.isSeen,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'receiverId': receiverId,
      'type': type,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'message': message,
      'is_seen': isSeen,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map, String id) {
    return Message(
      id: map['id'] ?? '',
      receiverId: map['receiver_id'] ?? '',
      type: map['type'] ?? '',
      createdAt:map['createdAt']!=null? DateTime.parse(map['createdAt']):DateTime.now(),
      message: map['message'] ?? '',
      isSeen: map['is_seen'] ?? false,
      isSender: map['receiver_id'] != id,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Message.fromJson(String source) =>
  //     Message.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Message(id: $id, receiverId: $receiverId, type: $type, createdAt: $createdAt, message: $message, isSeen: $isSeen)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.id == id &&
        other.receiverId == receiverId &&
        other.type == type &&
        other.createdAt == createdAt &&
        other.message == message &&
        other.isSeen == isSeen;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        receiverId.hashCode ^
        type.hashCode ^
        createdAt.hashCode ^
        message.hashCode ^
        isSeen.hashCode;
  }
}