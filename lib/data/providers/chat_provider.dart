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
        .orderBy('timestamp',descending: true)
        .limit(10)
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
 Future<List<Message>> fetchOlderMessages(String chatRoomId, DateTime lastMessageTimestamp) async {
    print("Fetching older messages...");
    try {
      final querySnapshot = await _firestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .startAfter([lastMessageTimestamp])
          .limit(10)
          .get();
if (querySnapshot.docs.isEmpty) {
    return []; 
  }
      print("Older messages fetched successfully");
      return querySnapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error fetching older messages: $e");
      throw Exception("Failed to fetch older messages: $e");
    }
  }
 Future<void> deleteMessage(String chatRoomId, String messageId) async {
  print("Inside delete message provider");
  try {
    // Reference to the chat room and messages collection
    final chatRoomRef = _firestore.collection('chatRooms').doc(chatRoomId);
    final messagesRef = chatRoomRef.collection('messages');

    // Delete the message
    await messagesRef.doc(messageId).delete();
    print("Delete message provider success");

    // Fetch the last message after deletion
    final lastMessageSnapshot = await messagesRef
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    // If there are no messages left, set lastMessage fields to null
    if (lastMessageSnapshot.docs.isEmpty) {
      await chatRoomRef.update({
        'lastMessage': null,
        'lastMessageTimestamp': null,
        'lastMessageSender': null,
      });
    } else {
      // Update the chat room with the new last message
      final lastMessage = lastMessageSnapshot.docs.first.data();
      await chatRoomRef.update({
        'lastMessage': lastMessage['content'],
        'lastMessageTimestamp': lastMessage['timestamp'],
        'lastMessageSender': lastMessage['senderId'],
      });
    }
  } catch (e) {
    print("Delete message provider error $e");
    throw Exception("Failed to delete message: $e");
  }
}
  // Send a message to a specific chat room
  Future<void> sendMessage(String chatRoomId, Message message) async {
    try {
      print("Inside send message provider");

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
Future<void> updateChatRoom(String chatRoomId, Map<String, dynamic> updates) async {
  try {
    await _firestore.collection('chatRooms').doc(chatRoomId).update(updates);
  } catch (e) {
    print("Error updating chat room: $e");
    throw Exception("Failed to update chat room: $e");
  }
}


Future<void> markMessagesAsRead(String chatRoomId, String currentUserId) async {
  
  final messagesQuery = _firestore
      .collection('chatRooms')
      .doc(chatRoomId)
      .collection('messages')
      .where('isRead', isEqualTo: false)
      .where('senderId', isEqualTo: currentUserId);

  final messagesSnapshot = await messagesQuery.get();

  final batch = _firestore.batch();

  for (var doc in messagesSnapshot.docs) {
    batch.update(doc.reference, {'isRead': true});
  }

  await batch.commit();

  // Update the unread count in the chat room.
  final unreadCount = 0;
  await updateChatRoom(chatRoomId, {"unreadCount":unreadCount});
}


Stream<List<ChatRoom>> getChatRoomsStream() {
  return FirebaseFirestore.instance.collection('chatRooms').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => ChatRoom.fromFirestore(doc))
            .toList(),
      );
}


}
