import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/data/models/message.dart';

import '../../blocs/chat_bloc/chat_bloc.dart';

class DeleteMessageDialog extends StatelessWidget {
DeleteMessageDialog({super.key,required this.message});
Message message;

  @override
  Widget build(BuildContext context) {
  final chatBloc = context.read<ChatBloc>();
    return AlertDialog(
        title: const Text("Delete Message"),
        content: const Text("Are you sure you want to delete this message?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              chatBloc.add(DeleteMessageEvent(message.id));
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      
    );
  
  }
}
