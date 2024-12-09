import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:real_time_chat_app/data/models/message.dart';
import 'package:real_time_chat_app/data/models/user.dart';
import 'package:real_time_chat_app/data/repositories/chat_repository.dart';
import 'package:real_time_chat_app/data/repositories/user_repository.dart';
import '../../data/models/chatRoom.dart';
import '../auth_bloc/auth_bloc.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  final UserRepository _userRepository;
  StreamSubscription<List<Message>>? _messageSubscription;
  StreamSubscription<List<ChatRoom>>? _chatRoomSubscription;
  ChatBloc(this._chatRepository,this._userRepository) : super(ChatInitial()) {
  on<SelectChatRoomEvent>(_onSelectChatRoom);
  on<SendMessageEvent>(_onSendMessage);
  on<FetchChatRoomsEvent>(_onFetchChatRoom);
  on<SelectChatRoomFromSearchEvent>(_onSelectChatRoomFromSearch);
  }

Future<void>  _onSelectChatRoom(SelectChatRoomEvent event,Emitter<ChatState> emit) async{
emit(ChatLoading());
try{
    print("inside fetch bloc to start message");

      // Fetch messages and chatroom details
      final messages = await _chatRepository.fetchMessages(event.chatRoomId);
      final chatRoom = await _chatRepository.getChatRoom(event.chatRoomId);

      // Identify other user
      final otherUserId = chatRoom!.participants.firstWhere((id) => id != event.currentUserId);
      final otherUser = await _userRepository.fetchUser(otherUserId);

      emit(ChatLoaded(messages, event.chatRoomId, otherUser.username));
 
}catch(e)
{
  emit(ChatError("can't fetch messages"));
}
}
 Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
    print("inside send message bloc");
String chatRoomId;
// if (state is ChatLoaded) {
      chatRoomId = (state as ChatLoaded).chatRoomId;
    // } else {
    //   // Generate the chatRoomId dynamically
    //   chatRoomId = (event.senderId.compareTo(event.recipientId) < 0)
    //       ? "${event.senderId}_${event.recipientId}"
    //       : "${event.recipientId}_${event.senderId}";

    // }
      await _chatRepository.sendMessage(
        chatRoomId,
        event.senderId,
        event.message,
      );
      print("successful message sent");

      await _chatRepository.updateChatRoom(chatRoomId, event.message, event.senderId, DateTime.now());

      // Optionally add the message to the current state
      final updatedMessages = List<Message>.from((state as ChatLoaded).messages)
        ..add(Message(senderId: event.senderId, content: event.message));
         final chatRoom = await _chatRepository.getChatRoom(chatRoomId);
      
      final otherUserId = chatRoom!.participants.firstWhere((id) => id != event.senderId);
      final otherUser = await _userRepository.fetchUser(otherUserId);

      emit(ChatLoaded(updatedMessages,chatRoomId,otherUser.username));

  } catch (e) {
    emit(ChatError("Failed to send message: ${e.toString()}"));
  }
  }
Future<void> _onSelectChatRoomFromSearch(SelectChatRoomFromSearchEvent event,Emitter<ChatState> emit)async{
  try{

String chatRoomId = (event.senderId.compareTo(event.recipientId) < 0)
          ? "${event.senderId}_${event.recipientId}"
          : "${event.recipientId}_${event.senderId}";

      // Check or create chat room if it doesn't exist
      final chatRoom = await _chatRepository.getChatRoom(chatRoomId);
      if (chatRoom == null) {
        await _chatRepository.createChatRoom(event.senderId, event.recipientId);
      }
      
      final otherUserId = chatRoom!.participants.firstWhere((id) => id != event.senderId);
      final otherUser = await _userRepository.fetchUser(otherUserId);

       print("inside fetch bloc to start message");

final messages =await _chatRepository
          .fetchMessages(chatRoomId);
        emit(ChatLoaded(messages,chatRoomId,otherUser.username));
  }catch(e){
emit(ChatError("error loading chat"));
  }
}
Future<void> _onFetchChatRoom(FetchChatRoomsEvent event, Emitter<ChatState> emit) async{
  emit(ChatRoomLoading());
  try{
final chatRooms =await _chatRepository.fetchChatRooms(event.userId);
// Attach computed fields to each chat room
     final updatedChatRooms = await Future.wait(chatRooms.map((chatRoom) async {
      final otherUserId = chatRoom.getOtherUserId(event.userId);
      final otherUser = await _userRepository.fetchUser(otherUserId);
      return chatRoom.copyWith(otherUserName: otherUser.username);
    }));
emit(ChatRoomsLoaded(updatedChatRooms));
  }catch(e){
    emit(ChatError("Error fetching chatrooms"));
  }
}
}
