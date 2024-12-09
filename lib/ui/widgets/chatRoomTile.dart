import 'package:flutter/material.dart';
import 'package:real_time_chat_app/data/models/chatRoom.dart';
import 'package:real_time_chat_app/ui/screens/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';

import 'package:flutter/material.dart';
import 'package:real_time_chat_app/data/models/chatRoom.dart';
import 'package:real_time_chat_app/ui/screens/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/auth_bloc/auth_bloc.dart'; // Import the intl package

class ChatRoomTile extends StatelessWidget {
  final ChatRoom chatRoom;

  const ChatRoomTile({Key? key, required this.chatRoom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 166, 6, 172), // Set the border color
            width: 2.0, // Optional: Set the border width
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Icon(Icons.person, size: 50),
      ),
      title: Text(
        chatRoom.otherUserName ?? "",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        _truncateMessage(chatRoom.lastMessage ?? "Start chat"),
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: Text(
        _formatTimestamp(chatRoom.lastMessageTimestamp),
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      onTap: () {
        final authBloc = context.read<AuthBloc>();
  final authState = authBloc.state;

  if (authState is AuthenticatedState) {
    final currentUserId = authState.userId;

    context.read<ChatBloc>().add(
      SelectChatRoomEvent(chatRoom.id, currentUserId),
    );
        context.read<ChatBloc>().add(SelectChatRoomEvent(chatRoom.id,currentUserId));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen()),
        );
       } },
    );
  }

  String _truncateMessage(String message, {int maxLength = 20}) {
    if (message.length > maxLength) {
      return '${message.substring(0, maxLength)}...';
    }
    return message;
  }

  String _formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) {
      return "00:00";
    }
    return DateFormat('hh:mm a').format(timestamp.toLocal());
  }
}
