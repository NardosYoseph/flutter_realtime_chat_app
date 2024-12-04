import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/data/models/message.dart';
import 'package:real_time_chat_app/ui/widgets/customAppbar.dart';
import 'package:real_time_chat_app/ui/widgets/customDrawer.dart';

import '../../blocs/chat_bloc/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  String chatRoomId = 'chat_room_1'; // Example, this should be dynamic based on user chat rooms.

  @override
  void initState() {
    super.initState();
    // Dispatch event to load messages when chat screen starts.
    context.read<ChatBloc>().add(ChatStartedEvent(chatRoomId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      drawerScrimColor: Colors.white,
      appBar: CustomAppBar(),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatError) {
            // Show error if there's any
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ChatLoaded) {
            final messages = state.messages;
            return Column(
              children: [
                // Display messages
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return ListTile(
                        title: Text(message.content),
                        subtitle: Text(message.senderId),
                        trailing: Text(message.timestamp?.toLocal().toString() ?? ''),
                      );
                    },
                  ),
                ),
                // Message input field and send button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          final message = _controller.text;
                          if (message.isNotEmpty) {
                            // Send message event
                            context.read<ChatBloc>().add(SendMessageEvent(chatRoomId, 'user_id', message));
                            _controller.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('No messages found.'));
          }
        },
      ),
    );
  }
}
