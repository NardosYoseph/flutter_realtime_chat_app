import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_time_chat_app/data/models/chatRoom.dart';
import 'package:http/http.dart' as http;
import '../models/message.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

import '../models/user.dart';
import '../repositories/user_repository.dart';
import 'user_provider.dart';
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
      final lastTimestamp = Timestamp.fromDate(lastMessageTimestamp);
      final querySnapshot = await _firestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .startAfter([lastTimestamp])
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
      //  await _refreshAuthToken();
       final messageData = message.toFirestore();
      print("Inside send message provider $messageData");
      await _firestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(messageData);

 DocumentSnapshot userDoc = await _firestore.collection('users').doc(message.receiverId).get();
  String? receiverFcmToken = userDoc['fcmToken'];

 if (userDoc.exists && userDoc.data() != null) {
  //fetch user 
      String? receiverFcmToken = userDoc['fcmToken'];
      String sendername = "";
      try {
    final docSnapshot = await _firestore.collection('users').doc(message.senderId).get();

    if (docSnapshot.exists) {
     sendername= UserModel.fromFirestore(docSnapshot).username;
      print("Sender name: $sendername");
    } else {
      throw Exception('User not found');
    }
  } catch (e) {
    throw Exception('Error fetching user: $e');
  }
      if (receiverFcmToken != null && receiverFcmToken.isNotEmpty) {
        await sendPushNotification(receiverFcmToken, sendername, message.content);
      } else {
        print("Receiver does not have an FCM token");
      }
    } else {
      print("Receiver user document does not exist.");
    }
      print("Send message provider success");
    } catch (e) {
      print("Send message provider error $e");
    // if (e.toString().contains('Invalid_grant') || 
    //     e.toString().contains('token must be a short-lived token')) {
    //   // Force reauthentication
    //   await FirebaseAuth.instance.signOut();
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     // Your auth credential here
    //   );
    //   // Retry once
    //   return sendMessage(chatRoomId, message);
        // }
      throw Exception("Failed to send message: $e");
    }
  }

// Future<void> _refreshAuthToken() async {
//   try {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final tokenResult = await user.getIdTokenResult(true); // Force refresh
//       print("Token refreshed, expires at: ${tokenResult.expirationTime}");
//     }
//   } catch (e) {
//     print("Error refreshing token: $e");
//     rethrow;
//   }
// }
Future<String> getAccessToken() async {
  final jsonString = await rootBundle.loadString('assets/real-time-chat-app-a295b-firebase-adminsdk-dvtwv-d2582051b6.json');
  final jsonKey = jsonDecode(jsonString);
  final accountCredentials = auth.ServiceAccountCredentials.fromJson(jsonKey);
  final client = await auth.clientViaServiceAccount(
    accountCredentials,
    ['https://www.googleapis.com/auth/firebase.messaging'],
  );

  return client.credentials.accessToken.data;
}

Future<void> sendPushNotification(String token, String title, String body) async {
  print("Sending push notification to token: $token");
  print("Title: $title");
  print("Body: $body");
  final String accessToken = await getAccessToken();
  final Uri url = Uri.parse("https://fcm.googleapis.com/v1/projects/real-time-chat-app-a295b/messages:send");

  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
    body: jsonEncode({
      "message": {
        "token": token, 
        "notification": {
          "title": title,
          "body": body,
        },
      },
    }),
  );

  print("Response status: ${response.statusCode}");
  print("Response body: ${response.body}");
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
          DateTime? _parseDate(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) return value.toDate();
      if (value is String) return DateTime.tryParse(value);
      return null;
    }
      return ChatRoom(
        id: chatRoomId,
        participants: List<String>.from(data['participants']),
        createdAt: _parseDate(data['createdAt']),
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
