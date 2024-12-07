import 'package:flutter/material.dart';
import 'package:real_time_chat_app/data/models/chatRoom.dart';
import 'package:real_time_chat_app/ui/screens/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';

class ChatRoomTile extends StatelessWidget {
  final ChatRoom chatRoom;

  const ChatRoomTile({Key? key, required this.chatRoom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 166, 6, 172), // Set the border color
                        width: 2.0, // Optional: Set the border width
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(Icons.person,size: 50,)),
      title: Text(chatRoom.otherUserName ?? "",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
      subtitle: Text(chatRoom.lastMessage ?? "Start chat"),
      trailing: Text(chatRoom.lastMessageTimestamp.toString() ?? "00"),
      onTap: () {
        context.read<ChatBloc>().add(SelectChatRoomEvent(chatRoom.id));
       Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen()),
                    );
      },
    );
  }
}
