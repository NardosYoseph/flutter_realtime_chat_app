import 'package:real_time_chat_app/data/models/chatRoom.dart';
import 'package:real_time_chat_app/data/models/message.dart';
import 'package:real_time_chat_app/data/providers/chat_provider.dart';

class ChatRepository {
  ChatProvider _chatProvider;
  ChatRepository({ChatProvider? chatProvider}):_chatProvider=chatProvider?? ChatProvider();

  Stream<List<Message>> fetchMessages(String chatRoomId){
    try{
    return _chatProvider.fetchMessages(chatRoomId);
     
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
   Future<void> deleteMessage(String chatRoomId, String messageId) async{
    try{
    print("inside send repo");

     final response=await _chatProvider.deleteMessage(chatRoomId, messageId);
    }catch(e){
      print("$e");
    }
  }
  // Fetch all chat rooms for a specific user
  Stream<List<ChatRoom>> fetchChatRooms(String userId) {
    print("Inside fetch chat rooms provider");
    try {
return _chatProvider.fetchChatRooms(userId);
      
    } catch (e) {
      print("Fetch chat rooms provider error $e");
      throw Exception("Failed to fetch chat rooms: $e");
    }
  }
  Future<void> updateChatRoom(String chatRoomId, String lastMessage, String lastMessageSender, DateTime lastMessageTimestamp,int? unreadCount) async{
    try{
    print("inside send repo");

     final response=await _chatProvider.updateChatRoom(chatRoomId, lastMessage, lastMessageSender, lastMessageTimestamp,unreadCount);
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
        unreadCount: 0
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
    try {
      ChatRoom? existingChatRoom = await _chatProvider.getChatRoomById(chatRoomId);

       print("already exst chatroom");
        return existingChatRoom;
    
    } catch (e) {
      print("Error in createOrGenerateChatRoom: $e");
      throw Exception("Failed to create or retrieve chat room: $e");
    }
  }

  
   Future<void> markMessageAsRead(String chatRoomId) async{
    try{
      print("inside markasread repo try");

      final response=await _chatProvider.markMessageAsRead(chatRoomId); 
      print("inside markasread repo try success");

    }
    catch(e){
      print("$e");
      throw Exception("Failed to fetch messages: $e");
    }
  }
}