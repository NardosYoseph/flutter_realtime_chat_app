import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/chat_bloc/chat_bloc.dart';

class ChatInputTextField extends StatelessWidget {
  ChatInputTextField({super.key,required this.controller,required this.userId,required this.receiverId});
  final TextEditingController controller;
  final String userId;
  final String receiverId;

  @override
  Widget build(BuildContext context) {
  final chatBloc = context.read<ChatBloc>();
final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: theme.textTheme.bodyLarge,
              decoration:  InputDecoration(
                hintText: "Type a message...",
                 hintStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
                filled: true,
                 fillColor: theme.colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              minLines: 1,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primary,
            ),
            child: IconButton(
            icon: Icon(Icons.send,color: theme.colorScheme.onPrimary),
            onPressed: () {
              final timestamp = DateTime.now();
              final message = controller.text.trim();
              if (message.isNotEmpty) {
                print("input receiverId: $receiverId");
                print("input senderid: $userId");
                print("send button tapped");
                chatBloc.add(SendMessageEvent(userId,receiverId, message,timestamp));
                controller.clear();
              }
            },
          ),)
        ],
      ),
    );
  }

}