import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:real_time_chat_app/data/models/message.dart';
import 'package:real_time_chat_app/data/models/user.dart';
import 'package:real_time_chat_app/data/repositories/chat_repository.dart';
import 'package:real_time_chat_app/data/repositories/user_repository.dart';
import '../../data/models/chatRoom.dart';
import '../../data/repositories/presence_repository.dart';
import '../auth_bloc/auth_bloc.dart';
import '../presence/presence_bloc.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends HydratedBloc<ChatEvent, ChatState> {
 
  bool _isFetching=false;
  final ChatRepository _chatRepository;
  final UserRepository _userRepository;
  final PresenceRepository _presenceRepository;
  
   StreamSubscription<List<Message>>? _messageSubscription;
  final _messageController = StreamController<List<Message>>.broadcast();
  Stream<List<Message>> get messageStream => _messageController.stream;
  StreamSubscription<List<ChatRoom>>? _chatRoomSubscription;
final _chatRoomController=StreamController<List<ChatRoom>>.broadcast();
  Stream<List<ChatRoom>> get chatRoomStream => _chatRoomController.stream;
  ChatBloc(this._chatRepository,this._userRepository,this._presenceRepository) : super(ChatInitial()) {
  on<SelectChatRoomEvent>(_onSelectChatRoom);
  on<SendMessageEvent>(_onSendMessage);
  on<FetchChatRoomsEvent>(_onFetchChatRoom);
  on<SelectChatRoomFromSearchEvent>(_onSelectChatRoomFromSearch);
  // on<MarkAsReadEvent>(_onMarkAsRead);
  on<DeleteMessageEvent>(_onDeleteMessage);
  on<FetchMoreMessagesEvent>(_onFetchMoreMessages);
  on<NewMessagesReceived>((event, emit) {
  emit(ChatLoaded(event.messages, event.chatRoomId, event.otherUsername, event.lastMessageSender,hasReachedMax: event.hasReachedMax));
});
on<MessageFetchError>((event, emit) {
  emit(ChatError("Can't fetch messages: ${event.error}"));
});
on<UserTyping>(_mapUserTypingToState);
  }
  
void _mapUserTypingToState(UserTyping event, Emitter<ChatState> emit) {
    if (state is ChatLoaded) {
      final currentState = state as ChatLoaded;
      emit(currentState.copyWith(isCurrentUserTyping: event.isTyping));
      
      _presenceRepository.updateTypingStatus(
        FirebaseAuth.instance.currentUser!.uid,
        event.isTyping,
      );
    }
  }
