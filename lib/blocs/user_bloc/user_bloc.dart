import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:real_time_chat_app/data/repositories/chat_repository.dart';
import 'package:real_time_chat_app/data/repositories/user_repository.dart';

import '../../data/models/user.dart';
import '../chat_bloc/chat_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  final ChatRepository _chatrRepository;
  UserBloc(this._userRepository,this._chatrRepository) : super(UserInitial()) {
    on<UserSearchEvent>(_onUserSearch);
    on<SelectUserEvent>(_onUserSelect);
  }
  Future<void> _onUserSearch(UserSearchEvent event,Emitter<UserState> emit)async{
    emit(UsersLoading());
    try{
      print("inside bloc try ");
final users=await _userRepository.searchUser(event.username);
      print("inside bloc try success $users");

emit(UsersLoaded(users));
    }catch(e){
emit(UsersError("error fetching user"));
    }
  }

 Future<void> _onUserSelect(SelectUserEvent event, Emitter<UserState> emit) async {
  try {
 emit(SelectedUserLoading());

    final currentUserId = event.userId; // Assume this comes from the event
    final selectedUserId = event.selectedUserId;

    final chatRoomId = (currentUserId.compareTo(selectedUserId) < 0)
        ? "$currentUserId\_$selectedUserId"
        : "$selectedUserId\_$currentUserId";
    UserModel user = await _userRepository.fetchUser(event.selectedUserId);
      print("user fetched $user");

  emit(SelectedUserLoaded(user));
  //   await _userRepository.createOrGetChatRoom(currentUserId, selectedUserId);
  emit(ChatRoomSelected(chatRoomId));
  } catch (e) {
    emit(UsersError("Error selecting chat room"));
  }
 
}

}
