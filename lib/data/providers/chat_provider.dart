import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/data/models/chatRoom.dart';
import '../models/message.dart';

class ChatProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch messages from a specific chat room
  Future<List<Message>> fetchMessages(String chatRoomId) async {
    print("Inside fetch messages provider");
    try {
      final snapshot = await _firestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp')
          .limit(20)
          .get();

      print("Fetch messages provider success");
      return snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
    } catch (e) {
      print("Fetch messages provider error $e");
      throw Exception("Failed to fetch messages: $e");
    }
  }

  // Send a message to a specific chat room
  Future<void> sendMessage(String chatRoomId, String senderId, String messageContent) async {
    try {
      print("Inside send message provider");

      final message = Message(
        senderId: senderId,
        content: messageContent,
        timestamp: DateTime.now(),
      );

      await _firestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(message.toMap());

      print("Send message provider success");
    } catch (e) {
      print("Send message provider error $e");
      throw Exception("Failed to send message: $e");
    }
  }

  // Fetch all chat rooms for a specific user
  Future<List<ChatRoom>> fetchChatRooms(String userId) async {
    print("Inside fetch chat rooms provider");
    try {
      final snapshot = await _firestore
          .collection('chatRooms')
          .where('participants', arrayContains: userId)
          .get();

      print("Fetch chat rooms provider success $snapshot");
      return snapshot.docs.map((doc) => ChatRoom.fromFirestore(doc)).toList();
    } catch (e) {
      print("Fetch chat rooms provider error $e");
      throw Exception("Failed to fetch chat rooms: $e");
    }
  }
  Future<ChatRoom?> getChatRoomById(String chatRoomId) async {
    final doc = await _firestore.collection('chatRooms').doc(chatRoomId).get();
    if (doc.exists) {
      final data = doc.data()!;
      return ChatRoom(
        id: chatRoomId,
        participants: List<String>.from(data['participants']),
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        lastMessage: null, 
      );
    }
    return null;
  }

  Future<void> createChatRoom(ChatRoom chatRoom) async {
    await _firestore.collection('chatRooms').doc(chatRoom.id).set({
      'participants': chatRoom.participants,
      'createdAt': chatRoom.createdAt,
      'lastMessage': chatRoom.lastMessage, 
    });
  }
  Future<void> updateChatRoom(String chatRoomId,String lastMessage,String lastMessageSender,DateTime lastMessageTimestamp,int? unreadCount
) async {
  final chatRoomRef = await _firestore.collection('chatRooms').doc(chatRoomId);

  await chatRoomRef.update({
    'lastMessage': lastMessage,
    'lastMessageSender': lastMessageSender,
    'lastMessageTimestamp': lastMessageTimestamp,
    'unreadCount': unreadCount,
  });
}
Future<void> markMessageAsRead(String chatRoomId) async {
  await FirebaseFirestore.instance
      .collection('chatRooms')
      .doc(chatRoomId)
      .update({'unreadCount': 0});
}

Stream<List<ChatRoom>> getChatRoomsStream() {
  return FirebaseFirestore.instance.collection('chatRooms').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => ChatRoom.fromFirestore(doc))
            .toList(),
      );
}


}
