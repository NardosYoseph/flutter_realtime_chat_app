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

class ChatLoaded extends ChatState{
  List<Message> messages;
  String chatRoomId;
  String otherUSerName;
  String? lastMessageSender;
  ChatLoaded(this.messages,this.chatRoomId,this.otherUSerName,this.lastMessageSender);
  @override
  // TODO: implement props
  List<Object?> get props => [messages,chatRoomId,otherUSerName,this.lastMessageSender];
}
class ChatUpdatedState extends ChatState{
  ChatRoom? chatRoom;
  ChatUpdatedState(this.chatRoom);
  @override
  // TODO: implement props
  List<Object?> get props => [chatRoom];
}
class ChatError extends ChatState{
  String errorMessage;
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
  
  @override
  // TODO: implement props
  List<Object?> get props => [chatRooms];
}

class ChatRoomError extends ChatState{
  String errorMessage;
  ChatRoomError(this.errorMessage);
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
