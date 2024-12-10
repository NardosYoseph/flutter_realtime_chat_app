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
final String currentUserId;
  SelectChatRoomEvent(this.chatRoomId,this.currentUserId);
  
  @override
  // TODO: implement props
  List<Object?> get props => [chatRoomId,currentUserId];
}
class ChatStartedEvent extends ChatEvent{
  final String chatRoomId;

  ChatStartedEvent(this.chatRoomId);
  @override
  // TODO: implement props
  List<Object?> get props => [chatRoomId];
  
}
class MarkAsReadEvent extends ChatEvent{
  final String chatRoomId;
  final String currentUserId;

  MarkAsReadEvent(this.chatRoomId,this.currentUserId);
  @override
  // TODO: implement props
  List<Object?> get props => [chatRoomId,currentUserId];
  
}
class DeleteMessageEvent extends ChatEvent{
  final String? messageId;

  DeleteMessageEvent(this.messageId);
  @override
  // TODO: implement props
  List<Object?> get props => [messageId];
  
}
class SendMessageEvent extends ChatEvent {
  final String senderId;
  final String message;
  SendMessageEvent(this.senderId, this.message);

  @override
  List<Object?> get props => [senderId, message];
}
class SelectChatRoomFromSearchEvent extends ChatEvent {
  final String senderId;
 final String recipientId;
  SelectChatRoomFromSearchEvent(this.senderId,this.recipientId);

  @override
  List<Object?> get props => [senderId, recipientId];
}
class LoadMessagesEvent extends ChatEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
