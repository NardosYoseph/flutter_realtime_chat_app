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
      return [];
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
}