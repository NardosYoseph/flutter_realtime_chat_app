import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/chat_bloc/chat_bloc.dart';

class ChatInputTextField extends StatelessWidget {
  ChatInputTextField({super.key,required this.controller,required this.userId});
  final TextEditingController controller;
  final String userId;

  @override
  Widget build(BuildContext context) {
  final chatBloc = context.read<ChatBloc>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final timestamp = DateTime.now();
              final message = controller.text.trim();
              if (message.isNotEmpty) {
                print("send button tapped");
                chatBloc.add(SendMessageEvent(userId, message,timestamp));
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }

}