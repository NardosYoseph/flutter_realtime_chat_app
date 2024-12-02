// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final Timestamp timestamp;
  final bool isRead;
  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    required this.isRead,
  });
  factory Message.fromFirestore(DocumentSnapshot doc){
    Map<String,dynamic> data=doc.data() as Map<String,dynamic>;
    return Message(id: doc.id, senderId: data['senderId']??'', receiverId: data['receiverId']??'', content: data['content']??'', timestamp: data['timestamp']??'', isRead: data['isRead']);
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
}
