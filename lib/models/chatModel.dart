import 'dart:convert';
import 'dart:developer';

import 'package:Rafeed/models/messageModel.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:flutter/foundation.dart';


class ChatModel {
  final String id; // Chat document ID
  final List<UserModel> users; // List of users participating in the chat
  final List<Message> messages; // List of messages within the chat
  final DateTime createdAt; // Chat creation timestamp
  final DateTime lastUpdated;
  final UserModel user;
  ChatModel({
    required this.id,
    required this.users,
    required this.messages,
    required this.createdAt,
    required this.lastUpdated,
    required this.user
  });

  

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'users': users.map((x) => x.toMap()).toList(),
      'messages': messages.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.toString(),
      'lastUpdated': lastUpdated.toString(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map, String id) {
    return ChatModel(
      id: map['_id'] ?? '',
      users: map['users'] != null
          ? List<UserModel>.from(map['users']!.map((x) => UserModel.fromMap(x)))
          : [],
      messages: List<Message>.from(
          map['messages']?.map((x) => Message.fromMap(x, id))),
      createdAt:map['createdAt']!=null? DateTime.parse(map['createdAt']):DateTime.now(),
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.parse(map['lastUpdated'])
          : DateTime.now(),
          user: UserModel.fromMap(map["users"][0]["_id"]==id?map["users"][1]:map["users"][0]),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Chat(id: $id, users: $users, messages: $messages, createdAt: $createdAt, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.id == id &&
        listEquals(other.users, users) &&
        listEquals(other.messages, messages) &&
        other.createdAt == createdAt &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        users.hashCode ^
        messages.hashCode ^
        createdAt.hashCode ^
        lastUpdated.hashCode;
  }
}