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
  on<MarkAsReadEvent>(_onMarkAsRead);
  on<DeleteMessageEvent>(_onDeleteMessage);
  }
Future<void>  _onSelectChatRoom(SelectChatRoomEvent event,Emitter<ChatState> emit) async{
emit(ChatLoading());
try{
    print("inside fetch bloc to start message");

      // Fetch messages and chatroom details
      final messages = await _chatRepository.fetchMessages(event.chatRoomId);
      final chatRoom = await _chatRepository.getChatRoom(event.chatRoomId);
print("chat room inside onselect bloc ${chatRoom?.participants ?? 'No partic'}");
print("chat room last message sender inside onselect bloc ${chatRoom?.lastMessageSender ?? 'No sender'}");

      // Identify other user
      final otherUserId = chatRoom!.participants.firstWhere((id) => id != event.currentUserId);
      final otherUser = await _userRepository.fetchUser(otherUserId);

      emit(ChatLoaded(messages, event.chatRoomId, otherUser.username, chatRoom.lastMessageSender));

 
}catch(e)
{
  emit(ChatError("can't fetch messages"));
}
}

Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
  try {
    print("Inside send message bloc");

    if (state is! ChatLoaded) {
      throw Exception("Chat is not loaded.");
    }

    final chatState = state as ChatLoaded;
    final chatRoomId = chatState.chatRoomId;

    // Send the message
    await _chatRepository.sendMessage(
      chatRoomId,
      event.senderId,
      event.message,
    );
    print("Message sent successfully");

    // Add the message to the current state
    final updatedMessages = List<Message>.from(chatState.messages)
      ..add(Message(senderId: event.senderId, content: event.message));

    // Fetch the chat room and handle potential null values
    final chatRoom = await _chatRepository.getChatRoom(chatRoomId);
    if (chatRoom == null) {
      throw Exception("Chat room not found.");
    }

    final unreadCount = chatRoom.unreadCount ?? 0;

    // Update the chat room with the new message
    await _chatRepository.updateChatRoom(
      chatRoomId,
      event.message,
      event.senderId,
      DateTime.now(),
      unreadCount + 1,
    );

    // Fetch the other user and handle potential null values
    final otherUserId = chatRoom.participants.firstWhere(
      (id) => id != event.senderId,
      orElse: () => throw Exception("Other user not found in participants."),
    );
    final otherUser = await _userRepository.fetchUser(otherUserId);
    if (otherUser == null || otherUser.username == null) {
      throw Exception("Other user or username is null.");
    }

    // Emit updated state
    emit(ChatLoaded(updatedMessages, chatRoomId, otherUser.username,event.senderId));
  } catch (e) {
    print("Error in send message: $e");
    emit(ChatError("Failed to send message: ${e.toString()}"));
  }
}
Future<void> _onDeleteMessage(DeleteMessageEvent event, Emitter<ChatState> emit) async {
  try {
    print("Inside delete message bloc");

    if (state is! ChatLoaded) {
      throw Exception("Chat is not loaded.");
    }

    final chatState = state as ChatLoaded;
    final chatRoomId = chatState.chatRoomId;

    // Delete the message
    await _chatRepository.deleteMessage(chatRoomId, event.messageId!);

    // Re-fetch messages to update the UI
    final updatedMessages = await _chatRepository.fetchMessages(chatRoomId);

    // Check if the deleted message was the last message in the chat room
    if (updatedMessages.isNotEmpty) {
      final lastMessage = updatedMessages.last;

      // Update the chat room's last message
      await _chatRepository.updateChatRoom(
        chatRoomId,
        lastMessage.content,
        lastMessage.senderId,
        lastMessage.timestamp ?? DateTime.now(),
        0, // Reset unread count or handle appropriately
      );

      // Pass the lastMessage.senderId as the lastMessageSender to the state
      emit(ChatLoaded(updatedMessages, chatRoomId, chatState.otherUSerName, lastMessage.senderId));
    } else {
      // Handle case where all messages are deleted (e.g., empty the last message)
      await _chatRepository.updateChatRoom(
        chatRoomId,
        "", // No last message
        "", // No sender
        DateTime.now(),
        0, // Reset unread count
      );

      // If no messages are left, pass an empty string or handle accordingly
      emit(ChatLoaded(updatedMessages, chatRoomId, chatState.otherUSerName, ""));
    }

    print("Message deleted successfully");
  } catch (e) {
    print("Error deleting message: $e");
    emit(ChatError("Failed to delete message"));
  }
}

Future<void> _onSelectChatRoomFromSearch(SelectChatRoomFromSearchEvent event, Emitter<ChatState> emit) async {
  try {
    String chatRoomId = (event.senderId.compareTo(event.recipientId) < 0)
        ? "${event.senderId}_${event.recipientId}"
        : "${event.recipientId}_${event.senderId}";

    // Check if the chat room exists
    var chatRoom = await _chatRepository.getChatRoom(chatRoomId);
    if (chatRoom == null) {
      // Create the chat room if it doesn't exist
      await _chatRepository.createChatRoom(event.senderId, event.recipientId);
      chatRoom = await _chatRepository.getChatRoom(chatRoomId);
    }

    if (chatRoom == null) {
      emit(ChatError("Failed to create or fetch chat room"));
      return;
    }

    // Fetch the other user's details
    final otherUserId = chatRoom.participants.firstWhere((id) => id != event.senderId);
    final otherUser = await _userRepository.fetchUser(otherUserId);

    // Fetch messages for the chat room
    final messages = await _chatRepository.fetchMessages(chatRoomId);

    // Emit the loaded state
    emit(ChatLoaded(messages, chatRoomId, otherUser.username,chatRoom.lastMessageSender));
  } catch (e) {
    print("Error: $e");
    emit(ChatError("Error loading chat"));
  }
}

Future<void> _onFetchChatRoom(FetchChatRoomsEvent event, Emitter<ChatState> emit) async{
  emit(ChatRoomLoading());
  try{
_chatRoomSubscription =_chatRepository.fetchChatRooms(event.userId).listen((chatRooms) async{
 final updatedChatRooms = await Future.wait(chatRooms.map((chatRoom) async {
      final otherUserId = chatRoom.getOtherUserId(event.userId);
      final otherUser = await _userRepository.fetchUser(otherUserId);
      return chatRoom.copyWith(otherUserName: otherUser.username);
    }));
emit(ChatRoomsLoaded(updatedChatRooms));

},
      onError: (error) {
        emit(ChatError("Error fetching chat rooms: $error"));
      },
);
    
  }catch(e){
    emit(ChatError("Error fetching chatrooms"));
  }
}
Future<void> _onMarkAsRead(MarkAsReadEvent event, Emitter<ChatState> emit) async {
  try {
    final chatRoom = await _chatRepository.getChatRoom(event.chatRoomId);
      print("markasread get chat room $chatRoom");

    if (chatRoom == null) {
      throw Exception("Chat room not found.");
    }
          print("sender of the last message ${chatRoom.lastMessageSender}");
          print("current user ${event.currentUserId}");

   
          print("current user is NOT the sender of the last message");
      await _chatRepository.markMessageAsRead(event.chatRoomId);
print("mark as read success");
      // Optionally re-fetch the chat room for updated data
      final updatedChatRoom = await _chatRepository.getChatRoom(event.chatRoomId);

      // emit(ChatUpdatedState(updatedChatRoom)); // Update the UI
    
  } catch (e) {
    print("Error in mark as read: $e");
    emit(ChatError(e.toString())); // Handle errors gracefully
  }
}

}
