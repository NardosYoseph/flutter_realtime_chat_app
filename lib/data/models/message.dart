// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String? id;
  final String senderId;
  final String? receiverId;
  final String content;
  final DateTime? timestamp;
 bool isRead;
  Message({
    this.id,
    required this.senderId,
   this.receiverId,
    required this.content,
    this.timestamp,
    this.isRead=false,
  });
  factory Message.fromFirestore(DocumentSnapshot doc){
    Map<String,dynamic> data=doc.data() as Map<String,dynamic>;
    return Message(id: doc.id, senderId: data['senderId']??'', 
    receiverId: data['receiverId']??'',
    content: data['content']??'',
   timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
    isRead: data['isRead']);
  }
Map<String,dynamic> toFirestore(){
  return {
    'senderId':this.senderId,
    'receiverId':this.receiverId,
    'content':this.content,
    'timestamp':this.timestamp,
    'isRead':this.isRead
  };
}


  Message copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? content,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': isRead,
    };
  }

  // factory Message.fromMap(Map<String, dynamic> map) {
  //   return Message(
  //     id: map['id'] != null ? map['id'] as String : null,
  //     senderId: map['senderId'] as String,
  //     receiverId: map['receiverId'] != null ? map['receiverId'] as String : null,
  //     content: map['content'] as String,
  //     timestamp: Timestamp.fromMap(map['timestamp'] as Map<String,dynamic>),
  //     isRead: map['isRead'] as bool,
  //   );
  // }

}
