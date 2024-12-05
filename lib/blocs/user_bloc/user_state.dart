part of 'user_bloc.dart';

abstract class UserState extends Equatable{}
class UserInitial extends UserState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class UsersLoading extends UserState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
  
}
class UsersLoaded extends UserState{
  List<User> users;
  UsersLoaded(this.users);
  @override
  // TODO: implement props
  List<Object?> get props => [users];
}
class UsersError extends UserState{
String message;
  UsersError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class ChatRoomCreated extends UserState {
  String chatRoomId;

  ChatRoomCreated(this.chatRoomId);
  
  @override
  // TODO: implement props
  List<Object?> get props => [chatRoomId];
}


