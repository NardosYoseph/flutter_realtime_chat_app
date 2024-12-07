part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable{}
class FetchChatRoomsEvent extends ChatEvent {
  final String userId;

  FetchChatRoomsEvent(this.userId);
  
  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}
class SelectChatRoomEvent extends ChatEvent {
  final String chatRoomId;

  SelectChatRoomEvent(this.chatRoomId);
  
  @override
  // TODO: implement props
  List<Object?> get props => [chatRoomId];
}
class ChatStartedEvent extends ChatEvent{
  final String chatRoomId;

  ChatStartedEvent(this.chatRoomId);
  @override
  // TODO: implement props
  List<Object?> get props => [chatRoomId];
  
}
class SendMessageEvent extends ChatEvent {
  final String senderId;
  final String message;

  SendMessageEvent(this.senderId, this.message);

  @override
  List<Object?> get props => [senderId, message];
}

class LoadMessagesEvent extends ChatEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
