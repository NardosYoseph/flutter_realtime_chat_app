import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/data/models/chatRoom.dart';
import '../models/message.dart';

class ChatProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch messages from a specific chat room
  Stream<List<Message>> fetchMessages(String chatRoomId) {
  print("Inside fetch messages provider (real-time)");
  try {
    return _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp')
        .limit(20)
        .snapshots()
        .map((snapshot) {
          print("Fetch messages stream provider success");
          return snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
        });
  } catch (e) {
    print("Fetch messages stream provider error $e");
    throw Exception("Failed to fetch messages: $e");
  }
}

 Future<void> deleteMessage(String chatRoomId, String messageId) async {
    print("Inside delete message provider");
    try {
      await _firestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .doc(messageId)
          .delete();

      print("Delete message provider success");
    } catch (e) {
      print("Delete message provider error $e");
      throw Exception("Failed to delete message: $e");
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
  Stream<List<ChatRoom>> fetchChatRooms(String userId) {
  print("Listening to fetch chat rooms stream");
  return _firestore
      .collection('chatRooms')
      .where('participants', arrayContains: userId)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs
            .map((doc) => ChatRoom.fromFirestore(doc))
            .toList();
      });
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
        lastMessageSender: data['lastMessageSender']
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
      print("inside markasread provider try ");

 final res= await FirebaseFirestore.instance
      .collection('chatRooms')
      .doc(chatRoomId)
      .update({'unreadCount': 0});
      print("inside markasread provider try success");

}

Stream<List<ChatRoom>> getChatRoomsStream() {
  return FirebaseFirestore.instance.collection('chatRooms').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => ChatRoom.fromFirestore(doc))
            .toList(),
      );
}


}
