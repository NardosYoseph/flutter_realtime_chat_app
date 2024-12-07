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
  ChatLoaded(this.messages);
  @override
  // TODO: implement props
  List<Object?> get props => [messages];
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
