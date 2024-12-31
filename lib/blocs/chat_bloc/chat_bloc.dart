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
Future<void> _onSelectChatRoom(SelectChatRoomEvent event, Emitter<ChatState> emit) async {
  emit(ChatLoading());
  try {
    print("Inside fetch bloc to start listening to messages");

    // Fetch chat room details
    final chatRoom = await _chatRepository.getChatRoom(event.chatRoomId);
    print("Chat room inside onSelect bloc ${chatRoom?.participants ?? 'No participants'}");
    print("Chat room last message sender inside onSelect bloc ${chatRoom?.lastMessageSender ?? 'No sender'}");

    // Identify the other user
    final otherUserId = chatRoom!.participants.firstWhere((id) => id != event.currentUserId);
    final otherUser = await _userRepository.fetchUser(otherUserId);

    // Emit initial state with chat room details
    emit(ChatLoaded([], event.chatRoomId, otherUser.username, chatRoom.lastMessageSender));

    // Listen to the message stream
    await for (final messages in _chatRepository.fetchMessages(event.chatRoomId)) {
      print("New messages received: ${messages.length}");
      emit(ChatLoaded(messages, event.chatRoomId, otherUser.username, chatRoom.lastMessageSender));
    }
  } catch (e) {
    print("Error in _onSelectChatRoom: $e");
    emit(ChatError("Can't fetch messages: $e"));
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
    if (event.messageId != null) {
      await _chatRepository.deleteMessage(chatRoomId, event.messageId!);
    } else {
      throw Exception("Message ID cannot be null.");
    }

    // Re-fetch messages to update the UI
    final updatedMessagesStream = _chatRepository.fetchMessages(chatRoomId);

    // Listen for updated messages
    await for (final updatedMessages in updatedMessagesStream) {
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

        // Emit the updated state with the new messages and last message sender
        emit(ChatLoaded(updatedMessages, chatRoomId, chatState.otherUSerName, lastMessage.senderId));
      } else {
        // Handle case where all messages are deleted
        await _chatRepository.updateChatRoom(
          chatRoomId,
          "", // No last message
          "", // No sender
          DateTime.now(),
          0, // Reset unread count
        );

        // Emit state with empty messages list and no last message sender
        emit(ChatLoaded([], chatRoomId, chatState.otherUSerName, ""));
      }
      break; // Exit the loop after the first set of updated messages
    }
  } catch (e) {
    print("Error in delete message bloc: $e");
    emit(ChatError("Failed to delete message: $e"));
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

    // Emit an initial state with no messages
    emit(ChatLoaded([], chatRoomId, otherUser.username, chatRoom.lastMessageSender));

    // Listen to the real-time message stream
    await for (final messages in _chatRepository.fetchMessages(chatRoomId)) {
      print("New messages received for chatRoomId $chatRoomId: ${messages.length}");
      emit(ChatLoaded(messages, chatRoomId, otherUser.username, chatRoom.lastMessageSender));
    }
  } catch (e) {
    print("Error in _onSelectChatRoomFromSearch: $e");
    emit(ChatError("Error loading chat: $e"));
  }
}


Future<void> _onFetchChatRoom(FetchChatRoomsEvent event, Emitter<ChatState> emit) async {
  emit(ChatRoomLoading()); // Start with a loading state
  try {
    await for (final chatRooms in _chatRepository.fetchChatRooms(event.userId)) {
      final updatedChatRooms = await Future.wait(chatRooms.map((chatRoom) async {
        final otherUserId = chatRoom.getOtherUserId(event.userId);
        final otherUser = await _userRepository.fetchUser(otherUserId);
        return chatRoom.copyWith(otherUserName: otherUser.username);
      }));

      emit(ChatRoomsLoaded(updatedChatRooms));
    }
  } catch (error) {
    emit(ChatError("Error fetching chat rooms: $error"));
  }
}

@override
Future<void> close() {
  _chatRoomSubscription?.cancel();
  return super.close();
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
