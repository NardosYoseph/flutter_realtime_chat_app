import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/user_bloc/user_bloc.dart';
import 'package:real_time_chat_app/data/models/message.dart';
import 'package:real_time_chat_app/ui/screens/homeScreen.dart';
import 'package:real_time_chat_app/ui/widgets/customAppbar.dart';
import 'package:real_time_chat_app/ui/widgets/customDrawer.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/chat_bloc/chat_bloc.dart';

class ChatScreen extends StatefulWidget {

  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
String username='';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: CustomDrawer(),
      drawerScrimColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon:  Icon(Icons.arrow_back),onPressed: (){     Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );},),
         iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: const Color.fromARGB(255, 170, 18, 107),
      elevation: 20,
    title: BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoaded) {
          return Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 230, 5, 192), // Placeholder color
                child: Text(
                  state.otherUSerName.isNotEmpty
                      ? state.otherUSerName[0].toUpperCase()
                      : '?', // Display the first letter of the name or '?' if empty
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 10),
              Text(
                state.otherUSerName,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          );
        } else {
          return Text("...", style: TextStyle(color: Colors.white, fontSize: 18),);
        }
      },
    ),
  ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
           final userState = context.watch<UserBloc>().state;
          String username = '';
          if (userState is SelectedUserLoaded) {
            username = userState.user.username;
          }
          final authState = context.watch<AuthBloc>().state;
          String userId = '';
          if (authState is AuthenticatedState) {
            userId = authState.userId;
          }

          if (state is ChatLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ChatLoaded ) {
            final messages = state.messages;
            return Column(
              children: [
                // Text(  state.otherUSerName, style: TextStyle(color: Colors.black,fontSize: 16),),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isSentByMe = message.senderId == userId;
                      return Align(
        alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Column(
            crossAxisAlignment:
                isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isSentByMe
                      ? const Color.fromARGB(255, 175, 9, 161) // Color for sent messages
                      : const Color.fromARGB(255, 123, 119, 124), // Color for received messages
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: isSentByMe
                        ? Radius.circular(10)
                        : Radius.circular(0),
                    bottomRight: isSentByMe
                        ? Radius.circular(0)
                        : Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  message.content,
                  style: TextStyle(
                    color: isSentByMe ? Colors.white : Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                message.timestamp?.toLocal().toString() ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
                    },
                  ),
                ),
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
                                                       final authState = context.read<AuthBloc>().state;
                                                       final userState = context.read<UserBloc>().state;
    if (authState is AuthenticatedState) {
      print("user authenticated");
      String senderId = authState.userId;
      // if (userState is SelectedUserLoaded){
      // print("user selected");

      // String recipientId=userState.user.id;
                            context.read<ChatBloc>().add(
                                  SendMessageEvent(
                                    senderId,
                                    message
                                    // recipientId
                                  ),
                                );
                            _controller.clear();
                          // }
                          }}
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } 
          else if(state is ChatInitial){
            return Center(child: Text('Initializing...'));
          }
          else {
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
