import 'package:flutter/material.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_state.dart';
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
import 'package:flutter/material.dart';
import 'package:real_time_chat_app/data/models/chatRoom.dart';
import 'package:real_time_chat_app/ui/screens/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';
import 'package:intl/intl.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';
import '../theme/appColors.dart';

class ChatRoomTile extends StatelessWidget {
  final ChatRoom chatRoom;

  const ChatRoomTile({Key? key, required this.chatRoom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;

    String? currentUserId;
    if (authState is AuthenticatedState) {
      currentUserId = authState.userId;
    }

    final isLastMessageFromCurrentUser = chatRoom.lastMessageSender == currentUserId;
    final hasUnreadMessages = chatRoom.unreadCount != null && chatRoom.unreadCount! > 0;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          if (authState is AuthenticatedState) {
            final currentUserId = authState.userId;
            context.read<ChatBloc>().add(
              SelectChatRoomEvent(chatRoom.id, currentUserId),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              // Leading Icon with Gradient Border
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const CircleAvatar(
                  radius: 24,
                 backgroundColor: AppColors.lightPrimary,
                  child: Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatRoom.otherUserName ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Last Message
                    Text(
                      _truncateMessage(chatRoom.lastMessage ?? "Start chat"),
                      style: const TextStyle(
                        // color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // Trailing Timestamp and Icons
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Timestamp
                  Text(
                    _formatTimestamp(chatRoom.lastMessageTimestamp),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isLastMessageFromCurrentUser)
                    Icon(
                      hasUnreadMessages ? Icons.done : Icons.done_all,
                      size: 16,
                      // color: hasUnreadMessages ? Colors.blue : Colors.grey,
                    )
                  else if (hasUnreadMessages)
                    CircleAvatar(
                      radius: 10,
                      // backgroundColor: Colors.red,
                      child: Text(
                        '${chatRoom.unreadCount}',
                        style: const TextStyle(
                          // color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
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