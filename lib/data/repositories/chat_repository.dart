import 'package:real_time_chat_app/data/models/chatRoom.dart';
import 'package:real_time_chat_app/data/models/message.dart';
import 'package:real_time_chat_app/data/providers/chat_provider.dart';

class ChatRepository {
  ChatProvider _chatProvider;
  ChatRepository({ChatProvider? chatProvider}):_chatProvider=chatProvider?? ChatProvider();

  Stream<List<Message>> fetchMessages(String chatRoomId) async*{
    try{
      final response=await _chatProvider.fetchMessages(chatRoomId);
      yield response;
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
}