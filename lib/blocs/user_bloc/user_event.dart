// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent extends Equatable{}
class UserSearchEvent extends UserEvent {
  String username;
  UserSearchEvent(
    this.username,
  );
  @override
  // TODO: implement props
  List<Object?> get props => [username];
}
class SelectUserEvent extends UserEvent{
  String userId;
  String selectedUserId;
  SelectUserEvent(this.userId,this.selectedUserId);
  @override
  // TODO: implement props
  List<Object?> get props => [userId,selectedUserId];
}