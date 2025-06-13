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
final int? unreadCount;
  ChatRoom({
    required this.id,
    this.otherUserName,
    required this.participants,
    this.createdAt,
    this.lastMessage,
    this.lastMessageTimestamp,
    this.lastMessageSender,
    this.unreadCount=0,
  });

  // Factory constructor to create a ChatRoom from Firestore data
  factory ChatRoom.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatRoom(
      id: doc.id,
      otherUserName: data['otherUserName'] as String?,
      participants: List<String>.from(data['participants'] ?? []),
      createdAt: (data['createdAt'])?.toDate(),
      lastMessage: data['lastMessage'] as String?,
      lastMessageTimestamp: (data['lastMessageTimestamp'] )?.toDate(),
      lastMessageSender: data['lastMessageSender'] as String?,
      unreadCount: data['unreadCount'] as int?,
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
      'unreadCount': unreadCount,
    };
  }
   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'otherUserName': otherUserName,
      'participants': participants,
      'createdAt': createdAt?.toIso8601String(),
      'lastMessage': lastMessage,
      'lastMessageTimestamp': lastMessageTimestamp?.toIso8601String(),
      'lastMessageSender': lastMessageSender,
      'unreadCount': unreadCount,
    };
  }

  // Create ChatRoom from JSON
  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'],
      otherUserName: json['otherUserName'],
      participants: List<String>.from(json['participants'] ?? []),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      lastMessage: json['lastMessage'],
      lastMessageTimestamp: json['lastMessageTimestamp'] != null ? DateTime.parse(json['lastMessageTimestamp']) : null,
      lastMessageSender: json['lastMessageSender'],
      unreadCount: json['unreadCount'],
    );
  }
  String getOtherUserId(String currentUserId) {
    print("participants: $participants");
    String otherUserId=participants.firstWhere((userId) => userId != currentUserId, orElse: () => "Unknown");
  print("otherUserId: $otherUserId");
    if (otherUserId == "Unknown") {
      throw Exception("No other user found in chat room participants.");
    }
    // If the other user ID is not found, return a default value or handle the error as needed
    // For example, you could return an empty string or throw an exception
  return otherUserId;
  }

  ChatRoom copyWith({
    String? id,
    String? otherUserName,
    List<String>? participants,
    DateTime? createdAt,
    String? lastMessage,
    DateTime? lastMessageTimestamp,
    String? lastMessageSender,
    int? unreadCount,
  }) {
    return ChatRoom(
      id: id ?? this.id,
      otherUserName: otherUserName ?? this.otherUserName,
      participants: participants ?? this.participants,
      createdAt: createdAt ?? this.createdAt,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
      lastMessageSender: lastMessageSender ?? this.lastMessageSender,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
