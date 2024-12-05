import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';
import 'package:real_time_chat_app/data/models/chatRoom.dart';
import 'package:real_time_chat_app/ui/screens/chat_screen.dart';
import 'package:real_time_chat_app/ui/widgets/customAppbar.dart';
import 'package:real_time_chat_app/ui/widgets/customDrawer.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthenticatedState) {
      final userId = authState.userId;
    context.read<ChatBloc>().add(FetchChatRoomsEvent(userId));}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
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
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatRoomsLoaded) {
            final chatRooms = state.chatRooms;
            if (chatRooms.isEmpty) {
              return const Center(child: Text("No chat rooms available."));
            }

            return ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                final chatRoom = chatRooms[index];
                return ListTile(
                  title: Text(chatRoom.lastMessageSender!),
                  subtitle: Text(chatRoom.lastMessage!),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    context.read<ChatBloc>().add(SelectChatRoomEvent(chatRoom.id));
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ChatScreen(),
                    //   ),
                    // );
                  },
                );
              },
            );
          }  else if (state is ChatInitial) {
      // Explicitly handle the initial state
      return const Center(child: Text("Initializing chat rooms..."));
    } else {
      // Handle unexpected states
      return const Center(child: Text("Unable to load chat rooms."));
    }
        },
      ),
    );
  }
}
