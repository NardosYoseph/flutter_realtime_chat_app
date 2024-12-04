import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';

class ChatProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   Future<List<Message>> fetchMessages(String chatRoomId) async {
    print("inside fetch provider");
    try {
      final snapshot = await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp')
          .limit(20)
          .get();
    print("inside fetch provider success");

      return snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
    } catch (e) {
    print("inside fetch provider error $e");

      throw Exception("Failed to fetch messages: $e");
    }
  }
 Future<void> sendMessage(String chatRoomId, String senderId, String messageContent) async {
    try {
    print("inside send provider");

      final message = Message(
        senderId: senderId,
        content: messageContent,
      );

      await _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').add(message.toMap());
    print("inside send provider success");
   
    } catch (e) {
      throw Exception("Failed to send message: $e");
    }
  }

}