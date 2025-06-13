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
  final String receiverId;
  final String message;
  final DateTime timestamp;
  SendMessageEvent(this.senderId,this.receiverId, this.message,this.timestamp);

  @override
  List<Object?> get props => [senderId,receiverId, message];
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
class NewMessagesReceived extends ChatEvent {
  final List<Message> messages;
  final String chatRoomId;
  final String otherUsername;
  final String? lastMessageSender;
bool hasReachedMax;
  NewMessagesReceived(this.messages, this.chatRoomId, this.otherUsername, this.lastMessageSender,{this.hasReachedMax=false});
  
  @override
  // TODO: implement props
  List<Object?> get props => [messages,chatRoomId,otherUsername,lastMessageSender,hasReachedMax];
}
class MessageFetchError extends ChatEvent {
  final String error;

  MessageFetchError(this.error);
  
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
class FetchMoreMessagesEvent extends ChatEvent {
  final String chatRoomId;
  final DateTime lastMessageTimestamp;

  FetchMoreMessagesEvent(this.chatRoomId, this.lastMessageTimestamp);
  
  @override
  // TODO: implement props
  List<Object?> get props => [chatRoomId,lastMessageTimestamp];
}


// class ChatLoadingMore extends ChatState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }



