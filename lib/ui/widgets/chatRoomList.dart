import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';
import '../../data/models/chatRoom.dart';
import '../screens/userSearchScreen.dart';
import 'chatRoomTile.dart';

class ChatRoomsSection extends StatelessWidget {
   ChatRoomsSection({Key? key}) : super(key: key);
    
  @override
Widget build(BuildContext context) {
  final chatBloc = context.read<ChatBloc>();
    final authBloc = context.read<AuthBloc>();
  return Expanded(
    child: StreamBuilder<List<ChatRoom>>(
      stream: chatBloc.chatRoomStream,
      builder: (context, snapshot) {

        if (snapshot.connectionState ==ConnectionState.waiting && !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } if (snapshot.hasError) {
  return Center(child: Text("Error loading chatrooms: ${snapshot.error}"));
}

    final chatRooms = snapshot.data ?? [];
          final sortedChatRooms = List<ChatRoom>.from(chatRooms)
            ..sort((a, b) {
              final timestampA = a.lastMessageTimestamp;
              final timestampB = b.lastMessageTimestamp;
              if (timestampA == null && timestampB == null) return 0;
              if (timestampA == null) return 1; 
              if (timestampB == null) return -1;
              return timestampB.compareTo(timestampA);
            });

          return _buildChatRoomsList(context, sortedChatRooms);
        
      },
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
