import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';
import '../../data/models/chatRoom.dart';
import '../screens/userSearchScreen.dart';
import 'chatRoomTile.dart';

class ChatRoomsSection extends StatelessWidget {
  const ChatRoomsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        final authState= context.read<AuthBloc>().state;
        if(authState is AuthenticatedState){
          final userId=authState.userId;
        context.read<ChatBloc>().add(FetchChatRoomsEvent(userId));}
        },
      child: Expanded(
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
              // Copy and sort the chatRooms to avoid mutating the original list
              final sortedChatRooms = List<ChatRoom>.from(state.chatRooms)
                ..sort((a, b) {
                  final timestampA = a.lastMessageTimestamp;
                  final timestampB = b.lastMessageTimestamp;
      
                  // Handle null timestamps gracefully
                  if (timestampA == null && timestampB == null) return 0;
                  if (timestampA == null) return 1; // Nulls go to the end
                  if (timestampB == null) return -1;
      
                  return timestampB.compareTo(timestampA); // Sort descending
                });
      
              return _buildChatRoomsList(context, sortedChatRooms);
            } else {
              return const Center(child: Text("Unable to load chat rooms."));
            }
          },
        ),
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildChatRoomsList(BuildContext context, List<ChatRoom> chatRooms) {
    if (chatRooms.isEmpty) {
      return GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 20.0),
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Padding(
                  padding: EdgeInsets.only(bottom: value),
                  child: const Text(
                    '👋',
                    style: TextStyle(fontSize: 48.0),
                  ),
                );
              },
            ),
            const Center(
              child: Text(
                "Find friends to start chat.",
                style: TextStyle(
                  color: Color.fromARGB(255, 161, 1, 153),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchUserScreen()),
          );
        },
      );
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
