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
  List<UserModel> users;
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
class SelectedUserLoading extends UserState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SelectedUserLoaded extends UserState{
  UserModel user;
  SelectedUserLoaded(this.user);
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
class ChatRoomSelected extends UserState {
  String chatRoomId;

  ChatRoomSelected(this.chatRoomId);
  
  @override
  // TODO: implement props
  List<Object?> get props => [chatRoomId];
}


