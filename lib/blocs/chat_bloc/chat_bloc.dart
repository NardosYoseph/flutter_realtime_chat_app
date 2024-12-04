import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:real_time_chat_app/data/models/message.dart';
import 'package:real_time_chat_app/data/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatRepository _chatRepository;
  ChatBloc(this._chatRepository) : super(ChatInitial()) {
  on<ChatStartedEvent>(_onchatStarted);
  on<SendMessageEvent>(_onSendMessage);
  }

Future<void>  _onchatStarted(ChatStartedEvent event,Emitter<ChatState> emit) async{
emit(ChatLoading());
try{
    print("inside fetch bloc to start message");

final messages= await _chatRepository.fetchMessages(event.chatRoomId);
emit(ChatLoaded(messages));
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
      
      // You can add logic here to refresh messages after sending
    } catch (e) {
      emit(ChatError("Failed to send message"));
    }
  }

}
