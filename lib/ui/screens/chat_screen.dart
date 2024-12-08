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
String username='';
  @override
  void initState() {
    super.initState();
//  final userChatState=context.read<UserBloc>().state;
//  if(userChatState is SelectedUserLoaded){
//    final roomState=userChatState as SelectedUserLoaded;
//    username=roomState.user.username;
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
           final userState = context.watch<UserBloc>().state;
          String username = '';
          if (userState is SelectedUserLoaded) {
            username = userState.user.username;
          }

          if (state is ChatLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ChatLoaded ) {
            final messages = state.messages;
            return Column(
              children: [
                Text(  username, style: TextStyle(color: Colors.black,fontSize: 16),),
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
            return Center(child: Text('No messages found.'));
          }
        },
      ),
    );
  }
}
