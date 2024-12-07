// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String id; // Chat room ID
  String? otherUserName; // Chat room ID
  final List<String> participants; 
  DateTime? createdAt;
  final String? lastMessage; // Last message sent in the chat
  final DateTime? lastMessageTimestamp; // Timestamp of the last message
  final String? lastMessageSender; // Sender ID of the last message

  ChatRoom({
    required this.id,
    this.otherUserName,
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
      otherUserName: data['otherUserName'] as String?,
      participants: List<String>.from(data['participants'] ?? []),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
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
  String getOtherUserId(String currentUserId) {
    return participants.firstWhere((userId) => userId != currentUserId, orElse: () => "Unknown");
  }

  ChatRoom copyWith({
    String? id,
    String? otherUserName,
    List<String>? participants,
    DateTime? createdAt,
    String? lastMessage,
    DateTime? lastMessageTimestamp,
    String? lastMessageSender,
  }) {
    return ChatRoom(
      id: id ?? this.id,
      otherUserName: otherUserName ?? this.otherUserName,
      participants: participants ?? this.participants,
      createdAt: createdAt ?? this.createdAt,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
      lastMessageSender: lastMessageSender ?? this.lastMessageSender,
    );
  }
}