Future<void> _onFetchMoreMessages(
    FetchMoreMessagesEvent event, Emitter<ChatState> emit) async {
  if (_isFetching) return;
final previousState = state;

  _isFetching = true;
  if (previousState is ChatLoaded) {
    emit(ChatLoadingMore(messages: previousState.messages,hasReachedMax: previousState.hasReachedMax));
  }
  try {
    // Pass the last message timestamp to the repository method
    final olderMessages = await _chatRepository.fetchOlderMessages(
      event.chatRoomId,
      event.lastMessageTimestamp,
    );
  print("old messages fetched successfully inside bloc ${olderMessages.length}");
  final hasReachedMax = olderMessages.length<10;
    final currentState = state;
  print("current state of bloc $currentState");
    if (previousState is ChatLoaded) {
      emit(ChatLoaded(
        [...previousState.messages, ...olderMessages],
        previousState.chatRoomId,
        previousState.otherUSerName,
        previousState.lastMessageSender,
        hasReachedMax: hasReachedMax,
      ));
      print("old messages ${previousState.messages.length} ${previousState.otherUSerName}");
    }
  } catch (e) {
    emit(ChatError("Error fetching older messages: $e"));
  } finally {
    _isFetching = false;
  }
}

  Future<void> _onSelectChatRoom(SelectChatRoomEvent event, Emitter<ChatState> emit) async {
  emit(ChatLoading());
  print("Emitting ChatLoading");
  try {
    print("Inside fetch bloc to start listening to messages");

    // Fetch chat room details
    final chatRoom = await _chatRepository.getChatRoom(event.chatRoomId);
    final otherUserId = chatRoom!.participants.firstWhere((id) => id != event.currentUserId);
    final otherUser = await _userRepository.fetchUser(otherUserId);

    // Emit an intermediate state with chat room details (before messages are fetched)
    emit(ChatLoaded([], event.chatRoomId, otherUser.username, chatRoom.lastMessageSender));

print("Emitting ChatLoaded with initial empty messages");
    // Cancel any existing subscription
    _messageSubscription?.cancel();

    _messageSubscription = _chatRepository.fetchMessages(event.chatRoomId).listen(
      (messages) {
        _messageController.add(messages);
        print("New messages received: ${messages.length}");
        final hasReachedMax = messages.length < 10;
   
    
        add(NewMessagesReceived(messages, event.chatRoomId, otherUser.username, chatRoom.lastMessageSender,hasReachedMax: hasReachedMax));
    // emit(ChatLoaded(messages, event.chatRoomId, otherUser.username, chatRoom.lastMessageSender,hasReachedMax: hasReachedMax));

      },
        onError: (error) {
    print("Error while fetching messages: $error");
    _messageController.addError(error);
        
      },
      
    );
    if(event.currentUserId!=chatRoom.lastMessageSender){
    await _chatRepository.markMessageAsRead(event.chatRoomId, event.currentUserId);
    }
  } catch (e) {
    print("Error in _onSelectChatRoom: $e");
    emit(ChatError("Can't fetch messages: $e"));
  }
}
Future<void> _onFetchChatRoom(FetchChatRoomsEvent event, Emitter<ChatState> emit) async {
  if (state is! ChatRoomsLoaded) {
    emit(ChatRoomLoading());
  }

  try {
    // Cancel any existing subscription to avoid multiple listeners.
    await _chatRoomSubscription?.cancel();

    // Fetch chat rooms and process them.
    _chatRoomSubscription = _chatRepository.fetchChatRooms(event.userId).listen(
      (chatRooms) async {
        // Fetch other user details for each chat room.
        final chatRoomsWithNames = await Future.wait(chatRooms.map((chatRoom) async {
          final otherUserId = chatRoom.getOtherUserId(event.userId);
          final otherUser = await _userRepository.fetchUser(otherUserId);
          return chatRoom.copyWith(otherUserName: otherUser.username,unreadCount: chatRoom.unreadCount);
        }));

        // Add the processed chat rooms to the controller.
        _chatRoomController.add(chatRoomsWithNames);

        // Emit the updated state with chat rooms.
        // emit(ChatRoomsLoaded(chatRoomsWithNames));

        print("New chat rooms received: ${chatRoomsWithNames.length}");
      },
    );
  } catch (error) {
    // Emit an error state if any issues occur.
    emit(ChatError("Error fetching chat rooms: $error"));
  }
}



Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
  try {
    if (state is! ChatLoaded) {
      throw Exception("Chat is not loaded.");
    }

    final chatState = state as ChatLoaded;
    final chatRoomId = chatState.chatRoomId;
print("inside send message bloc");
    // Send the message
    await _chatRepository.sendMessage(
      chatRoomId,
      event.senderId,
      event.receiverId,
      event.message,
    );
 await _chatRepository.updateChatRoom(chatRoomId, {
      'lastMessage': event.message,
      'lastMessageTimestamp': FieldValue.serverTimestamp(),
      'lastMessageSender': event.senderId,
      'unreadCount': FieldValue.increment(1),
    });
    print("Message sent successfully");
// Get chat room participants
    final chatRoom = await _chatRepository.getChatRoom(chatRoomId);
    if (chatRoom == null || chatRoom.participants.isEmpty) {
      print("No participants found in chat room.");
      return;
    }

    // Determine recipient (the other participant)
    String? recipientId;
    for (var participant in chatRoom.participants) {
      if (participant != event.senderId) {
        recipientId = participant;
        break;
      }
    }

    if (recipientId == null) {
      print("Recipient not found.");
      return;
    }

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
  final updatedMessages = await _chatRepository.fetchMessages(chatRoomId).first;
      _messageController.add(updatedMessages);
   
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




 @override
  Future<void> close() {
    _messageSubscription?.cancel();
    _messageController.close();
    _chatRoomSubscription?.cancel();
    return super.close();
  }
  @override
ChatState? fromJson(Map<String, dynamic> json) {
  try {
    if (json.containsKey('chatRooms')) {
      final chatRooms = (json['chatRooms'] as List)
    .map((e) => ChatRoom.fromJson(e))
    .toList();

      return ChatRoomsLoaded(chatRooms);
    } else if (json.containsKey('messages')) {
      final messages = (json['messages'] as List)
          .map((e) => Message.fromJson(e))
          .toList();
      return ChatLoaded(
        messages,
        json['chatRoomId'] ?? '',
        json['otherUsername'] ?? '',
        json['lastMessageSender'] ?? '',
        hasReachedMax: json['hasReachedMax'] ?? false,
      );
    }
  } catch (e) {
    print("Error restoring state: $e");
  }
  return null;
}

@override
Map<String, dynamic>? toJson(ChatState state) {
  if (state is ChatRoomsLoaded) {
    return {'chatRooms': state.chatRooms.map((e) => e.toJson()).toList()};
  } else if (state is ChatLoaded) {
    return {
      'messages': state.messages.map((e) => e.toJson()).toList(),
      'chatRoomId': state.chatRoomId,
      'otherUsername': state.otherUSerName,
      'lastMessageSender': state.lastMessageSender,
      'hasReachedMax': state.hasReachedMax,
    };
  }
  return null;
}

}
