import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/user_bloc/user_bloc.dart';
import 'package:real_time_chat_app/data/models/message.dart';
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
String chatRoomId='';
  @override
  void initState() {
    super.initState();
// final userChatState=context.read<UserBloc>().state;
// final chatRoomState=context.read<ChatBloc>().state;
// if(chatRoomState is ChatLoaded){
//   final roomState=chatRoomState as ChatLoaded;
//   chatRoomId=roomState.chatRoomId;
//   context.read<ChatBloc>().add(FetchChatRoomsEvent(chatRoomId));
// }
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
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ChatLoaded) {
            final messages = state.messages;
            return Column(
              children: [
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 177, 108, 171),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(
                                  message.content,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(message.timestamp?.toLocal().toString() ?? ''),
                              ],
                            ),
                          ],
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
    if (authState is AuthenticatedState) {
      String senderId = authState.userId;
      
                            context.read<ChatBloc>().add(
                                  SendMessageEvent(
                                    senderId,
                                    message
                                  ),
                                );}
                            _controller.clear();
                          }
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
            return Center(child: Text('No messages found.'));
          }
        },
      ),
    );
  }
}
