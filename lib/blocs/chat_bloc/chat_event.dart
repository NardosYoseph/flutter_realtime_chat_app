part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable{}
class ChatStartedEvent extends ChatEvent{
  final String chatRoomId;

  ChatStartedEvent(this.chatRoomId);
  @override
  // TODO: implement props
  List<Object?> get props => [chatRoomId];
  
}
class SendMessageEvent extends ChatEvent {
  final String chatRoomId;
  final String senderId;
  final String message;

  SendMessageEvent(this.chatRoomId, this.senderId, this.message);

  @override
  List<Object?> get props => [chatRoomId, senderId, message];
}

class LoadMessagesEvent extends ChatEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
