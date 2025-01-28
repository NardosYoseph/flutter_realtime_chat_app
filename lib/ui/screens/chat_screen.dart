import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:real_time_chat_app/blocs/user_bloc/user_bloc.dart';
import 'package:real_time_chat_app/data/models/message.dart';
import 'package:real_time_chat_app/ui/screens/homeScreen.dart';
import 'package:real_time_chat_app/ui/widgets/customAppbar.dart';
import 'package:real_time_chat_app/ui/widgets/customDrawer.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/chat_bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:real_time_chat_app/data/models/message.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _isFetching=false;
DateTime? timestamp;
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    // Check if the user is near the top of the list
    if (_scrollController.position.pixels <= _scrollController.position.minScrollExtent + 50) {
      print('inside scroll top');
      print('inside scroll top');
      print('inside scroll top');
      final currentState = context.read<ChatBloc>().state;
      if (currentState is ChatLoaded && !_isFetching && !currentState.hasReachedMax) {
        if (currentState.messages.isNotEmpty && !_isFetching) {
          final lastMessageTimestamp = currentState.messages.last.timestamp;
          if (lastMessageTimestamp != null) {
            _isFetching = true;
            context.read<ChatBloc>().add(FetchMoreMessagesEvent(
                  currentState.chatRoomId,
                  lastMessageTimestamp,
                ));
          }
        }
      }
  }
}

@override
Widget build(BuildContext context) {
  final chatBloc = context.read<ChatBloc>();
  final authBloc = context.read<AuthBloc>();

  return Scaffold(
    appBar: AppBar(
      title: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoaded) {
            return Row(
              children: [
                CircleAvatar(
                  child: Text(
                    state.otherUSerName.isNotEmpty
                        ? state.otherUSerName[0].toUpperCase()
                        : '?',
                  ),
                ),
                const SizedBox(width: 8),
                Text(state.otherUSerName),
              ],
            );
          }
          return const Text("Chat");
        },
      ),
    ),
    body: BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
         if (state is ChatLoaded || state is ChatError) {
        _isFetching = false; // Reset fetching flag
      }
        if (state is ChatError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.errorMessage}")),
          );
        }
      },
      child: BlocBuilder<ChatBloc, ChatState>(
  builder: (context, state) {
    if (state is ChatLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ChatLoadingMore) {
      // Show existing messages with a loading indicator at the top
      final messages = state.messages;
      final authState = authBloc.state;

      if (authState is AuthenticatedState) {
        final userId = authState.userId;

        return Column(
          children: [
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                   itemCount: messages.length + (state.hasReachedMax ? 0 : 1), // Add 1 for loading indicator
                  itemBuilder: (context, index) {
                    if (index == messages.length && !state.hasReachedMax ) {
                         print('inside loading more message');
      print(index==messages.length);
      print(state.hasReachedMax);
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final message = messages[index];
                    final isSentByMe = message.senderId == userId;
                    return GestureDetector(
                      onLongPress: () => _showDeleteDialog(context, chatBloc, message),
                      child: Align(
                        alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: _buildMessageBubble(message, isSentByMe),
                      ),
                    );
                  },
                ),
              ),
            ),
            _buildMessageInput(chatBloc, userId),
          ],
        );
      }
      return const Center(child: Text("No messages available"));
    }

    if (state is ChatLoaded) {
      final messages = state.messages;
      final authState = authBloc.state;

      if (authState is AuthenticatedState) {
        final userId = authState.userId;

        return Column(
          children: [
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: messages.length + (state.hasReachedMax ? 0 : 1),
                  itemBuilder: (context, index) {
                    if (index == messages.length && !state.hasReachedMax) {
      print('inside message length');
      print(index==messages.length);
      print(state.hasReachedMax);
                     
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final message = messages[index];
                    final isSentByMe = message.senderId == userId;
                    return GestureDetector(
                      onLongPress: () => _showDeleteDialog(context, chatBloc, message),
                      child: Align(
                        alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: _buildMessageBubble(message, isSentByMe),
                      ),
                    );
                  },
                ),
              ),
            ),
            _buildMessageInput(chatBloc, userId),
          ],
        );
      }
      return const Center(child: Text("No messages available"));
    }

    if (state is ChatError) {
      return Center(child: Text(state.errorMessage));
    }

    return const Center(child: Text("No messages available"));
  },

      ),
    ),
  );
}


  Widget _buildMessageBubble(Message message, bool isSentByMe) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSentByMe ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment:
            isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message.content,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 4),
          
            _formatTimestamp(message.timestamp),
            // message.timestamp?.toLocal().toString() ?? '',
          
        ],
      ),
    );
  }

  Widget _buildMessageInput(ChatBloc chatBloc, String userId) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
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
              final message = _controller.text.trim();
              if (message.isNotEmpty) {
                print("send button tapped");
                chatBloc.add(SendMessageEvent(userId, message,timestamp));
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, ChatBloc chatBloc, Message message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
      ),
    );
  }

 Widget _formatTimestamp(DateTime? timestamp) {
  if (timestamp == null) {
    return const SizedBox(
      width: 16, // Adjust size as needed
      height: 16, // Adjust size as needed
      child: CircularProgressIndicator(
        strokeWidth: 2, // Adjust stroke width as needed
      ),
    );
  }
  return Text(
    DateFormat('hh:mm a').format(timestamp.toLocal()),
    style: const TextStyle(
      fontSize: 12, 
      color: Colors.white, 
    ),
  );
}
}
