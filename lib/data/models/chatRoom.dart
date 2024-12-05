import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String id; // Chat room ID
  final List<String> participants; 
  DateTime? createdAt;
  final String? lastMessage; // Last message sent in the chat
  final DateTime? lastMessageTimestamp; // Timestamp of the last message
  final String? lastMessageSender; // Sender ID of the last message

  ChatRoom({
    required this.id,
    required this.participants,
    this.createdAt,
    this.lastMessage,
    this.lastMessageTimestamp,
    this.lastMessageSender,
  });

  // Factory constructor to create a ChatRoom from Firestore data
  factory ChatRoom.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatRoom(
      id: doc.id,
      participants: List<String>.from(data['participants'] ?? []),
      createdAt: data['createdAt'] as DateTime,
      lastMessage: data['lastMessage'] as String?,
      lastMessageTimestamp: (data['lastMessageTimestamp'] as Timestamp?)?.toDate(),
      lastMessageSender: data['lastMessageSender'] as String?,
    );
  }

  // Convert ChatRoom to a Firestore-friendly map
  Map<String, dynamic> toMap() {
    return {
      'participants': participants,
      'lastMessage': lastMessage,
      'createdAt':createdAt,
      'lastMessageTimestamp': lastMessageTimestamp,
      'lastMessageSender': lastMessageSender,
    };
  }
}
