// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'message.freezed.dart';
part 'message.g.dart';
@freezed
class Message with _$Message {
  const Message._();
  const factory Message({
    String? id,
    required String senderId,
    String? receiverId,
    required String content,
    DateTime? timestamp,
    @Default(false) bool isRead,
  }) = _Message;

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      content: data['content'] ?? '',
      timestamp: _parseTimestamp(data['timestamp']),
      isRead: data['isRead'] ?? false,
    );
  }
static DateTime? _parseTimestamp(dynamic timestamp) {
    if (timestamp == null) return null;
    if (timestamp is Timestamp) return timestamp.toDate();
    if (timestamp is DateTime) return timestamp;
    if (timestamp is String) return DateTime.tryParse(timestamp);
    return null;
  }

 Map<String, dynamic> toFirestore() => _MessageToFirestore(this);
   factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

}
Map<String, dynamic> _MessageToFirestore(Message message) {
  return {
    'senderId': message.senderId,
    'receiverId': message.receiverId,
    'content': message.content,
    'timestamp': FieldValue.serverTimestamp(),
    'isRead': message.isRead,
  };
}
