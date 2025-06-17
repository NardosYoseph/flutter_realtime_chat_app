// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

abstract class ChatState extends Equatable{}

class ChatInitial extends ChatState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
  
}
class ChatLoading extends ChatState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChatLoaded extends ChatState {
  final List<Message> messages;
  final String chatRoomId;
  final String otherUSerName;
  final String? lastMessageSender;
  final bool hasReachedMax;
  final bool isCurrentUserTyping; // Added new field for typing indicator

  ChatLoaded(
   this.messages,
   this.chatRoomId,
   this.otherUSerName,
    this.lastMessageSender,
    {this.hasReachedMax = false,
    this.isCurrentUserTyping = false, }
  );

  @override
  List<Object?> get props => [
        messages, 
        chatRoomId, 
        otherUSerName, 
        lastMessageSender, 
        hasReachedMax,
        isCurrentUserTyping,
      ];

  ChatLoaded copyWith({
    List<Message>? messages,
    String? chatRoomId,
    String? otherUSerName,
    String? lastMessageSender,
    bool? hasReachedMax,
    bool? isCurrentUserTyping,
  }) {
    return ChatLoaded(
      messages ?? this.messages,
      chatRoomId ?? this.chatRoomId,
      otherUSerName ?? this.otherUSerName,
      lastMessageSender ?? this.lastMessageSender,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isCurrentUserTyping: isCurrentUserTyping ?? this.isCurrentUserTyping,
    );
  }
}
class ChatUpdatedState extends ChatState{
 final ChatRoom? chatRoom;
  ChatUpdatedState(this.chatRoom);
  @override
  // TODO: implement props
  List<Object?> get props => [chatRoom];
}
class ChatError extends ChatState{
 final String errorMessage;
  ChatError(this.errorMessage);
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
class ChatRoomLoading extends ChatState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ChatRoomsLoaded extends ChatState {
  final List<ChatRoom> chatRooms;

  ChatRoomsLoaded(this.chatRooms);
  List<Object?> get props => [chatRooms];

  Map<String, dynamic> toJson() => {
    'chatRooms': chatRooms.map((c) => c.toJson()).toList(),
  };
    static ChatRoomsLoaded fromJson(Map<String, dynamic> json) {
    final chatRooms = (json['chatRooms'] as List<dynamic>)
        .map((e) => ChatRoom.fromJson(e as Map<String, dynamic>))
        .toList();
    return ChatRoomsLoaded(chatRooms);
  }}

class ChatRoomError extends ChatState{
 final String errorMessage;
  ChatRoomError(this.errorMessage);
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
class ChatLoadingMore extends ChatState {
  final List<Message> messages;
  final bool hasReachedMax; // Add this flag

  ChatLoadingMore({required this.messages, this.hasReachedMax = false});

  @override
  List<Object?> get props => [messages, hasReachedMax];
}
