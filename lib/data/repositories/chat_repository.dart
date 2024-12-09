import 'package:real_time_chat_app/data/models/chatRoom.dart';
import 'package:real_time_chat_app/data/models/message.dart';
import 'package:real_time_chat_app/data/providers/chat_provider.dart';

class ChatRepository {
  ChatProvider _chatProvider;
  ChatRepository({ChatProvider? chatProvider}):_chatProvider=chatProvider?? ChatProvider();

  Future<List<Message>> fetchMessages(String chatRoomId) async{
    try{
      final response=await _chatProvider.fetchMessages(chatRoomId);
      return response;
    }
    catch(e){
      print("$e");
      throw Exception("Failed to fetch messages: $e");
    }
  }
  Future<void> sendMessage(String chatRoomId, String senderId, String messageContent) async{
    try{
    print("inside send repo");

     final response=await _chatProvider.sendMessage(chatRoomId, senderId, messageContent);
    }catch(e){
      print("$e");
    }
  }
  // Fetch all chat rooms for a specific user
  Future<List<ChatRoom>> fetchChatRooms(String userId) async {
    print("Inside fetch chat rooms provider");
    try {
      final chatRooms= await _chatProvider.fetchChatRooms(userId);

      print("Fetch chat rooms repo success $chatRooms");
      return chatRooms;
    } catch (e) {
      print("Fetch chat rooms provider error $e");
      throw Exception("Failed to fetch chat rooms: $e");
    }
  }
  Future<void> updateChatRoom(String chatRoomId, String lastMessage, String lastMessageSender, DateTime lastMessageTimestamp) async{
    try{
    print("inside send repo");

     final response=await _chatProvider.updateChatRoom(chatRoomId, lastMessage, lastMessageSender, lastMessageTimestamp);
    }catch(e){
      print("$e");
    }
  }
  Future<ChatRoom> createChatRoom(String currentUserId, String otherUserId) async {
    // Generate a consistent chatRoomId using both user IDs
    final chatRoomId = (currentUserId.compareTo(otherUserId) < 0)
        ? "$currentUserId\_$otherUserId"
        : "$otherUserId\_$currentUserId";

    try {
     
      final newChatRoom = ChatRoom(
        id: chatRoomId,
        participants: [currentUserId, otherUserId],
        createdAt: DateTime.now(),
        lastMessage: null,
      );

      await _chatProvider.createChatRoom(newChatRoom);
       print("creaed chatroom");

      return newChatRoom;
    } catch (e) {
      print("Error in createOrGenerateChatRoom: $e");
      throw Exception("Failed to create or retrieve chat room: $e");
    }
  }

  Future<ChatRoom?> getChatRoom(String chatRoomId) async {
    // Generate a consistent chatRoomId using both user IDs
    // final chatRoomId = (currentUserId.compareTo(otherUserId) < 0)
    //     ? "$currentUserId\_$otherUserId"
    //     : "$otherUserId\_$currentUserId";

    try {
      // Check if the chat room already exists
      ChatRoom? existingChatRoom = await _chatProvider.getChatRoomById(chatRoomId);

       print("already exst chatroom");
        return existingChatRoom;
    
    } catch (e) {
      print("Error in createOrGenerateChatRoom: $e");
      throw Exception("Failed to create or retrieve chat room: $e");
    }
  }
  //  Future<ChatRoom?> getChatRoom(String currentUserId, String otherUserId) async {
  //   // Generate a consistent chatRoomId using both user IDs
  //   final chatRoomId = (currentUserId.compareTo(otherUserId) < 0)
  //       ? "$currentUserId\_$otherUserId"
  //       : "$otherUserId\_$currentUserId";

  //   try {
  //     // Check if the chat room already exists
  //     ChatRoom? existingChatRoom = await _chatProvider.getChatRoomById(chatRoomId);

  //      print("already exst chatroom");
  //       return existingChatRoom;
    
  //   } catch (e) {
  //     print("Error in createOrGenerateChatRoom: $e");
  //     throw Exception("Failed to create or retrieve chat room: $e");
  //   }
  // }
  
}