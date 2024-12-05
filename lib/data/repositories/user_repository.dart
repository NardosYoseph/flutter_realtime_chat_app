import 'package:real_time_chat_app/data/models/chatRoom.dart';
import 'package:real_time_chat_app/data/models/message.dart';
import 'package:real_time_chat_app/data/models/user.dart';
import 'package:real_time_chat_app/data/providers/chat_provider.dart';

import '../providers/user_provider.dart';

class UserRepository {
  UserProvider _userProvider;
  ChatProvider _chatProvider;

  UserRepository({UserProvider? userProvider, ChatProvider? chatProvider})
      : _userProvider = userProvider ?? UserProvider(),
        _chatProvider = chatProvider ?? ChatProvider();

  Future<List<User>> searchUser(String query) async {
    try {
      print("inside repo try ");
      final response = await _userProvider.searchUser(query);
      print("inside repo try success $response");
      return response;
    } catch (e) {
      print("$e");
      throw Exception("Failed to fetch users: $e");
    }
  }

  Future<ChatRoom> createOrGetChatRoom(String currentUserId, String otherUserId) async {
    // Generate a consistent chatRoomId using both user IDs
    final chatRoomId = (currentUserId.compareTo(otherUserId) < 0)
        ? "$currentUserId\_$otherUserId"
        : "$otherUserId\_$currentUserId";

    try {
      // Check if the chat room already exists
      ChatRoom? existingChatRoom = await _chatProvider.getChatRoomById(chatRoomId);

      if (existingChatRoom != null) {
        // If the chat room exists, return it
        return existingChatRoom;
      }

      // If the chat room doesn't exist, create it
      final newChatRoom = ChatRoom(
        id: chatRoomId,
        participants: [currentUserId, otherUserId],
        createdAt: DateTime.now(),
        lastMessage: null,
      );

      await _chatProvider.createChatRoom(newChatRoom);

      return newChatRoom;
    } catch (e) {
      print("Error in createOrGenerateChatRoom: $e");
      throw Exception("Failed to create or retrieve chat room: $e");
    }
  }
}
