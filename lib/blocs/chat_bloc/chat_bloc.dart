import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:real_time_chat_app/data/models/message.dart';
import 'package:real_time_chat_app/data/repositories/chat_repository.dart';

import '../../data/models/chatRoom.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  StreamSubscription<List<Message>>? _messageSubscription;
  StreamSubscription<List<ChatRoom>>? _chatRoomSubscription;
  ChatBloc(this._chatRepository) : super(ChatInitial()) {
  on<SelectChatRoomEvent>(_onSelectChatRoom);
  on<SendMessageEvent>(_onSendMessage);
  on<FetchChatRoomsEvent>(_onFetchChatRoom);
  }

Future<void>  _onSelectChatRoom(SelectChatRoomEvent event,Emitter<ChatState> emit) async{
emit(ChatLoading());
try{
    print("inside fetch bloc to start message");
await _messageSubscription?.cancel();
_messageSubscription = _chatRepository
          .fetchMessages(event.chatRoomId)
          .listen((messages) {
            if(emit.isDone){
        emit(ChatLoaded(messages));}
      },
      onError: (error){
        if(!emit.isDone){
           emit(ChatRoomError("Error fetching messages: $error"));
        }
      });
}catch(e)
{
  emit(ChatError("can't fetch messages"));
}
}
 Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
    print("inside send message bloc");

      await _chatRepository.sendMessage(
        event. chatRoomId,
        event.senderId,
        event.message,
      );
    print("successful message sent");
    if(state is ChatLoaded){
      final currentState = state as ChatLoaded;
      List<Message> updatedMessages=List<Message>.from(currentState.messages)..add(Message(senderId: event.senderId, content: event.message));
      emit(ChatLoaded(updatedMessages));
    }
    } catch (e) {
      emit(ChatError("Failed to send message"));
    }
  }

Future<void> _onFetchChatRoom(FetchChatRoomsEvent event, Emitter<ChatState> emit) async{
  emit(ChatRoomLoading());
  try{
//    await _chatRoomSubscription?.cancel();
// _chatRoomSubscription= await _chatRepository.fetchChatRooms(event.userId).listen((chatRooms){
//   if (!emit.isDone) {
//           emit(ChatRoomsLoaded(chatRooms));
//         }
// },
// onError: (error) {
//         if (!emit.isDone) {
//           emit(ChatError("Error fetching chat rooms: $error"));
//         }
//         }
// );
final chatRooms =await _chatRepository.fetchChatRooms(event.userId);
emit(ChatRoomsLoaded(chatRooms));
  }catch(e){
    emit(ChatError("Error fetching chatrooms"));
  }
}
}
