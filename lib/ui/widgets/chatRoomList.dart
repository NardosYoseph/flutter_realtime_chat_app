import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';
import '../../data/models/chatRoom.dart';
import 'chatRoomTile.dart';

class ChatRoomsSection extends StatelessWidget {
  const ChatRoomsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatError) {
            _showErrorSnackbar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is ChatRoomLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatRoomsLoaded) {
            return _buildChatRoomsList(state.chatRooms);
          } else {
            return const Center(child: Text("Unable to load chat rooms."));
          }
        },
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildChatRoomsList(List<ChatRoom> chatRooms) {
    if (chatRooms.isEmpty) {
      return const Center(child: Text("No chat rooms available."));
    }
    return ListView.builder(
      itemCount: chatRooms.length,
      itemBuilder: (context, index) {
        final chatRoom = chatRooms[index];
        return ChatRoomTile(chatRoom: chatRoom);
      },
    );
  }
}
