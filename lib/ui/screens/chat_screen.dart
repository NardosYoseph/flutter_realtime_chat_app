import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:real_time_chat_app/ui/widgets/chatAppbar.dart';
import 'package:real_time_chat_app/ui/widgets/chatInpuTextField.dart';
import 'package:real_time_chat_app/ui/widgets/deleteMessageDialog.dart';
import 'package:real_time_chat_app/ui/widgets/messageBuble.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/chat_bloc/chat_bloc.dart';
class ChatScreen extends StatefulWidget {
final String receiverId;

 ChatScreen({Key? key, required this.receiverId}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _isFetching=false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    // Check if the user is near the top of the list
    if (_scrollController.position.pixels <= _scrollController.position.minScrollExtent + 50) {

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
  context.read<ChatBloc>();
  final authBloc = context.read<AuthBloc>();
          print('chat screen receiverId ${widget.receiverId}');
          

  return SafeArea(
    child: Scaffold(
      appBar: ChatAppBar(otherUserId: widget.receiverId),
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
           if (state is ChatLoaded || state is ChatError) {
          _isFetching = false; // Reset fetching flag
        }
          if (state is ChatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Error: Please try again later")),
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
          print('chat screen currentuserId $userId');
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
                           print('*********************inside loading more message');
        print(index==messages.length);
        print(state.hasReachedMax);
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final message = messages[index];
                      final isSentByMe = message.senderId == userId;
            print('receiverId ${widget.receiverId}');
                      print('isSentByMe $isSentByMe');
    
                      return GestureDetector(
                        onLongPress: (){showDialog(
      context: context,
      builder: (context) => DeleteMessageDialog(message: message),
    );},
                        child: Align(
                          alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: MessageBuble(message:message, isSentByMe:isSentByMe),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ChatInputTextField(controller: _controller, userId: userId, receiverId: widget.receiverId),
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
                        print("***************************loading more messages");
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          // child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final message = messages[index];
                      final isSentByMe = message.senderId == userId;
                      print("message: $message");
                       print('isSentByMe $isSentByMe');
                       print('message senderId ${message.senderId}');
                       print('message receiverId ${message.receiverId}');
                       print('current userid $userId');
    
                      return GestureDetector(
                        onLongPress: () {showDialog(
      context: context,
      builder: (context) => DeleteMessageDialog(message: message),
    );},
                        child: Align(
                          alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: MessageBuble(message:message, isSentByMe:isSentByMe),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ChatInputTextField(controller: _controller, userId: userId, receiverId: widget.receiverId),
          ],
          );
        }
        return const Center(child: Text("No messages available"));
      }
    
      if (state is ChatError) {
        return const Center(child: Text("Error occured ☹️. Check Your Device Date and Time."));
      }
    
      return const Center(child: Text("No messages available"));
    },
    
        ),
      ),
    ),
  );
}
 
}
