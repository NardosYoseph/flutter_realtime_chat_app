import 'package:flutter/material.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:real_time_chat_app/data/models/chatRoom.dart';
import 'package:real_time_chat_app/ui/screens/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';

import 'package:intl/intl.dart';

import '../../blocs/auth_bloc/auth_bloc.dart'; 

class ChatRoomTile extends StatelessWidget {
  final ChatRoom chatRoom;

  const ChatRoomTile({Key? key, required this.chatRoom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;

    String? currentUserId;
    String? receiverId;
    if (authState is AuthenticatedState) {
      currentUserId = authState.userId;
      receiverId = chatRoom.getOtherUserId(currentUserId);
      print('tile Receiver ID: $receiverId');
      print('Current User ID: $currentUserId');
    }

    final isLastMessageFromCurrentUser = chatRoom.lastMessageSender == currentUserId;
    final hasUnreadMessages = chatRoom.unreadCount != null && chatRoom.unreadCount! > 0;

    return Card(
        margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: () {
          if (authState is AuthenticatedState) {
            final currentUserId = authState.userId;
            context.read<ChatBloc>().add(
              SelectChatRoomEvent(chatRoom.id, currentUserId),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen(receiverId: receiverId!,)),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child:  CircleAvatar(
                 radius: 24,
      backgroundColor: theme.colorScheme.primaryContainer,
      child: Icon(
        Icons.person,
        size: 24,
        color: theme.colorScheme.onPrimaryContainer,
      ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatRoom.otherUserName ?? "user",
                      
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _truncateMessage(chatRoom.lastMessage ??  "${chatRoom.otherUserName} joined the chat"),
                     style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatTimestamp(chatRoom.lastMessageTimestamp),
                    style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
                  ),
                  const SizedBox(height: 4),
                  if (isLastMessageFromCurrentUser)
                    Icon(
                      hasUnreadMessages ? Icons.done : Icons.done_all,
                      size: 16,
                      color: hasUnreadMessages 
                ? theme.colorScheme.onSurface.withOpacity(0.5)
                : theme.colorScheme.primary,
                    )
                  else if (hasUnreadMessages)
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: theme.colorScheme.primary,
                      child: Text(
                        '${chatRoom.unreadCount}',
                         style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onPrimary,
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
      return '';
    }
    return DateFormat('hh:mm a').format(timestamp.toLocal());
  }
}